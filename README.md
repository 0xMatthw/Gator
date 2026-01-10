⭐ Support us by starring the repo — it helps others discover it!

# 🐊 Gator - Blockchain Intelligence Platform

**Behavioral profiling for blockchain wallets.** Analyze wallet activity using time patterns, gas behavior, reaction speeds, and transaction complexity to gain insights into wallet ownership and behavior.

---

Supports **Solana** and **EVM chains** (Ethereum, Base, Arbitrum, and more)

---

## 🎯 What It Does

Gator provides advanced blockchain intelligence that goes beyond standard block explorers. It answers critical questions through behavioral analysis:

- **Bot or Human?** - Reaction speed analysis identifies automated behavior (reactions <5s indicate bots, >30s suggest human activity)
- **Geographic Location** - Timezone detection through sleep pattern analysis
- **Wallet Connections** - Network mapping reveals funding relationships and connected wallets
- **Risk Assessment** - Behavioral classification identifies MEV bots, whales, traders, and DeFi users

### Key Features

✅ **Circadian Rhythm Analysis** - Detect sleep patterns to identify timezone and geographic location  
✅ **Bot Detection** - Reaction speed analysis with 70%+ accuracy for automated behavior identification  
✅ **Network Mapping** - Discover connected wallets and funding sources  
✅ **Risk Profiling** - Behavioral classification (bot/whale/trader/degen)  
✅ **Web Interface** - Modern terminal-style dashboard  
✅ **Multi-Chain Support** - Analyze Solana and EVM chains (Ethereum, Base, Arbitrum, and more)

---

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Set Up API Keys

Obtain your API keys:
- **Etherscan**: [etherscan.io/myapikey](https://etherscan.io/myapikey)
- **Helius (Solana)**: [dev.helius.xyz](https://dev.helius.xyz/dashboard/app)

Configure environment variables:

```bash
# Mac/Linux
export ETHERSCAN_API_KEY="your_key_here"
export HELIUS_API_KEY="your_key_here"

# Windows (PowerShell)
$env:ETHERSCAN_API_KEY="your_key_here"
$env:HELIUS_API_KEY="your_key_here"
```

### 3. Start the Server

```bash
# Windows
START_SERVER.bat

# Mac/Linux
python run_server.py
```

Access the web interface at `http://localhost:8000`

---

## 🖥️ Command Line Usage

### Profile a Wallet

Generate a comprehensive behavioral profile for any wallet:

```bash
# Solana
python gator_solana.py profile 5Q544fKrFoe6tsEbD7S8EmxGTJYAKtTVhAW5Q5pge4j1 --limit 200

# Ethereum
python gator_evm.py profile 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum
```

### Find Connections Between Wallets

Analyze relationships and connections between multiple wallets:

```bash
python gator_solana.py connect WalletA WalletB WalletC
```

### Network Scan (Solana Only)

Map the target's network connections to N degrees of separation:

```bash
# Scan 2 degrees deep to find "friends of friends"
python gator_solana.py scan 5Q544fKrFoe... --depth 2

# Deep scan (3 degrees) - Warning: exponentially slower
python gator_solana.py scan 5Q544fKrFoe... --depth 3 --limit 50
```

### Real-Time Monitoring

Monitor wallet activity in real-time via WebSocket:

```bash
python stalker_service.py 5Q544fKrFoe6tsEbD7S8EmxGTJYAKtTVhAW5Q5pge4j1
```

---

## 📊 How It Works

### 1. Reaction Speed Analysis (Bot Detection)

Gator measures the time between receiving tokens and taking action (selling, swapping, transferring). This metric is a strong indicator of automated behavior.

- **Instant (<5s)**: High confidence bot detection
- **Fast (5-30s)**: Likely automated behavior  
- **Human (>30s)**: Normal human response patterns

**Example Output:**
```
REACTION SPEED ANALYSIS
Reaction Pairs:     64
Avg Reaction:       17.44s
Bot Confidence:     70.0%
[WARNING] HIGH BOT PROBABILITY
```

### 2. Circadian Rhythm Analysis (Timezone Detection)

By analyzing hourly transaction patterns, Gator identifies 4-6 hour inactivity windows that correspond to sleep patterns:

- Activity gap at 02:00 UTC → **Europe**
- Activity gap at 08:00 UTC → **USA (East Coast)**
- Activity gap at 22:00 UTC → **Asia**

Automated bots typically show no sleep pattern and may exhibit activity during typical human sleep hours.

### 3. Behavioral Profiling

Wallets are classified using multiple behavioral indicators:
- **Transaction complexity** (gas/compute units)
- **Transaction frequency** (automated vs casual user patterns)
- **Time patterns** (work hours vs random distribution)
- **Network connections** (mixer usage, funding sources)

---

## 🔒 Privacy & Ethics

Gator operates entirely on publicly available blockchain data. All information analyzed is already accessible through standard block explorers and blockchain APIs.

- **Public Data Only** - Analyzes only publicly available on-chain transaction data
- **No Private Key Access** - Does not require or access private keys or encrypted data
- **Transparent Analysis** - All methods are open-source and verifiable

This tool is designed for legitimate research, security analysis, and blockchain investigation purposes.

---

## 📝 License

MIT License - Free for educational and research purposes.

---

**Designed for OSINT researchers, security analysts, and blockchain investigators.**
