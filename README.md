⭐ Support us by starring the repo — it helps others discover it!

# 🐊 Gator - Blockchain Intelligence Platform

**Behavioral profiling for blockchain wallets.** Analyze who's behind a wallet using time patterns, gas behavior, reaction speeds, and transaction complexity.

---

Supports **Solana** and **EVM chains** (Ethereum, Base, Arbitrum, etc.)

---

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Set Up API Keys

Get your API keys:
- **Etherscan**: [etherscan.io/myapikey](https://etherscan.io/myapikey)
- **Helius (Solana)**: [dev.helius.xyz](https://dev.helius.xyz/dashboard/app)

Set environment variables:

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

Open your browser to `http://localhost:8000`

---

## 🎯 What It Does

Gator answers questions that standard block explorers can't:

- **Is this a bot or human?** (Reaction speed analysis: <5s = bot, >30s = human)
- **What timezone are they in?** (Sleep pattern detection)
- **Are these wallets connected?** (Network mapping & funding relationships)
- **What's their risk profile?** (MEV bot, whale, trader, DeFi user)

### Key Features

✅ **Circadian Rhythm Analysis** - Detect sleep patterns to identify timezone  
✅ **Bot Detection** - Reaction speed analysis with 70%+ accuracy  
✅ **Network Mapping** - Find connected wallets & funding sources  
✅ **Risk Profiling** - Behavioral classification (bot/whale/trader/degen)  
✅ **Web Interface** - Beautiful terminal-style dashboard  
✅ **Multi-Chain** - Solana + EVM (Ethereum, Base, Arbitrum)

---

## 🖥️ Command Line Usage

### Profile a Wallet

```bash
# Solana
python gator_solana.py profile 5Q544fKrFoe6tsEbD7S8EmxGTJYAKtTVhAW5Q5pge4j1 --limit 200

# Ethereum
python gator_evm.py profile 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum
```

### Find Connections Between Wallets

```bash
python gator_solana.py connect WalletA WalletB WalletC
```

### Network Scan (Solana Only)

Maps the target's network to N degrees of separation:

```bash
# Scan 2 degrees deep to find "friends of friends"
python gator_solana.py scan 5Q544fKrFoe... --depth 2

# Deep scan (3 degrees) - Warning: exponentially slower
python gator_solana.py scan 5Q544fKrFoe... --depth 3 --limit 50
```

### Live Stalker Mode (Real-Time Monitoring)

```bash
# Monitor wallet in real-time via WebSocket
python stalker_service.py 5Q544fKrFoe6tsEbD7S8EmxGTJYAKtTVhAW5Q5pge4j1
```

---

## 📊 How It Works

### 1. Reaction Speed Analysis (Bot Detection)

Measures the time between **receiving tokens** and **taking action** (selling, swapping, transferring).

- **Instant (<5s)**: Bot with high confidence
- **Fast (5-30s)**: Likely bot  
- **Human (>30s)**: Normal human behavior

**Example Output:**
```
REACTION SPEED ANALYSIS
Reaction Pairs:     64
Avg Reaction:       17.44s
Bot Confidence:     70.0%
[WARNING] HIGH BOT PROBABILITY
```

### 2. Circadian Rhythm (Timezone Detection)

Analyzes hourly transaction patterns to detect 4-6 hour "sleep windows":

- Gap at 02:00 UTC → **Europe**
- Gap at 08:00 UTC → **USA (East Coast)**
- Gap at 22:00 UTC → **Asia**

Bots show **no sleep pattern** or activity during human sleep hours.

### 3. Behavioral Profiling

Classifies wallets based on:
- **Transaction complexity** (gas/compute units)
- **Transaction frequency** (bot vs casual user)
- **Time patterns** (work hours vs random)
- **Network connections** (mixer usage, funding sources)

---

## 🛠️ Developer Guide

### Architecture

```
Gator/
├── gator_solana.py       # Solana analysis engine
├── gator_evm.py          # EVM analysis engine
├── backend_api.py        # FastAPI routes
├── run_server.py         # Server startup
├── stalker_service.py    # Real-time monitoring
├── jito_scan.py          # Jito MEV analysis
├── jito_inspect.py       # Jito transaction inspector
├── static/
│   └── index.html        # Web dashboard
├── requirements.txt
└── README.md
```

### Building a Custom Frontend

**Do not call scripts via `subprocess`.** Import functions directly:

```python
# backend.py (FastAPI)
from fastapi import FastAPI
from gator_solana import analyze_wallet, calculate_probabilities, detect_sleep_window
from gator_evm import analyze_wallet as analyze_wallet_evm

app = FastAPI()

@app.get("/profile/{address}")
def get_profile(address: str, chain: str = "solana"):
    # 1. Run analysis
    if chain == "solana":
        df = analyze_wallet(address)
    else:
        df, tx_details = analyze_wallet_evm(address, chain)
    
    # 2. Process metrics
    hourly_counts = [0] * 24
    daily_counts = [0] * 7
    for _, row in df.iterrows():
        hourly_counts[row["hour"]] += 1
        daily_counts[row["day_of_week"]] += 1
        
    sleep = detect_sleep_window(hourly_counts)
    probs = calculate_probabilities(df, hourly_counts, daily_counts, sleep)
    
    # 3. Return JSON
    return {
        "probabilities": probs.__dict__,
        "sleep_window": sleep.__dict__,
        "hourly_activity": hourly_counts,
        "transactions": df.to_dict(orient="records")
    }
```

### Visualization Requirements

Your frontend should display **4 key panels**:

#### Panel 1: Sleep Window (Timezone Leak)
- **Data**: `hourly_counts` (0-23 UTC)
- **Component**: Bar Chart
- **Goal**: Highlight the 4-6 hour gap where activity drops to near zero
- **Color Code**: Green for active hours, Red for sleep window

#### Panel 2: Complexity Map (Scatter Plot)
- **Data**: X = `hour`, Y = `compute_units` (Solana) or `gas_used` (EVM)
- **Component**: Scatter Plot
- **Color Code**: 
  - 🟢 Green: Low compute (simple transfers)
  - 🔴 Red: High compute (complex DeFi/mixers)
- **Bot Detection**: Red dots during sleep hours = likely bot

#### Panel 3: Risk Radar
- **Data**: `probs` object (bot %, whale %, degen %)
- **Component**: Progress bars or radar chart
- **Goal**: Show likelihood of bot vs human

#### Panel 4: Reaction Speed
- **Data**: `reaction` object from `analyze_reaction_speed()`
- **Component**: Bar chart (instant/fast/human distribution)
- **Goal**: Visualize bot confidence score

### Customizing Detection Logic

#### 1. Adjust Bot Detection Thresholds

```python
# gator_solana.py or gator_evm.py
# In analyze_reaction_speed()

# Make it stricter (only flag super-fast bots):
if time_delta < 2:  # Instead of 5
    instant_count += 1

# Or adjust bot confidence:
if instant_ratio > 0.5:  # Instead of 0.7
    bot_confidence = 95.0
```

#### 2. Adjust Whale Thresholds

```python
# gator_solana.py
# In calculate_probabilities()

if avg_cu > 500000:  # Instead of 300000
    probs.whale = 85
```

#### 3. Customize Network Depth Logic

```python
# gator_solana.py
# In scan_network()

# Only follow connections where value > 10 SOL
if tx_value > 10:
    next_level.add(account)
```

#### 4. Add Known Wallet Labels

```python
# At top of gator_solana.py or gator_evm.py
KNOWN_LABELS = {
    "YourWalletAddress": "Company Treasury",
    "CompetitorAddress": "Competitor Wallet",
    # Add more...
}
```

---

## 🔒 Privacy & Ethics

- **Only uses public blockchain data**
- **No private keys or encryption breaking**
- **Educational and research purposes only**

All transaction data is publicly available on-chain. Gator simply aggregates and analyzes behavioral patterns.

---

## 📝 License

MIT License - Free for educational and research purposes

---

**Built for OSINT researchers, security analysts, and blockchain investigators.**
