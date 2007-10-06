# ISO language and character set codes
#
# $Id$
# $ProjectHeader: ImpCMS 0.3 Fri, 05 Apr 2002 23:34:31 -0800 chris $
#


CREATE TABLE Charsets (
    Charset								VARCHAR(16) NOT NULL PRIMARY KEY,
    Name  								VARCHAR(64) NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE Languages (
    ISOCode       				VARCHAR(8) NOT NULL PRIMARY KEY,
    Name          				VARCHAR(64) NOT NULL,
    DefaultCharset				VARCHAR(16) NOT NULL REFERENCES Charsets (ID)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


INSERT INTO Languages (ISOCode, Name) VALUES ('ab', 'Abkhazian');
INSERT INTO Languages (ISOCode, Name) VALUES ('aa', 'Afar');
INSERT INTO Languages (ISOCode, Name) VALUES ('af', 'Afrikaans');
INSERT INTO Languages (ISOCode, Name) VALUES ('sq', 'Albanian');
INSERT INTO Languages (ISOCode, Name) VALUES ('am', 'Amharic');
INSERT INTO Languages (ISOCode, Name) VALUES ('ar', 'Arabic');
INSERT INTO Languages (ISOCode, Name) VALUES ('hy', 'Armenian');
INSERT INTO Languages (ISOCode, Name) VALUES ('as', 'Assamese');
INSERT INTO Languages (ISOCode, Name) VALUES ('ay', 'Aymara');
INSERT INTO Languages (ISOCode, Name) VALUES ('az', 'Azerbaijani');
INSERT INTO Languages (ISOCode, Name) VALUES ('ba', 'Bashkir');
INSERT INTO Languages (ISOCode, Name) VALUES ('eu', 'Basque');
INSERT INTO Languages (ISOCode, Name) VALUES ('bn', 'Bengali');
INSERT INTO Languages (ISOCode, Name) VALUES ('dz', 'Bhutani');
INSERT INTO Languages (ISOCode, Name) VALUES ('bh', 'Bihari');
INSERT INTO Languages (ISOCode, Name) VALUES ('bi', 'Bislama');
INSERT INTO Languages (ISOCode, Name) VALUES ('br', 'Breton');
INSERT INTO Languages (ISOCode, Name) VALUES ('bg', 'Bulgarian');
INSERT INTO Languages (ISOCode, Name) VALUES ('my', 'Burmese');
INSERT INTO Languages (ISOCode, Name) VALUES ('be', 'Byelorussian');
INSERT INTO Languages (ISOCode, Name) VALUES ('km', 'Cambodian');
INSERT INTO Languages (ISOCode, Name) VALUES ('ca', 'Catalan');
INSERT INTO Languages (ISOCode, Name) VALUES ('zh', 'Chinese');
INSERT INTO Languages (ISOCode, Name) VALUES ('zh-tw', 'Chinese (Traditional)');
INSERT INTO Languages (ISOCode, Name) VALUES ('zh-cn', 'Chinese (Simplified)');
INSERT INTO Languages (ISOCode, Name) VALUES ('co', 'Corsican');
INSERT INTO Languages (ISOCode, Name) VALUES ('hr', 'Croatian');
INSERT INTO Languages (ISOCode, Name) VALUES ('cs', 'Czech');
INSERT INTO Languages (ISOCode, Name) VALUES ('da', 'Danish');
INSERT INTO Languages (ISOCode, Name) VALUES ('nl', 'Dutch');
INSERT INTO Languages (ISOCode, Name) VALUES ('en', 'English');
INSERT INTO Languages (ISOCode, Name) VALUES ('en-us', 'English (American)');
INSERT INTO Languages (ISOCode, Name) VALUES ('eo', 'Esperanto');
INSERT INTO Languages (ISOCode, Name) VALUES ('et', 'Estonian');
INSERT INTO Languages (ISOCode, Name) VALUES ('fo', 'Faeroese');
INSERT INTO Languages (ISOCode, Name) VALUES ('fa', 'Farsi');
INSERT INTO Languages (ISOCode, Name) VALUES ('fj', 'Fiji');
INSERT INTO Languages (ISOCode, Name) VALUES ('fi', 'Finnish');
INSERT INTO Languages (ISOCode, Name) VALUES ('fr', 'French');
INSERT INTO Languages (ISOCode, Name) VALUES ('fy', 'Frisian');
INSERT INTO Languages (ISOCode, Name) VALUES ('gl', 'Galician');
INSERT INTO Languages (ISOCode, Name) VALUES ('ka', 'Georgian');
INSERT INTO Languages (ISOCode, Name) VALUES ('de', 'German');
INSERT INTO Languages (ISOCode, Name) VALUES ('el', 'Greek');
INSERT INTO Languages (ISOCode, Name) VALUES ('kl', 'Greenlandic');
INSERT INTO Languages (ISOCode, Name) VALUES ('gn', 'Guarani');
INSERT INTO Languages (ISOCode, Name) VALUES ('gu', 'Gujarati');
INSERT INTO Languages (ISOCode, Name) VALUES ('ha', 'Hausa');
INSERT INTO Languages (ISOCode, Name) VALUES ('iw', 'Hebrew');
INSERT INTO Languages (ISOCode, Name) VALUES ('hi', 'Hindi');
INSERT INTO Languages (ISOCode, Name) VALUES ('hu', 'Hungarian');
INSERT INTO Languages (ISOCode, Name) VALUES ('is', 'Icelandic');
INSERT INTO Languages (ISOCode, Name) VALUES ('in', 'Indonesian');
INSERT INTO Languages (ISOCode, Name) VALUES ('ia', 'Interlingua');
INSERT INTO Languages (ISOCode, Name) VALUES ('ie', 'Interlingue');
INSERT INTO Languages (ISOCode, Name) VALUES ('iu', 'Inuktitut');
INSERT INTO Languages (ISOCode, Name) VALUES ('ik', 'Inupiak');
INSERT INTO Languages (ISOCode, Name) VALUES ('ga', 'Irish');
INSERT INTO Languages (ISOCode, Name) VALUES ('it', 'Italian');
INSERT INTO Languages (ISOCode, Name) VALUES ('ja', 'Japanese');
INSERT INTO Languages (ISOCode, Name) VALUES ('jw', 'Javanese');
INSERT INTO Languages (ISOCode, Name) VALUES ('kn', 'Kannada');
INSERT INTO Languages (ISOCode, Name) VALUES ('ks', 'Kashmiri');
INSERT INTO Languages (ISOCode, Name) VALUES ('kk', 'Kazakh');
INSERT INTO Languages (ISOCode, Name) VALUES ('rw', 'Kinyarwanda');
INSERT INTO Languages (ISOCode, Name) VALUES ('ky', 'Kirghiz');
INSERT INTO Languages (ISOCode, Name) VALUES ('rn', 'Kirundi');
INSERT INTO Languages (ISOCode, Name) VALUES ('ko', 'Korean');
INSERT INTO Languages (ISOCode, Name) VALUES ('ku', 'Kurdish');
INSERT INTO Languages (ISOCode, Name) VALUES ('lo', 'Laothian');
INSERT INTO Languages (ISOCode, Name) VALUES ('la', 'Latin');
INSERT INTO Languages (ISOCode, Name) VALUES ('lv', 'Latvian');
INSERT INTO Languages (ISOCode, Name) VALUES ('ln', 'Lingala');
INSERT INTO Languages (ISOCode, Name) VALUES ('lt', 'Lithuanian');
INSERT INTO Languages (ISOCode, Name) VALUES ('mk', 'Macedonian');
INSERT INTO Languages (ISOCode, Name) VALUES ('mg', 'Malagasy');
INSERT INTO Languages (ISOCode, Name) VALUES ('ms', 'Malay');
INSERT INTO Languages (ISOCode, Name) VALUES ('ml', 'Malayalam');
INSERT INTO Languages (ISOCode, Name) VALUES ('mt', 'Maltese');
INSERT INTO Languages (ISOCode, Name) VALUES ('mi', 'Maori');
INSERT INTO Languages (ISOCode, Name) VALUES ('mr', 'Marathi');
INSERT INTO Languages (ISOCode, Name) VALUES ('mo', 'Moldavian');
INSERT INTO Languages (ISOCode, Name) VALUES ('mn', 'Mongolian');
INSERT INTO Languages (ISOCode, Name) VALUES ('na', 'Nauru');
INSERT INTO Languages (ISOCode, Name) VALUES ('ne', 'Nepali');
INSERT INTO Languages (ISOCode, Name) VALUES ('no', 'Norwegian');
INSERT INTO Languages (ISOCode, Name) VALUES ('oc', 'Occitan');
INSERT INTO Languages (ISOCode, Name) VALUES ('or', 'Oriya');
INSERT INTO Languages (ISOCode, Name) VALUES ('pl', 'Polish');
INSERT INTO Languages (ISOCode, Name) VALUES ('pt', 'Portuguese');
INSERT INTO Languages (ISOCode, Name) VALUES ('pa', 'Punjabi');
INSERT INTO Languages (ISOCode, Name) VALUES ('qu', 'Quechua');
INSERT INTO Languages (ISOCode, Name) VALUES ('rm', 'Rhaeto-Romance');
INSERT INTO Languages (ISOCode, Name) VALUES ('ro', 'Romanian');
INSERT INTO Languages (ISOCode, Name) VALUES ('ru', 'Russian');
INSERT INTO Languages (ISOCode, Name) VALUES ('sm', 'Samoan');
INSERT INTO Languages (ISOCode, Name) VALUES ('sg', 'Sangro');
INSERT INTO Languages (ISOCode, Name) VALUES ('sa', 'Sanskrit');
INSERT INTO Languages (ISOCode, Name) VALUES ('sr', 'Serbian');
INSERT INTO Languages (ISOCode, Name) VALUES ('sh', 'Serbo-Croatian');
INSERT INTO Languages (ISOCode, Name) VALUES ('st', 'Sesotho');
INSERT INTO Languages (ISOCode, Name) VALUES ('tn', 'Setswana');
INSERT INTO Languages (ISOCode, Name) VALUES ('sn', 'Shona');
INSERT INTO Languages (ISOCode, Name) VALUES ('sd', 'Sindhi');
INSERT INTO Languages (ISOCode, Name) VALUES ('si', 'Singhalese');
INSERT INTO Languages (ISOCode, Name) VALUES ('ss', 'Siswati');
INSERT INTO Languages (ISOCode, Name) VALUES ('sk', 'Slovak');
INSERT INTO Languages (ISOCode, Name) VALUES ('sl', 'Slovenian');
INSERT INTO Languages (ISOCode, Name) VALUES ('so', 'Somali');
INSERT INTO Languages (ISOCode, Name) VALUES ('es', 'Spanish');
INSERT INTO Languages (ISOCode, Name) VALUES ('su', 'Sundanese');
INSERT INTO Languages (ISOCode, Name) VALUES ('sw', 'Swahili');
INSERT INTO Languages (ISOCode, Name) VALUES ('sv', 'Swedish');
INSERT INTO Languages (ISOCode, Name) VALUES ('tl', 'Tagalog');
INSERT INTO Languages (ISOCode, Name) VALUES ('tg', 'Tajik');
INSERT INTO Languages (ISOCode, Name) VALUES ('ta', 'Tamil');
INSERT INTO Languages (ISOCode, Name) VALUES ('tt', 'Tatar');
INSERT INTO Languages (ISOCode, Name) VALUES ('te', 'Telugu');
INSERT INTO Languages (ISOCode, Name) VALUES ('th', 'Thai');
INSERT INTO Languages (ISOCode, Name) VALUES ('bo', 'Tibetan');
INSERT INTO Languages (ISOCode, Name) VALUES ('ti', 'Tigrinya');
INSERT INTO Languages (ISOCode, Name) VALUES ('to', 'Tonga');
INSERT INTO Languages (ISOCode, Name) VALUES ('ts', 'Tsonga');
INSERT INTO Languages (ISOCode, Name) VALUES ('tr', 'Turkish');
INSERT INTO Languages (ISOCode, Name) VALUES ('tk', 'Turkmen');
INSERT INTO Languages (ISOCode, Name) VALUES ('tw', 'Twi');
INSERT INTO Languages (ISOCode, Name) VALUES ('ug', 'Uighur');
INSERT INTO Languages (ISOCode, Name) VALUES ('uk', 'Ukrainian');
INSERT INTO Languages (ISOCode, Name) VALUES ('ur', 'Urdu');
INSERT INTO Languages (ISOCode, Name) VALUES ('uz', 'Uzbek');
INSERT INTO Languages (ISOCode, Name) VALUES ('vi', 'Vietnamese');
INSERT INTO Languages (ISOCode, Name) VALUES ('vo', 'Volap�k');
INSERT INTO Languages (ISOCode, Name) VALUES ('cy', 'Welsh');
INSERT INTO Languages (ISOCode, Name) VALUES ('wo', 'Wolof');
INSERT INTO Languages (ISOCode, Name) VALUES ('xh', 'Xhosa');
INSERT INTO Languages (ISOCode, Name) VALUES ('ji', 'Yiddish');
INSERT INTO Languages (ISOCode, Name) VALUES ('yo', 'Yoruba');
INSERT INTO Languages (ISOCode, Name) VALUES ('zu', 'Zulu');

INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-1', 'Western (ISO-8859-1)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-2', 'Central European (ISO-8859-2)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-3', 'South European (ISO-8859-3)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-4', 'Baltic (ISO-8859-4)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-9', 'Turkish (ISO-8859-9)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-10', 'Nordic (ISO-8859-10)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-13', 'Baltic (ISO-8859-13)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-14', 'Celtic (ISO-8859-14)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-15', 'Western (ISO-8859-15)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1250', 'Central European (Windows-1250)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1252', 'Western (Windows-1252)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1254', 'Turkish (Windows-1254)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1257', 'Baltic (Windows-1257)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-roman', 'Western (MacRoman)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-ce', 'Central European (MacCE)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-turkish', 'Turkish (MacTurkish)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-croatian', 'Croatian (MacCroatian)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-romanian', 'Romanian (MacRomanian)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-icelandic', 'Icelandic (MacIcelandic)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-2022-jp', 'Japanese (ISO-2022-JP)');
INSERT INTO Charsets (Charset, Name) VALUES ('shift_jis', 'Japanese (Shift_JIS)');
INSERT INTO Charsets (Charset, Name) VALUES ('euc-jp', 'Japanese (EUC-JP)');
INSERT INTO Charsets (Charset, Name) VALUES ('big5', 'Chinese Traditional (Big5)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-euc-tw', 'Chinese Traditional (EUC-TW)');
INSERT INTO Charsets (Charset, Name) VALUES ('gb2312', 'Chinese Simplified (GB2312)');
INSERT INTO Charsets (Charset, Name) VALUES ('hz-gb-2312', 'Chinese Simplified (HZ)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-gbk', 'Chinese Simplified (GBK)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-2022-cn', 'Chinese Simplified (ISO-2022-CN)');
INSERT INTO Charsets (Charset, Name) VALUES ('euc-kr', 'Korean (EUC-KR)');
INSERT INTO Charsets (Charset, Name) VALUES ('utf-7', 'Unicode (UTF-7)');
INSERT INTO Charsets (Charset, Name) VALUES ('utf-8', 'Unicode (UTF-8)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-5', 'Cyrillic (ISO-8859-5)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-ir-111', 'Cyrillic (ISO-IR-111)');
INSERT INTO Charsets (Charset, Name) VALUES ('cp-866', 'Cyrillic (CP-866)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1251', 'Cyrillic (Windows-1251)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-cyrillic', 'Cyrillic (MacCyrillic)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-ukrainian', 'Cyrillic/Ukrainian (MacUkrainian)');
INSERT INTO Charsets (Charset, Name) VALUES ('koi8-r', 'Cyrillic (KOI8-R)');
INSERT INTO Charsets (Charset, Name) VALUES ('koi8-u', 'Cyrillic/Ukrainian (KOI8-U)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-7', 'Greek (ISO-8859-7)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1253', 'Greek (Windows-1253)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-mac-greek', 'Greek (MacGreek)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1258', 'Vietnamese (Windows-1258)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-viet-tcvn5712', 'Vietnamese (TCVN)');
INSERT INTO Charsets (Charset, Name) VALUES ('viscii', 'Vietnamese (VISCII)');
INSERT INTO Charsets (Charset, Name) VALUES ('x-viet-vps', 'Vietnamese (VPS)');
INSERT INTO Charsets (Charset, Name) VALUES ('tis-620', 'Thai (TIS-620)');
INSERT INTO Charsets (Charset, Name) VALUES ('armscii-8', 'Armenian (ARMSCII-8)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-6', 'Arabic (ISO-8859-6)');
INSERT INTO Charsets (Charset, Name) VALUES ('iso-8859-8', 'Hebrew (ISO-8859-8)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1255', 'Hebrew (Windows-1255)');
INSERT INTO Charsets (Charset, Name) VALUES ('windows-1256', 'Arabic (Windows-1256)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm866', 'Cyrillic/Russian (IBM-866)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm850', 'Western (IBM-850)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm852', 'Central European (IBM-852)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm855', 'Cyrillic (IBM-855)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm857', 'Turkish (IBM-857)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm862', 'Hebrew (IBM-862)');
INSERT INTO Charsets (Charset, Name) VALUES ('ibm864', 'Arabic (IBM-864)');