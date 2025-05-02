import os
from typing import Dict

class SimpleFeatureFlags:
    def __init__(self):
        # Feature flags stored in environment variables or defaults
        self.flags = {
            "new_ui": os.getenv("FEATURE_NEW_UI", "false").lower() == "true",
            "beta_features": os.getenv("FEATURE_BETA", "false").lower() == "true",
            "advanced_monitoring": os.getenv("FEATURE_ADVANCED_MONITORING", "true").lower() == "true",
            "chaos_engineering": os.getenv("FEATURE_CHAOS", "false").lower() == "true"
        }
    
    def is_enabled(self, feature: str) -> bool:
        """Check if a feature flag is enabled"""
        return self.flags.get(feature, False)
    
    def get_all_flags(self) -> Dict[str, bool]:
        """Get all feature flags"""
        return self.flags.copy()

# Global instance
feature_flags = SimpleFeatureFlags()

def is_feature_enabled(feature: str) -> bool:
    """Simple feature flag check"""
    return feature_flags.is_enabled(feature) 