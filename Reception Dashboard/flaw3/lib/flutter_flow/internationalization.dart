import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? frText = '',
  }) =>
      [enText, frText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // login
  {
    'l9jjj9il': {
      'en': 'Ma Clinique',
      'fr': '',
    },
    'atcd269y': {
      'en': 'Welcome Back',
      'fr': '',
    },
    'u5fvqwbo': {
      'en': 'Let\'s get started by filling out the form below.',
      'fr': '',
    },
    'dd9qhah2': {
      'en': 'Email',
      'fr': '',
    },
    '2d6gvagv': {
      'en': 'Password',
      'fr': '',
    },
    'eqha053m': {
      'en': 'Sign In',
      'fr': '',
    },
    '77g3b83f': {
      'en': 'Home',
      'fr': '',
    },
  },
  // Calendar
  {
    'q1p7ssgc': {
      'en': 'Ma Clinique',
      'fr': '',
    },
    'ag0x6ccb': {
      'en': 'Platform Navigation',
      'fr': '',
    },
    'ulxfbmr8': {
      'en': 'Calendar',
      'fr': '',
    },
    'o8qfnobd': {
      'en': 'Treatments',
      'fr': '',
    },
    'nfd48fl9': {
      'en': 'Patients',
      'fr': '',
    },
    'bmslhm0y': {
      'en': 'Coming Soon',
      'fr': '',
    },
    'gxupogce': {
      'en': 'Dashboard',
      'fr': '',
    },
    'fxkz2pxr': {
      'en': 'Chats',
      'fr': '',
    },
    'rq6bonfi': {
      'en': 'Billing',
      'fr': '',
    },
    '1vfphlg2': {
      'en': 'Analytics',
      'fr': '',
    },
    'fiqjpcxd': {
      'en': 'Calendar',
      'fr': '',
    },
    '21ph54zx': {
      'en': 'Home',
      'fr': '',
    },
  },
  // Treatments
  {
    'jorqq5u3': {
      'en': 'Ma Clinique',
      'fr': '',
    },
    'burmmi6c': {
      'en': 'Platform Navigation',
      'fr': '',
    },
    'p3nvxgvw': {
      'en': 'Calendar',
      'fr': '',
    },
    's4wdget7': {
      'en': 'Treatments',
      'fr': '',
    },
    '37eogy8m': {
      'en': 'Patients',
      'fr': '',
    },
    'vle76qso': {
      'en': 'Coming Soon',
      'fr': '',
    },
    'zamf05gl': {
      'en': 'Dashboard',
      'fr': '',
    },
    'm8b6pppz': {
      'en': 'Chats',
      'fr': '',
    },
    'mxb4522w': {
      'en': 'Billing',
      'fr': '',
    },
    'ouk8n2uy': {
      'en': 'Analytics',
      'fr': '',
    },
    'fbefk4n6': {
      'en': 'Light Mode',
      'fr': '',
    },
    'ix906ndh': {
      'en': 'Dark Mode',
      'fr': '',
    },
    '9qy5i2hr': {
      'en': 'Treatments',
      'fr': '',
    },
    'vhtsd5hu': {
      'en': 'New Treatment',
      'fr': '',
    },
    'q1cmq1mn': {
      'en': 'Categorie',
      'fr': '',
    },
    'whmq2ke0': {
      'en': 'Search...',
      'fr': '',
    },
    'i6nldwy5': {
      'en': 'Soins Visage',
      'fr': '',
    },
    '18xbhg6b': {
      'en': 'Trt Esthetique',
      'fr': '',
    },
    'vkty0q3z': {
      'en': 'Trt Cheveux',
      'fr': '',
    },
    '4nrcmxcv': {
      'en': 'Trt Laser',
      'fr': '',
    },
    '6omu3nkt': {
      'en': 'Trt Corps',
      'fr': '',
    },
    'msmwi0iv': {
      'en': 'SERVICE DETAILS',
      'fr': '',
    },
    'igp8c9nn': {
      'en': 'Doctors',
      'fr': '',
    },
    'ngepbfu7': {
      'en': 'PRICE',
      'fr': '',
    },
    '6pq4nrao': {
      'en': 'ACTIONS',
      'fr': '',
    },
    'k5kmlero': {
      'en': 'Edit',
      'fr': '',
    },
    'qvi4cjct': {
      'en': 'Treatments',
      'fr': '',
    },
    '6pji0cix': {
      'en': 'Home',
      'fr': '',
    },
  },
  // Patients
  {
    'eecp7hxc': {
      'en': 'Ma Clinique',
      'fr': '',
    },
    'ax1g8bgp': {
      'en': 'Platform Navigation',
      'fr': '',
    },
    'rpy34m6z': {
      'en': 'Calendar',
      'fr': '',
    },
    'abxujayj': {
      'en': 'Treatments',
      'fr': '',
    },
    '9889yk7e': {
      'en': 'Patients',
      'fr': '',
    },
    'e19bz4uc': {
      'en': 'Coming Soon',
      'fr': '',
    },
    '5p9ozu80': {
      'en': 'Dashboard',
      'fr': '',
    },
    'f9rmtgph': {
      'en': 'Chats',
      'fr': '',
    },
    'kmji43bn': {
      'en': 'Billing',
      'fr': '',
    },
    'lqev5aus': {
      'en': 'Analytics',
      'fr': '',
    },
    'mddmnxj0': {
      'en': 'Light Mode',
      'fr': '',
    },
    '2e936i12': {
      'en': 'Dark Mode',
      'fr': '',
    },
    'nlvk90cm': {
      'en': 'Patients',
      'fr': '',
    },
    '8509nepe': {
      'en': 'New Patient',
      'fr': '',
    },
    '83tvnyp7': {
      'en': 'Phone Number',
      'fr': '',
    },
    '9yaa098j': {
      'en': 'Sort by',
      'fr': '',
    },
    '5hdlftld': {
      'en': 'Search for an item...',
      'fr': '',
    },
    'i3xh1g65': {
      'en': 'Option 1',
      'fr': '',
    },
    'enub7w05': {
      'en': 'Patient Status',
      'fr': '',
    },
    '5ynedk39': {
      'en': 'Search for an item...',
      'fr': '',
    },
    '436fr3g0': {
      'en': 'Silver',
      'fr': '',
    },
    'ufspix82': {
      'en': 'Gold',
      'fr': '',
    },
    'ygiukqd7': {
      'en': 'Platinum',
      'fr': '',
    },
    'wyo0r204': {
      'en': 'Name',
      'fr': '',
    },
    'u7p3jj6i': {
      'en': 'Status',
      'fr': '',
    },
    'vo0665s3': {
      'en': 'Doctors',
      'fr': '',
    },
    'pxu1hknl': {
      'en': 'Amount Spent',
      'fr': '',
    },
    'o1gyd4fz': {
      'en': 'Phone',
      'fr': '',
    },
    'fjk98krs': {
      'en': 'Diamond',
      'fr': '',
    },
    '00g0wqg5': {
      'en': 'Edit',
      'fr': '',
    },
    '68hyahzj': {
      'en': 'Patient Archive',
      'fr': '',
    },
    'dd7hmzpo': {
      'en': 'Home',
      'fr': '',
    },
  },
  // PatientProfile
  {
    'h3ryxs51': {
      'en': 'Ma Clinique',
      'fr': '',
    },
    'z4dy8gtt': {
      'en': 'Platform Navigation',
      'fr': '',
    },
    'dvihp9bi': {
      'en': 'Calendar',
      'fr': '',
    },
    'gpt88ect': {
      'en': 'Treatments',
      'fr': '',
    },
    'v8532jrg': {
      'en': 'Patients',
      'fr': '',
    },
    'yw2mfi5f': {
      'en': 'Coming Soon',
      'fr': '',
    },
    'fagqp2e3': {
      'en': 'Dashboard',
      'fr': '',
    },
    'klr3b43l': {
      'en': 'Chats',
      'fr': '',
    },
    '6xp498i1': {
      'en': 'Billing',
      'fr': '',
    },
    'iz08q4x8': {
      'en': 'Analytics',
      'fr': '',
    },
    'ba857tbj': {
      'en': 'Light Mode',
      'fr': '',
    },
    '5nehzz3k': {
      'en': 'Dark Mode',
      'fr': '',
    },
    'sezf9p3e': {
      'en': 'Gender',
      'fr': '',
    },
    'v7cjkeua': {
      'en': 'Adress',
      'fr': '',
    },
    'kvi4knjr': {
      'en': 'Email',
      'fr': '',
    },
    '55pyp03n': {
      'en': 'Age',
      'fr': '',
    },
    'hh3b33is': {
      'en': 'City',
      'fr': '',
    },
    'v0znds55': {
      'en': 'Phone Number',
      'fr': '',
    },
    'lx9k56yi': {
      'en': 'Marital Status',
      'fr': '',
    },
    'iqi8llft': {
      'en': 'Allergies',
      'fr': '',
    },
    'v6smlq34': {
      'en': 'Referal',
      'fr': '',
    },
    'wpix8abg': {
      'en': 'History',
      'fr': '',
    },
    'ucx3j8ls': {
      'en': 'In House Treatments',
      'fr': '',
    },
    'plbi0gud': {
      'en': 'Medical History',
      'fr': '',
    },
    'hvfx8miv': {
      'en': 'Diabetes',
      'fr': '',
    },
    'i1z01349': {
      'en': 'Family History',
      'fr': '',
    },
    '7vxtxkoy': {
      'en': 'Diabetes',
      'fr': '',
    },
    '4lb3tpka': {
      'en': 'Substances & Medications',
      'fr': '',
    },
    'nm331vcp': {
      'en': 'Diabetes',
      'fr': '',
    },
    'xubzsc2q': {
      'en': 'Surgical History',
      'fr': '',
    },
    'l72ddfrd': {
      'en': '25.2',
      'fr': '',
    },
    'x2m3bdd8': {
      'en': 'No Complications',
      'fr': '',
    },
    'm41beyho': {
      'en': 'Injection History',
      'fr': '',
    },
    's3osaxg7': {
      'en': '25.2',
      'fr': '',
    },
    'i3yi58zl': {
      'en': 'Bottox Injection',
      'fr': '',
    },
    '05xdtyh7': {
      'en': 'Recomended Treatments',
      'fr': '',
    },
    'khn92jv5': {
      'en': 'Bottox',
      'fr': '',
    },
    '8edad472': {
      'en': 'Doctor',
      'fr': '',
    },
    '68yvatpb': {
      'en': '6000',
      'fr': '',
    },
    'qhtr7iro': {
      'en': 'Prescriptions',
      'fr': '',
    },
    'rem6nxq9': {
      'en': 'Stilnox',
      'fr': '',
    },
    'ncry1lhp': {
      'en': 'Payments',
      'fr': '',
    },
    'gszsvx8c': {
      'en': '25.02.2025',
      'fr': '',
    },
    'qbmrhhf6': {
      'en': 'Hand Laser',
      'fr': '',
    },
    'eo4cggno': {
      'en': '6000 MAD',
      'fr': '',
    },
    'm9egeafl': {
      'en': 'Payed',
      'fr': '',
    },
    '9h6d5m18': {
      'en': 'Patient Archive',
      'fr': '',
    },
    'zgoocpqk': {
      'en': 'Home',
      'fr': '',
    },
  },
  // bottom
  {
    'g34mqzqs': {
      'en': 'Book Session',
      'fr': '',
    },
    '5074scmz': {
      'en': 'Select lesson duration in minutes',
      'fr': '',
    },
    'iarurmyj': {
      'en': 'Session Time:',
      'fr': '',
    },
    '9pjig0sq': {
      'en': 'Select Service',
      'fr': '',
    },
    'ieshsl0w': {
      'en': 'other',
      'fr': '',
    },
    'ona1z1jg': {
      'en': 'Please select...',
      'fr': '',
    },
    'x8ioji8p': {
      'en': 'Search for an item...',
      'fr': '',
    },
    'gqkl24mu': {
      'en': 'Altitude HQ',
      'fr': '',
    },
    'hortzejo': {
      'en': 'Snowpark',
      'fr': '',
    },
    'xnwq2195': {
      'en': 'Achileas',
      'fr': '',
    },
    'bi8gprl4': {
      'en': 'Other',
      'fr': '',
    },
    'r7j30m0h': {
      'en': 'Specify Service..',
      'fr': '',
    },
    'ksq3ssfx': {
      'en': 'Patient',
      'fr': '',
    },
    '18uaazgg': {
      'en': ' 0662 033332',
      'fr': '',
    },
    '6ly8069f': {
      'en': 'Name',
      'fr': '',
    },
    'x3grwbd9': {
      'en': 'Book',
      'fr': '',
    },
  },
  // bottomServices
  {
    'km9oyafe': {
      'en': 'Add Treatment',
      'fr': '',
    },
    'hapwytky': {
      'en': 'Name...',
      'fr': '',
    },
    'stps0ii4': {
      'en': 'Description..',
      'fr': '',
    },
    'ksun5zsl': {
      'en': 'Categorie',
      'fr': '',
    },
    'aht8hcnd': {
      'en': 'Search...',
      'fr': '',
    },
    '1joqgvpj': {
      'en': 'Soins Visage',
      'fr': '',
    },
    'jmtp0as1': {
      'en': 'Trt Esthetique',
      'fr': '',
    },
    'nm3ciyem': {
      'en': 'Trt Cheveux',
      'fr': '',
    },
    'jb24wved': {
      'en': 'Trt Laser',
      'fr': '',
    },
    '6r1c6kcb': {
      'en': 'Trt Corps',
      'fr': '',
    },
    'eyix620g': {
      'en': 'Price',
      'fr': '',
    },
    'cy3m5mo4': {
      'en': 'Create',
      'fr': '',
    },
  },
  // bottomServicesTeam
  {
    'vtdsig95': {
      'en': 'Add Staff',
      'fr': '',
    },
  },
  // bottomServicesUpdate
  {
    'qt06zsk9': {
      'en': 'Update Treatment',
      'fr': '',
    },
    '1kr6xn55': {
      'en': 'Description..',
      'fr': '',
    },
    '32tbp7t6': {
      'en': 'Categorie',
      'fr': '',
    },
    'svhe26kr': {
      'en': 'Search...',
      'fr': '',
    },
    'ndq3liyh': {
      'en': 'Epilation Femme',
      'fr': '',
    },
    '7tp92isr': {
      'en': 'Epilation Homme',
      'fr': '',
    },
    'i3aauc42': {
      'en': 'PRP et PRF',
      'fr': '',
    },
    'hq5gx19u': {
      'en': 'Mésothérapie',
      'fr': '',
    },
    'dm8qp0g5': {
      'en': 'Injections',
      'fr': '',
    },
    'ia9uopfs': {
      'en': 'Body Contouring By Alma',
      'fr': '',
    },
    '3rxknsb6': {
      'en': 'Face Contouring By Alma',
      'fr': '',
    },
    '0j5hj2nl': {
      'en': 'Soins de visage Dermatologiques',
      'fr': '',
    },
    'gtroybxi': {
      'en': 'Consultation Laser',
      'fr': '',
    },
    'z2cd80pl': {
      'en': 'Sonsultation Médecins',
      'fr': '',
    },
    'byi7qwde': {
      'en': 'ELECTROLYSE',
      'fr': '',
    },
    '49611syr': {
      'en': 'Price',
      'fr': '',
    },
    'y0qu9bz3': {
      'en': 'Update',
      'fr': '',
    },
  },
  // booking
  {
    'ggxnfcuz': {
      'en': 'confirmed',
      'fr': '',
    },
    'nrnoujes': {
      'en': 'Notes',
      'fr': '',
    },
  },
  // doctorsList
  {
    '6lp73p00': {
      'en': 'Select Doctor',
      'fr': '',
    },
  },
  // selectPatients
  {
    '6grv0x65': {
      'en': 'Select Patient',
      'fr': '',
    },
    '0aiuvuqt': {
      'en': 'Patient Phone Number...',
      'fr': '',
    },
  },
  // Machines
  {
    '7lizez5z': {
      'en': 'Select Machine',
      'fr': '',
    },
    'jan675do': {
      'en': 'Search Machines...',
      'fr': '',
    },
  },
  // newPatient
  {
    'xlq8jgeo': {
      'en': 'New Patient',
      'fr': '',
    },
    '2ecovnp9': {
      'en': 'Name',
      'fr': '',
    },
    'poiub3e1': {
      'en': 'Email',
      'fr': '',
    },
    'k36gyfta': {
      'en': 'Phone Number',
      'fr': '',
    },
    'qcm33b8q': {
      'en': 'City',
      'fr': '',
    },
    '3mq3ya8t': {
      'en': 'Adress',
      'fr': '',
    },
    '9imfw9fi': {
      'en': 'Social Status',
      'fr': '',
    },
    'geamfmw0': {
      'en': 'Search...',
      'fr': '',
    },
    'fsfcnjk6': {
      'en': 'Single',
      'fr': '',
    },
    'mkndrt8q': {
      'en': 'Married',
      'fr': '',
    },
    'a1tndkgh': {
      'en': 'Gender',
      'fr': '',
    },
    'alk2radq': {
      'en': 'Search...',
      'fr': '',
    },
    'lb7kzqo7': {
      'en': 'Male',
      'fr': '',
    },
    't4g6mfa4': {
      'en': 'Female',
      'fr': '',
    },
    '4w7koanp': {
      'en': 'Add Alergies',
      'fr': '',
    },
    'p4fmx0hp': {
      'en': 'How did you find us?',
      'fr': '',
    },
    'q13b9grk': {
      'en': 'Create Patient',
      'fr': '',
    },
  },
  // updatePatient
  {
    'hy6a5bms': {
      'en': 'Update Patient',
      'fr': '',
    },
    '5763t3x4': {
      'en': 'Name',
      'fr': '',
    },
    'fqo5jq39': {
      'en': 'Email',
      'fr': '',
    },
    'sgtmjysp': {
      'en': 'Phone Number',
      'fr': '',
    },
    'q0jmq2q5': {
      'en': 'City',
      'fr': '',
    },
    'oum86sdm': {
      'en': 'Adress',
      'fr': '',
    },
    '596inbuo': {
      'en': 'Social Status',
      'fr': '',
    },
    'gg6xb4kq': {
      'en': 'Search...',
      'fr': '',
    },
    'hj4t5636': {
      'en': 'Single',
      'fr': '',
    },
    'czfugj0s': {
      'en': 'Married',
      'fr': '',
    },
    'cjp4ia2f': {
      'en': 'Gender',
      'fr': '',
    },
    '2tyqkwwz': {
      'en': 'Search...',
      'fr': '',
    },
    'be8gck9o': {
      'en': 'Male',
      'fr': '',
    },
    'xi9q6hfv': {
      'en': 'Female',
      'fr': '',
    },
    'ze2gn1zt': {
      'en': 'Add Alergies',
      'fr': '',
    },
    '48h8iyl2': {
      'en': 'How did you find us?',
      'fr': '',
    },
    'cwuaj3n3': {
      'en': 'Update Patient',
      'fr': '',
    },
  },
  // updatePatientBooking
  {
    'tv02ysa3': {
      'en': 'Select Patient',
      'fr': '',
    },
    '289rdosh': {
      'en': 'Patient Phone Number...',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    '4u2cf0yg': {
      'en': '',
      'fr': '',
    },
    'k6haxkdx': {
      'en': '',
      'fr': '',
    },
    'nwlygwwr': {
      'en': '',
      'fr': '',
    },
    'fi8hmbny': {
      'en': '',
      'fr': '',
    },
    'qq94f5y5': {
      'en': '',
      'fr': '',
    },
    'r7nmsth1': {
      'en': '',
      'fr': '',
    },
    'ptzmy3s3': {
      'en': '',
      'fr': '',
    },
    'uvy9n3w0': {
      'en': '',
      'fr': '',
    },
    'lp39kh25': {
      'en': '',
      'fr': '',
    },
    '1five1mm': {
      'en': '',
      'fr': '',
    },
    'mblit2b7': {
      'en': '',
      'fr': '',
    },
    'cs8zkiqb': {
      'en': '',
      'fr': '',
    },
    'qnpoi9hf': {
      'en': '',
      'fr': '',
    },
    'rndf2jcj': {
      'en': '',
      'fr': '',
    },
    's51hec4p': {
      'en': '',
      'fr': '',
    },
    'kk1dppb8': {
      'en': '',
      'fr': '',
    },
    '6if8khc4': {
      'en': '',
      'fr': '',
    },
    'il93cnw2': {
      'en': '',
      'fr': '',
    },
    '7ydh4bkv': {
      'en': '',
      'fr': '',
    },
    '3yzyr9bh': {
      'en': '',
      'fr': '',
    },
    'utif36lv': {
      'en': '',
      'fr': '',
    },
    'r4bcpiep': {
      'en': '',
      'fr': '',
    },
    '07xi888f': {
      'en': '',
      'fr': '',
    },
    '59r9df35': {
      'en': '',
      'fr': '',
    },
    '47kz9rzn': {
      'en': '',
      'fr': '',
    },
    'vra18ele': {
      'en': '',
      'fr': '',
    },
    '87uwd376': {
      'en': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
