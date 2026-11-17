<?php
/**
 * OpenRouter AI & Chatbot Configuration
 * Protected from direct HTTP access via .htaccess
 *
 * Place your API key in api/secrets.php (gitignored) or the OPENROUTER_API_KEY env var.
 */

if (file_exists(__DIR__ . '/secrets.php')) {
    require_once __DIR__ . '/secrets.php';
}

if (!defined('OPENROUTER_API_KEY')) {
    define('OPENROUTER_API_KEY', getenv('OPENROUTER_API_KEY') ?: '');
}

define('OPENROUTER_PRIMARY_MODEL', 'thinkingmachines/inkling-2-small:free');
define('OPENROUTER_FALLBACK_MODEL', 'nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free');
define('OPENROUTER_ENDPOINT', 'https://openrouter.ai/api/v1/chat/completions');
define('CHATBOT_SITE_URL', 'https://majulskgroup.com');
define('CHATBOT_SITE_NAME', 'Maju LSK Product Assistant');
