# 🌍 AgentsVille Trip Planner

<div align="center">

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![OpenAI](https://img.shields.io/badge/OpenAI-GPT--4.1-green.svg)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

**An AI-powered trip planning system using advanced LLM techniques**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture) • [Documentation](#-documentation)

</div>

---

## 📖 Overview

AgentsVille Trip Planner is a sophisticated multi-stage AI assistant that generates personalized travel itineraries using Large Language Models (LLMs). The system employs advanced prompting techniques including Chain-of-Thought reasoning, ReAct prompting, and tool-using agents to create comprehensive, context-aware travel plans.

### 🎯 Key Capabilities

- **Intelligent Planning**: Generates detailed day-by-day itineraries based on traveler preferences
- **Weather-Aware**: Automatically adjusts activities based on weather conditions
- **Budget Management**: Ensures plans stay within specified budget constraints
- **Interest Matching**: Selects activities aligned with traveler interests
- **Self-Evaluation**: Uses multiple evaluation functions to validate itinerary quality
- **Iterative Refinement**: ReAct agent revises plans based on feedback and constraints

---

## ✨ Features

### 🤖 Two-Stage AI System

#### 1. **Expert Planner (Initial Itinerary Generation)**
- Acts as an expert travel planner
- Uses Chain-of-Thought reasoning for comprehensive planning
- Generates structured JSON output conforming to Pydantic models
- Considers weather, interests, budget, and constraints

#### 2. **Resourceful Assistant (ReAct Agent)**
- Implements THINK → ACT → OBSERVE cycle
- Uses tools to enhance and validate itineraries:
  - `calculator_tool`: Accurate cost calculations
  - `get_activities_by_date_tool`: Fetch alternative activities
  - `run_evals_tool`: Evaluate itinerary quality
  - `final_answer_tool`: Return validated plan
- Incorporates traveler feedback iteratively

### 🔍 Comprehensive Evaluation System

- ✅ Date matching validation
- ✅ Cost accuracy and budget compliance
- ✅ Activity authenticity (no hallucinations)
- ✅ Interest satisfaction checking
- ✅ Weather compatibility assessment
- ✅ Traveler feedback incorporation

### 🛠️ Advanced Techniques

- **Role-Based Prompting**: Clear agent roles and responsibilities
- **Chain-of-Thought (CoT)**: Step-by-step reasoning process
- **ReAct Prompting**: Reasoning + Acting in interleaved manner
- **Structured Output**: Pydantic models for type-safe data handling
- **LLM-Powered Evaluation**: Uses GPT models for complex assessments

---

## 🚀 Installation

### Prerequisites

- Python 3.8 or higher
- OpenAI API key (or Vocareum API key for Udacity students)
- Jupyter Notebook or JupyterLab

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/agentsville-trip-planner.git
   cd agentsville-trip-planner
   ```

2. **Create virtual environment** (recommended)
   ```bash
   python -m venv .venv
   
   # On Windows
   .venv\Scripts\activate
   
   # On macOS/Linux
   source .venv/bin/activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure API key**
   
   Edit Cell 4 in `project_starter.ipynb`:
   ```python
   client = OpenAI(
       base_url="https://openai.vocareum.com/v1",  # or OpenAI endpoint
       api_key="your-api-key-here"
   )
   ```

---

## 💻 Usage

### Quick Start (Automated)

**Windows:**
```bash
SETUP_AND_RUN.bat
```

This will:
1. Install required packages
2. Execute the notebook
3. Create submission ZIP file

### Manual Execution

1. **Start Jupyter**
   ```bash
   jupyter notebook project_starter.ipynb
   ```

2. **Run all cells**
   - In Jupyter: `Cell > Run All`
   - Wait 5-10 minutes for completion

3. **View results**
   - Initial itinerary in Cell 15
   - Revised itinerary in Cell 36
   - Evaluation results in Cell 37

### Python Script

```bash
python run_and_save_notebook.py
```

---

## 🏗️ Architecture

### Project Structure

```
agentsville-trip-planner/
├── project_starter.ipynb          # Main notebook with implementation
├── project_lib.py                 # Helper functions and models
├── run_and_save_notebook.py       # Automated execution script
├── SETUP_AND_RUN.bat             # Windows automation script
├── requirements.txt               # Python dependencies
├── README.md                      # This file
├── IMPORTANT_BEFORE_SUBMISSION.md # Submission instructions
└── اقرأني_أولاً.txt              # Arabic instructions
```

### Core Components

#### Pydantic Models
```python
- Interest: Enum of traveler interests
- Traveler: Name, age, interests
- VacationInfo: Travelers, destination, dates, budget
- Weather: Date, condition, temperature
- Activity: Event details, price, interests
- ActivityRecommendation: Activity + reasoning
- ItineraryDay: Date, weather, activities
- TravelPlan: Complete itinerary with all days
```

#### Agents

**ItineraryAgent**
- System prompt with role, task, output format, context
- Generates initial itinerary using Chain-of-Thought
- Returns structured TravelPlan object

**ItineraryRevisionAgent**
- Implements ReAct cycle (THINK-ACT-OBSERVE)
- Uses tools to refine itinerary
- Runs evaluations before finalizing
- Incorporates traveler feedback

#### Tools

| Tool | Purpose |
|------|---------|
| `calculator_tool` | Accurate arithmetic calculations |
| `get_activities_by_date_tool` | Fetch activities for specific dates |
| `run_evals_tool` | Run all evaluation functions |
| `final_answer_tool` | Return final validated itinerary |

#### Evaluation Functions

```python
- eval_start_end_dates_match()
- eval_total_cost_is_accurate()
- eval_total_cost_is_within_budget()
- eval_itinerary_events_match_actual_events()
- eval_itinerary_satisfies_interests()
- eval_activities_and_weather_are_compatible()
- eval_traveler_feedback_is_incorporated()
```

---

## 📊 Example Output

### Input
```json
{
  "travelers": [
    {"name": "Yuri", "age": 30, "interests": ["tennis", "cooking", "comedy", "technology"]},
    {"name": "Hiro", "age": 25, "interests": ["reading", "music", "theatre", "art"]}
  ],
  "destination": "AgentsVille",
  "date_of_arrival": "2025-06-10",
  "date_of_departure": "2025-06-12",
  "budget": 130
}
```

### Output
A comprehensive 3-day itinerary with:
- Weather-appropriate activities
- Interest-matched events
- Budget-compliant pricing
- Detailed recommendations
- Total cost calculation

---

## 🔧 Configuration

### OpenAI Models

The project supports multiple models:

```python
class OpenAIModel(str, Enum):
    GPT_41 = "gpt-4.1"           # Most capable
    GPT_41_MINI = "gpt-4.1-mini" # Balanced (default)
    GPT_41_NANO = "gpt-4.1-nano" # Fastest, cheapest
```

### Customization

**Modify vacation details** in Cell 7:
```python
VACATION_INFO_DICT = {
    "travelers": [...],
    "destination": "AgentsVille",
    "date_of_arrival": "2025-06-10",
    "date_of_departure": "2025-06-12",
    "budget": 130
}
```

**Adjust system prompts** in Cells 14, 22, and 34 for different behaviors.

---

## 📚 Documentation

### Key Files

- **`README.md`**: Project overview and usage
- **`IMPORTANT_BEFORE_SUBMISSION.md`**: Detailed submission instructions
- **`اقرأني_أولاً.txt`**: Arabic quick-start guide
- **`project_lib.py`**: Complete API documentation in docstrings

### Prompt Engineering

The project demonstrates three critical prompts:

1. **ITINERARY_AGENT_SYSTEM_PROMPT** (Cell 14)
   - Role, task, output format, context
   - Chain-of-Thought guidance

2. **ACTIVITY_AND_WEATHER_ARE_COMPATIBLE_SYSTEM_PROMPT** (Cell 22)
   - LLM-powered evaluation
   - Examples for few-shot learning

3. **ITINERARY_REVISION_AGENT_SYSTEM_PROMPT** (Cell 34)
   - ReAct cycle explanation
   - Tool descriptions and formats
   - Exit conditions

---

## 💰 Cost Estimation

Using `gpt-4.1-mini` (default):
- **Initial itinerary**: ~$0.20-0.30
- **Revision cycle**: ~$0.30-0.50
- **Evaluations**: ~$0.10-0.20
- **Total per run**: ~$0.50-1.00

---

## 🧪 Testing

### Verification Checklist

After execution, verify these outputs:

- [ ] Cell 8: VacationInfo validation success
- [ ] Cell 10: Weather DataFrame displayed
- [ ] Cell 11: Activities DataFrame displayed
- [ ] Cell 15: Initial itinerary generated
- [ ] Cell 35: THOUGHT/ACTION format validated
- [ ] Cell 36: Revised itinerary generated
- [ ] Cell 37: All evaluations passed

### Running Tests

All evaluation functions run automatically in Cell 37:
```python
eval_results = get_eval_results(
    vacation_info=vacation_info,
    final_output=travel_plan_2,
    eval_functions=ALL_EVAL_FUNCTIONS
)
```

---

## 🤝 Contributing

This project was created as part of the Udacity AI Programming course. Feel free to:

- Report issues
- Suggest improvements
- Fork and experiment
- Share your results

---

## 📝 License

MIT License - feel free to use this project for learning and development.

---

## 🙏 Acknowledgments

- **Udacity**: For the project framework and requirements
- **OpenAI**: For GPT models and API
- **Pydantic**: For data validation
- **Jupyter**: For interactive development

---

## 📧 Contact

For questions or feedback about this project, please open an issue on GitHub.

---

<div align="center">

**Built with ❤️ using OpenAI GPT-4.1 and Python**

[⬆ Back to Top](#-agentsville-trip-planner)

</div>
