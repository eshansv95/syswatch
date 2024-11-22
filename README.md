SysWatch CLI Tool
---
Introduction
SysWatch is a lightweight and cross-platform command-line tool designed to provide detailed system information for macOS and Windows environments. Featuring color-coded outputs and customizable ASCII art, it ensures an enhanced user experience while delivering critical system insights such as CPU, GPU, memory, screen resolution, uptime, and more.

Features
Cross-platform support (macOS and Windows).
Comprehensive system details:
CPU and GPU information.
Operating System details.
Screen resolution and disk usage.
Memory statistics and architecture (32-bit/64-bit).
Clean and visually appealing output with color-coded text.
Expandable architecture for future enhancements.
Prerequisites
Operating System: macOS or Windows.
Bash Shell: Ensure that the bash shell is installed (default in macOS and available via Git Bash on Windows).
Commands Used:
macOS: system_profiler, sw_vers, df, zsh.
Windows: wmic, powershell, df.
Installation
Clone the repository:
git clone https://github.com/your-username/syswatch.git
cd syswatch
Make the script executable:
chmod +x syswatch.sh
Usage
Run the script using the following command:

./syswatch.sh
The tool will automatically detect your operating system and display relevant system information.

Example Output
macOS

Windows

Customization
You can modify the ASCII art or adjust the color schemes in the script:

Update the print_syswatch_ascii function for ASCII art.
Change ANSI escape codes for text colors.
Future Enhancements
Planned features for future versions include:

Support for Linux-based distributions.
Real-time performance monitoring.
Network statistics and analysis.
Exporting system data to JSON or log files.
Contribution
Contributions are welcome! To contribute:

Fork the repository.
Create a new branch (git checkout -b feature-branch-name).
Commit your changes (git commit -m 'Add feature').
Push to the branch (git push origin feature-branch-name).
Create a Pull Request.
License
This project is licensed under the MIT License.

Author
Developed by Eshan.
Feel free to reach out for feedback, suggestions, or contributions!

