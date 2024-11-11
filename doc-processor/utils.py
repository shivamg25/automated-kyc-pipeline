from typing import Optional

def extract_english_name(mention_text: str) -> Optional[str]:
    """ Extracts the English part of a name from the given text. """
    parts = mention_text.split("\n")
    for part in parts:
        if part.isascii():
            return part.strip()
    return None

def clean_value(value: str, entity_type: str) -> str:
    """ Cleans the entity values based on the type. """
    if entity_type == "Address":
        value = value.replace("\n", ", ")
    elif entity_type in ["Passport_Number", "Aadhaar_Number", "PAN_Number", "VoterID_Number"]:
        value = ''.join(char for char in value if char.isalnum())
    elif entity_type == "Gender":
        value = {'M': "Male", 'F': "Female", 'T': "Transgender"}.get(value, value)
        if not any(word in value for word in ["Male", "Female", "Third Gender", "Transgender"]):
            value = ''.join(char for char in value if char.isascii())
    return value
