
///
/// languageMap
/// Impressive! This language map is thorough and covers a diverse
/// range of languages. It's great for handling localization in your
/// application. If you have any questions or need assistance with 
/// anything related to this code or beyond, feel free to ask!
 const Map<String, Map<String, String>> LANGS = {
 // 'af': {'Afrikaans': 'Afrikaans'},
  'sq': {'Albanian': 'Shqiptar'},
  // 'am': {'Amharic': 'አማርኛ'},
  'ar': {'Arabic': 'العربية'},
  'hy': {'Armenian': 'Հայերեն'},
  'az': {'Azerbaijani': 'Azərbaycan dili'},
  'eu': {'Basque': 'Euskara'},
  'be': {'Belarusian': 'Беларуская мова'},
  'bn': {'Bengali': 'বাংলা'},
  'bs': {'Bosnian': 'Bosanski'},
  'bg': {'Bulgarian': 'Български'},
  // 'ca': {'Catalan': 'Català'},
  'zh-Hans': {'Chinese (Simplified)': '中文(简体)'},
  'zh-Hant': {'Chinese (Traditional)': '中文(繁體)'},
  'hr': {'Croatian': 'Hrvatski'},
  'cs': {'Czech': 'Čeština'},
  'da': {'Danish': 'Dansk'},
  'nl': {'Dutch': 'Nederlands'},
  'en': {'English': 'English'},
  'et': {'Estonian': 'Eesti'},
  'tl': {'Filipino': 'Filipino'},
  'fi': {'Finnish': 'Suomi'},
  'fr': {'French': 'Français'},
  'gl': {'Galician': 'Galego'},
  'ka': {'Georgian': 'ქართული'},
  'de': {'German': 'Deutsch'},
  'el': {'Greek': 'Ελληνικά'},
  'gu': {'Gujarati': 'ગુજરાતી'},
  'ht': {'Haitian Creole': 'Kreyòl Ayisyen'},
  'ha': {'Hausa': 'Hausa'},
  'haw': {'Hawaiian': 'ʻŌlelo Hawaiʻi'},
  'iw': {'Hebrew': 'עברית'},
  'hi': {'Hindi': 'हिन्दी'},
  'hmn': {'Hmong': 'Hmong'},
  'hu': {'Hungarian': 'Magyar'},
  'is': {'Icelandic': 'Íslenska'},
  'ig': {'Igbo': 'Igbo'},
  'id': {'Indonesian': 'Bahasa Indonesia'},
  'ga': {'Irish': 'Gaeilge'},
  'it': {'Italian': 'Italiano'},
  'ja': {'Japanese': '日本語'},
  'jw': {'Javanese': 'Basa Jawa'},
  'kn': {'Kannada': 'ಕನ್ನಡ'},
  'kk': {'Kazakh': 'Қазақ тілі'},
  'km': {'Khmer': 'ភាសាខ្មែរ'},
  'rw': {'Kinyarwanda': 'Kinyarwanda'},
  'ko': {'Korean': '한국어'},
  'ku': {'Kurdish (Kurmanji)': 'Kurdî (Kurmancî)'},
  'ky': {'Kyrgyz': 'Кыргызча'},
  'lo': {'Lao': 'ພາສາລາວ'},
  'la': {'Latin': 'Latine'},
  'lv': {'Latvian': 'Latviešu valoda'},
  'lt': {'Lithuanian': 'Lietuvių kalba'},
  'lb': {'Luxembourgish': 'Lëtzebuergesch'},
  'mk': {'Macedonian': 'Македонски'},
  'mg': {'Malagasy': 'Malagasy'},
  'ms': {'Malay': 'Bahasa Melayu'},
  'ml': {'Malayalam': 'മലയാളം'},
  'mt': {'Maltese': 'Malti'},
  'mi': {'Maori': 'Te Reo Māori'},
  'mr': {'Marathi': 'मराठी'},
  'mn': {'Mongolian': 'Монгол'},
  'my': {'Burmese': 'မြန်မာစာ'},
  'ne': {'Nepali': 'नेपाली'},
  'no': {'Norwegian': 'Norsk'},
  'ps': {'Pashto': 'پښتو'},
  'fa': {'Persian': 'فارسی'},
  'pl': {'Polish': 'Polski'},
  'pt': {'Portuguese': 'Português'},
  'pa': {'Punjabi': 'ਪੰਜਾਬੀ'},
  'ro': {'Romanian': 'Română'},
  'ru': {'Russian': 'Русский'},
  'sm': {'Samoan': 'Gagana Samoa'},
  'gd': {'Scots Gaelic': 'Gàidhlig na h-Alba'},
  'sr': {'Serbian': 'Српски'},
  'st': {'Sesotho': 'Sesotho'},
  'sn': {'Shona': 'ChiShona'},
  'sd': {'Sindhi': 'سنڌي'},
  'si': {'Sinhala': 'සිංහල'},
  'sk': {'Slovak': 'Slovenčina'},
  'sl': {'Slovenian': 'Slovenščina'},
  'so': {'Somali': 'Soomaali'},
  'es': {'Spanish': 'Español'},
  'su': {'Sundanese': 'Basa Sunda'},
  'sw': {'Swahili': 'Kiswahili'},
  'sv': {'Swedish': 'Svenska'},
  'tg': {'Tajik': 'Тоҷикӣ'},
  'ta': {'Tamil': 'தமிழ்'},
  'te': {'Telugu': 'తెలుగు'},
  'th': {'Thai': 'ไทย'},
  'tr': {'Turkish': 'Türkçe'},
  'uk': {'Ukrainian': 'Українська'},
  'ur': {'Urdu': 'اردو'},
  'ug': {'Uyghur': 'Uyƣurqə'},
  'uz': {'Uzbek': 'Oʻzbekcha'},
  'vi': {'Vietnamese': 'Tiếng Việt'},
  'cy': {'Welsh': 'Cymraeg'},
  'xh': {'Xhosa': 'isiXhosa'},
  'yi': {'Yiddish': 'ייִדיש'},
  'yo': {'Yoruba': 'Yorùbá'},
  'zu': {'Zulu': 'isiZulu'},
  'he': {'עברית': 'Hebrew'},
  'tt': {'Татар': 'Tatar'},
  'tk': {'Türkmen': 'Turkmen'},
  
};








///
// const String KEY_PATH_TO_CONFIG = 'arb.gen/config.json';
///
const String ERROR_MSG = """
\n
    Config doesn't exist!
    File not found at path 'arb.gen/config.json'
    ClI arguments are not compare for Configuration
    See details at the documentation
    """;

///
const String greet = '''

✅ Native splash complete.
Now go finish building something awesome! 💪 You rock! 🤘🤩
Like the package? Please give it a 👍 here: https://pub.dev/packages/flutter_native_splash
''';

const String WELCOME = '''
╔════════════════════════════════════════════════════════════════════════════╗
║                             Setting up flavors!                            ║
╚════════════════════════════════════════════════════════════════════════════╝
===> Setting up the  flavor.----
''';

const String whatsNew = '''
╔════════════════════════════════════════════════════════════════════════════╗
║                       NEED A GREAT FLUTTER DEVELOPER?                      ║
╠════════════════════════════════════════════════════════════════════════════╣
║                                                                            ║
║   I am available!  Find me at https://www.linkedin.com/in/hansonjon/       ║
║                                                                            ║
╚════════════════════════════════════════════════════════════════════════════╝
''';
const String flavors = '''
╔════════════════════════════════════════════════════════════════════════════╗
║                             Setting up flavors!                            ║
╚════════════════════════════════════════════════════════════════════════════╝
===> Setting up the  flavor.
''';
