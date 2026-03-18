import time
import questionary
from rich.console import Console
from rich.progress import Progress, BarColumn, TimeRemainingColumn

def start_timer(minutes: int):
    console = Console()
    total_seconds = minutes * 60

    with Progress(
        "[progress.description]{task.description}",
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.0f}%",
        TimeRemainingColumn(),
        transient=True,
    ) as progress:
        task = progress.add_task(f"[cyan]Timer for {minutes} minute(s)", total=total_seconds)

        for _ in range(total_seconds):
            time.sleep(1)
            progress.update(task, advance=1)

    console.print("\n[bold green]⏰ Time's up![/bold green]\a")

def main():
    try:
        minutes = questionary.text("⏳ Enter time in minutes:", validate=lambda text: text.isdigit()).ask()
        if minutes:
            start_timer(int(minutes))
    except KeyboardInterrupt:
        print("\n⛔ Timer cancelled.")

if __name__ == "__main__":
    main()

