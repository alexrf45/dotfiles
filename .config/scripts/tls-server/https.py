import http.server
import ssl
import socketserver
import os
import base64
import secrets
import string
import ipaddress
import argparse
from datetime import datetime, timedelta
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa
try:
    from rich.console import Console
    console = Console()
    HAS_RICH = True
except ImportError:
    HAS_RICH = False

    class SimpleConsole:
        def print(self, message):
            # Remove rich markup for plain output
            import re
            clean_message = re.sub(r'\[.*?\]', '', str(message))
            print(clean_message)
    console = SimpleConsole()

# Default Configuration
DEFAULT_CERT_DIR = "/home/fr3d/.local/certs"
DEFAULT_IP = '127.0.0.1'
DEFAULT_PORT = 8443
DEFAULT_USERNAME = "admin"
DEFAULT_PASSWORD = "ctf123"

# Global configuration variables (will be set by command line args or defaults)
CERT_DIR = DEFAULT_CERT_DIR
CERT_FILE = None
KEY_FILE = None
IP = DEFAULT_IP
PORT = DEFAULT_PORT
USERNAME = DEFAULT_USERNAME
PASSWORD = DEFAULT_PASSWORD


def generate_password(length=12):
    """Generate a secure random password"""
    alphabet = string.ascii_letters + string.digits + "!@#$%^&*"
    return ''.join(secrets.choice(alphabet) for _ in range(length))


def generate_self_signed_cert(cert_file, key_file):
    """Generate a self-signed SSL certificate"""
    console.print(
        "[bold yellow]Generating self-signed SSL certificate...[/bold yellow]")

    # Ensure directory exists
    os.makedirs(os.path.dirname(cert_file), exist_ok=True)

    # Generate private key
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048,
    )

    # Create certificate
    subject = issuer = x509.Name([
        x509.NameAttribute(NameOID.COUNTRY_NAME, "US"),
        x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, "Lab"),
        x509.NameAttribute(NameOID.LOCALITY_NAME, "CTF"),
        x509.NameAttribute(NameOID.ORGANIZATION_NAME, "Lab Server"),
        x509.NameAttribute(NameOID.COMMON_NAME, "localhost"),
    ])

    cert = x509.CertificateBuilder().subject_name(
        subject
    ).issuer_name(
        issuer
    ).public_key(
        private_key.public_key()
    ).serial_number(
        x509.random_serial_number()
    ).not_valid_before(
        datetime.now(datetime.UTC)
    ).not_valid_after(
        datetime.now(datetime.UTC) + timedelta(days=365)
    ).add_extension(
        x509.SubjectAlternativeName([
            x509.DNSName("localhost"),
            x509.IPAddress(ipaddress.IPv4Address("127.0.0.1")),
        ]),
        critical=False,
    ).sign(private_key, hashes.SHA256())

    # Write certificate to file
    with open(cert_file, "wb") as f:
        f.write(cert.public_bytes(serialization.Encoding.PEM))

    # Write private key to file
    with open(key_file, "wb") as f:
        f.write(private_key.private_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PrivateFormat.PKCS8,
            encryption_algorithm=serialization.NoEncryption()
        ))

    console.print(
        f"[bold green]SSL certificate generated:[/bold green] {cert_file}")
    console.print(
        f"[bold green]Private key generated:[/bold green] {key_file}")


class AuthHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """HTTP Request Handler with Basic Authentication"""

    def do_AUTHHEAD(self):
        """Send authentication required response"""
        self.send_response(401)
        self.send_header('WWW-Authenticate', 'Basic realm="CTF Lab Server"')
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        """Handle GET requests with authentication"""
        if not self.check_auth():
            self.do_AUTHHEAD()
            self.wfile.write(b'Authentication required')
            return
        return super().do_GET()

    def do_POST(self):
        """Handle POST requests with authentication"""
        if not self.check_auth():
            self.do_AUTHHEAD()
            self.wfile.write(b'Authentication required')
            return
        return super().do_POST()

    def check_auth(self):
        """Check if the request has valid authentication"""
        auth_header = self.headers.get('Authorization')
        if auth_header is None:
            return False

        if not auth_header.startswith('Basic '):
            return False

        try:
            encoded_credentials = auth_header[6:]  # Remove 'Basic ' prefix
            decoded_credentials = base64.b64decode(
                encoded_credentials).decode('utf-8')
            username, password = decoded_credentials.split(':', 1)
            return username == USERNAME and password == PASSWORD
        except Exception:
            return False

    def log_message(self, format, *args):
        """Override to add colored logging"""
        console.print(
            f"[bold cyan]{self.address_string()}[/bold cyan] - {format % args}")


def parse_arguments():
    """Parse command line arguments"""
    parser = argparse.ArgumentParser(
        description='HTTPS Server with Basic Auth for CTF/Lab use')
    parser.add_argument('--ip', default=DEFAULT_IP,
                        help=f'IP address to bind to (default: {DEFAULT_IP})')
    parser.add_argument('--port', type=int, default=DEFAULT_PORT,
                        help=f'Port to bind to (default: {DEFAULT_PORT})')
    parser.add_argument('--username', default=DEFAULT_USERNAME,
                        help=f'Username for basic auth (default: {DEFAULT_USERNAME})')
    parser.add_argument('--password', default=DEFAULT_PASSWORD,
                        help=f'Password for basic auth (default: {DEFAULT_PASSWORD})')
    parser.add_argument('--cert-dir', default=DEFAULT_CERT_DIR,
                        help=f'Directory for SSL certificates (default: {DEFAULT_CERT_DIR})')
    parser.add_argument('--generate-password',
                        action='store_true', help='Generate a random password')
    return parser.parse_args()


def main():
    """Main server function"""
    global IP, PORT, USERNAME, PASSWORD, CERT_FILE, KEY_FILE, CERT_DIR

    # Parse command line arguments
    args = parse_arguments()

    IP = args.ip
    PORT = args.port
    USERNAME = args.username
    CERT_DIR = args.cert_dir
    CERT_FILE = os.path.join(CERT_DIR, "cert.pem")
    KEY_FILE = os.path.join(CERT_DIR, "key.pem")

    # Generate random password if requested
    if args.generate_password:
        PASSWORD = generate_password()
        console.print(f"[bold magenta]Generated password: {
                      PASSWORD}[/bold magenta]")
    else:
        PASSWORD = args.password

    # Check if certificates exist, generate if not
    if not os.path.exists(CERT_FILE) or not os.path.exists(KEY_FILE):
        try:
            generate_self_signed_cert(CERT_FILE, KEY_FILE)
        except ImportError:
            console.print(
                "[bold red]Error: cryptography library not found. Install with: pip install cryptography[/bold red]")
            return
    else:
        console.print(
            f"[bold green]Using existing certificates:[/bold green] {CERT_FILE}")

    # Create SSL context
    context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    try:
        context.load_cert_chain(CERT_FILE, keyfile=KEY_FILE, password=None)
    except Exception as e:
        console.print(f"[bold red]Error loading certificates: {e}[/bold red]")
        console.print(
            "[bold yellow]Regenerating certificates...[/bold yellow]")
        generate_self_signed_cert(CERT_FILE, KEY_FILE)
        context.load_cert_chain(CERT_FILE, keyfile=KEY_FILE, password=None)

    server_address = (IP, PORT)

    # Create server with authentication handler
    with socketserver.TCPServer(server_address, AuthHTTPRequestHandler) as httpd:
        httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

        console.print("[bold green]🔒 HTTPS Server[/bold green]")
        console.print(
            f"[bold white]Server running at: https://{IP}:{PORT}[/bold white]")
        console.print(f"[bold yellow]Username: {USERNAME}[/bold yellow]")
        console.print(f"[bold yellow]Password: {PASSWORD}[/bold yellow]")
        console.print("[dim]Press Ctrl+C to stop the server[/dim]")

        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            console.print('\n[bold blue]Server stopped[/bold blue]')


if __name__ == "__main__":
    main()
