A simple **Windows Batch Network Scanner** that automatically scans your local network for active IP addresses.  
It also attempts to resolve hostnames using **NSLookup**.

⚠️ **For educational purposes and use only on your own network!**

+ 📌 Features

- Automatically detects your **default gateway**
- Determines the local **subnet**
- Scans all IPs in parallel (`1–254`) using `ping`
- Multiple scan repetitions for more accurate results
- Stores all active IP addresses
- Resolves hostnames with **NSLookup**
- Saves results to `output_scan.txt`
- Simple and user-friendly menu interface

+ 🖥️ Requirements

- Windows OS
- Administrator privileges recommended
- Required Windows commands:
  - `ping`
  - `ipconfig`
  - `nslookup`
- Active network connection

+ 🚀 How to Use

1. Clone this repository or download the `.bat` file
2. Run the file by **double-clicking** or via **CMD**
3. Menu options:
   - `[1]` Start Network Scanner
   - `[2]` Exit
4. Enter the number of repetitions  
   *(Default: 20 – higher values = more accurate results)*

+ ⚙️ How It Works

1. Detects the **default gateway**
2. Determines the subnet (e.g., `192.168.1.x`)
3. Pings all IPs from `1` to `254`
4. Repeats the scan multiple times
5. Saves unique active IPs
6. Runs `nslookup` for each IP
7. Outputs results to:
   - **Console**
   - **output_scan.txt**

+ 📂 Generated Files

| File | Description |
|------|-------------|
| `ips.txt` | Temporary list of all detected IPs |
| `hits/` | Temporary storage during scanning |
| `output_scan.txt` | Final scan results |

All temporary files are deleted after the scan completes.

+ 📄 Output

```output_scan.txt
192.168.1.1 - router.local
192.168.1.10 - DESKTOP-PC
192.168.1.25 - Unknown
