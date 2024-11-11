import os
import logging

# Constants (Set your GCP settings)
PROJECT_ID = os.environ["PROJECT_ID"]
LOCATION = os.environ["LOCATION"]
PROCESSOR_ID = os.environ["PROCESSOR_ID"]
DESTINATION_BUCKET = os.environ["DESTINATION_BUCKET"]

# Initialize the logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)