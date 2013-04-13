From: =?ISO-8859-1?Q?Jo=E3o_Joyce?= <joao.joyce@netcabo.pt>
Subject: Fwd: Re: git send-pack: protocol error: bad band #50
Date: Sat, 13 Apr 2013 12:03:15 +0100
Message-ID: <51693B73.3030007@netcabo.pt>
References: <51674966.8010403@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 13:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQyFs-0003JY-QL
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 13:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3DMLEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Apr 2013 07:04:08 -0400
Received: from mx.netcabo.pt ([212.113.174.24]:59960 "EHLO mx.netcabo.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab3DMLEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 07:04:07 -0400
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.1 cv=1LO/iPE5NBXhyVdUxN98Xz52Jo9BJjb+qr8ZetvN7rk= c=1 sm=2
 a=-TtDL2fbfKMA:10 a=QtxXEV6abmYA:10 a=8nJEP1OIZ-IA:10 a=uytceFsMAAAA:8
 a=tDiRamDHiw3h_RHv3IcA:9 a=wPNLvfGTeEIA:10 a=H777XK5ZPtYA:10
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAI04aVFSmhjH/2dsb2JhbAANQ4M8wU6BG4MTAQEBBBoBFwEFQAEQGQoJFg8JAwIBAgE7CgYNAQUCAQGHfQGpGohcFIogjxcHg0EDqx8
Received: from bl5-24-199.dsl.telepac.pt (HELO [192.168.1.67]) ([82.154.24.199])
  by neti05smtpa.hdi.tvcabo with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 13 Apr 2013 12:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <51674966.8010403@netcabo.pt>
X-Forwarded-Message-Id: <51674966.8010403@netcabo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221058>

Hello,

I have tried to remove and recreate my git folder and remove some files=
=20
to get more logs. Here they are:

packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
17c420b8bd99856aee6da9c1743f6df0ec18a9ca refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push<=20
20b8bd99856aee6da9c1743f6df0ec18a9cac28267338c198573ad59e89d0acc445a62b=
3d127=20
acf853d0a30287d9455dbe1707edeb16cc3e9b22=20
conf.php845ecef1e4aaece71ef357285c2df71056ae0314=20
db98699a6c68b653be1fa8dceb64204397d9814cd1=20
db/db.sqlfed89aa6a337c6ab5a89dba13702a65ab70372bd=20
httpff2a325bfd33f1fb7098b5688ffe99fe67bf5874=20
http/apifbf53a7bcd223485e56d30715a794a7e067df8d2=20
http/api/.htaccess84d1f0580e88c6351df884200ebcd526d8b145ea=20
http/api/index.php9b8a7a21fa6e4c3a9672469b9b4a7e51a336d015=20
http/www9a464b3db152808bc74512304054ac25a63cb9b7=20
http/www/files8cab2dab60f85385de1ef984a976a038176c2015=20
http/www/files/foundationa5cb50f4203d7176a505857ac80ffbbcf562c91f=20
http/www/files/foundation/cssc2a844c8a00ef41d912f53c40026580f2b10fd00=20
http/www/files/foundation/css/accessibility_foundicons.css699d805b9f585=
8111d4bc95705df22f6137ec14a=20
http/www/files/foundation/css/accessibility_foundicons_ie7.css8e0ddf1ac=
316d9231277a77bcd550895f291b5c7=20
http/www/files/foundation/css/foundation.css1d592b3fc77c4b44af67b82edbe=
e4cc51b8a97d9=20
http/www/files/foundation/css/foundation.min.css3c308c85cf36052810d35c0=
8d4f5bbc233cf61ea=20
http/www/files/foundation/css/general_foundicons.cssd5b3776730a16e4ec61=
bad31526cc0a5a24096bc=20
http/www/files/foundation/css/general_foundicons_ie7.cssa9c6f52f05e50c6=
fd8dab6c30e22c8d4ea2f15ea=20
http/www/files/foundation/css/normalize.css914f6472ffce7135f191048a923e=
07e7886f192b=20
http/www/files/foundation/css/social_foundicons.css6a3c9c07729fc466c38e=
6a40d36b298de881706b=20
http/www/files/foundation/css/social_foundicons_ie7.cssd44839248d958fdc=
96fa044dae0ea71dffd35bde=20
http/www/files/foundation/fonts5008ddfcf53c02e82d7eee2e57c38e5672ef89f6=
=20
http/www/files/foundation/fonts/.DS_Store237a0ca97e568531dc58bf7c812020=
28af1e881c=20
http/www/files/foundation/fonts/accessibility_foundicons.eot49c0d07bea6=
f18cdbc35ee938b1b3f48cacce64c=20
http/www/files/foundation/fonts/accessibility_foundicons.svg46a67f8d022=
3b881ca74ccafb44b64664552b937=20
http/www/files/foundation/fonts/accessibility_foundicons.ttf4eae85189fe=
e6930191b69e31a09b34e6a9a9c19=20
http/www/files/foundation/fonts/accessibility_foundicons.woff20733a0388=
ef77572cbc55cbf76cc46babf0a15d=20
http/www/files/foundation/fonts/general_foundicons.eota9347515264ac712b=
5d083eaa231929243ea7142=20
http/www/files/foundation/fonts/general_foundicons.svg90a5ccead2d84d036=
bd8ed66926af93b21621df5=20
http/www/files/foundation/fonts/general_foundicons.ttfdaab63141b07e0a1f=
a8efd931a98945b837bd4aa=20
http/www/files/foundation/fonts/general_foundicons.woffa9341f49f12c10aa=
a5db2bc74ed3889245ce9a3a=20
http/www/files/foundation/fonts/social_foundicons.eoteb4189cd70c623deaa=
25e5bb55ab210d27fe2d14=20
http/www/files/foundation/fonts/social_foundicons.svg01158c66b13b6f90e7=
b7d1cdb5c4e7369c6434ae=20
http/www/files/foundation/fonts/social_foundicons.ttfbd1f1e58a692b73205=
fce579faee81801d3157aa=20
http/www/files/foundation/fonts/social_foundicons.woffcd2531e2044a9c187=
5159ff1278aafac1aaa8944=20
http/www/files/foundation/img8b137891791fe96927ad78e64b0aad7bded08bdc=20
http/www/files/foundation/img/.gitkeep36b90e58095363e46845d98d979700d16=
019830e=20
http/www/files/foundation/js596287860dbdcd04dd8a78d2ee1999862286515a=20
http/www/files/foundation/js/foundation.min.jsec14148b2d83476fffebf3cba=
39d6516844b7200=20
http/www/files/foundation/js/foundationb78a35a14d000346914644cc0e9783a4=
0f64760d=20
http/www/files/foundation/js/foundation/foundation.alerts.jsc8ff3249917=
62b763dd936da49415fff1ec2de93=20
http/www/files/foundation/js/foundation/foundation.clearing.js862027c86=
31db60070e8c3ebd7b8953c0283c561=20
http/www/files/foundation/js/foundation/foundation.cookie.js24b35e12e78=
60a80edb9f16a0209715f249f96b0=20
http/www/files/foundation/js/foundation/foundation.dropdown.js6a27af4ad=
0e0865235cd3a84cd251b8f928510ba=20
http/www/files/foundation/js/foundation/foundation.forms.js323e6e1e633a=
ce0dcc873553b8df03a28bcd78bc=20
http/www/files/foundation/js/foundation/foundation.joyride.js87c3b65bd9=
231264c110749b7ad75214cee50c93=20
http/www/files/foundation/js/foundation/foundation.js3cdef5b617b054a355=
f80a5bce164cc1ed8a419e=20
http/www/files/foundation/js/foundation/foundation.magellan.js54c467efd=
46e3c199ae4dd0860ee5196403b1027=20
http/www/files/foundation/js/foundation/foundation.orbit.js65c18fc2b438=
3b5111953114c13ebdb2ba3c5cda=20
http/www/files/foundation/js/foundation/foundation.placeholder.js31a450=
ad44b7ec6593bdefc4a88c781a45c418e1=20
http/www/files/foundation/js/foundation/foundation.reveal.js1069794478f=
6c4032e1caf4ecc24bce961482835=20
http/www/files/foundation/js/foundation/foundation.section.js1696e2ad5b=
bf72ba052f9aa4105e58edee08b16f=20
http/www/files/foundation/js/foundation/foundation.tooltips.js8cc27f1c1=
8db7281602cc4f7d0a193c199ab2d40=20
http/www/files/foundation/js/foundation/foundation.topbar.js14566fdbdbd=
e4c4369ba4b8d0ce646c4621efeb1=20
http/www/files/foundation/js/vendore5afa6ca3c2624ca9e253f5626ae46355ada=
74e3=20
http/www/files/foundation/js/vendor/custom.modernizr.js6362d0f3394e4a90=
561ab33c0650d32572ae4d93=20
http/www/files/foundation/js/vendor/jquery.jsb74544c5cf84ac78d2030c28cd=
9f521e80136b5f=20
http/www/files/foundation/js/vendor/zepto.js006488437dda8a1ec87a3e912a7=
9a5918f170dde=20
http/www/files/scripts4e6c262c7d9a2fcc37206422a434e92cda10cd6a=20
http/www/files/scripts/ajax.jse2c203fe978b83f4ca8d1ba97633f5a5d50bd53b=20
http/www/files/scripts/jquery-1.9.1.js6896a531cd562cc4a2eb31e2be0e81319=
05a90e0=20
http/www/files/scripts/sha512.js272f790b91010bed997f0ed7d4a616f03e627a6=
a=20
http/www/index.phpb1fd6c496624710b8748877d7512766018178342=20
server_filesc4769e6f5ade18f1dea9eb1e44743378cb7e2c5a=20
server_files/api_classesc31151cdf2d4a6136fe95089b39eb3d3cecdf3c3=20
server_files/api_classes/user.phpe61c5338616a6b0e32e953c603944fc088a82b=
d1 server_files/libraries51d26aa3fb9789f86adf6e4b051fa98ce2b085a4=20
server_files/libraries/debugmode.php8f3a40b616c83a77235d1a16a230ee6996c=
fca2b=20
server_files/libraries/restlerc282fca7ac71e27ac69fa3ac4cb19367f7ceee00=20
server_files/libraries/restler/.gitignore7e60fed960715e64352fdd71f37ccf=
e21089a698=20
server_files/libraries/restler/Makefileffa7a78d0ba68d1bba59e04532aa856b=
14afc817=20
server_files/libraries/restler/README.md249b48318375db88df5e2dec82c3744=
a227bac26=20
s
packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
17c420b8bd99856aee6da9c1743f6df0ec18a9ca refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push<=20
20b8bd99856aee6da9c1743f6df0ec18a9cac28267338c198573ad59e89d0acc445a62b=
3d127=20
acf853d0a30287d9455dbe1707edeb16cc3e9b22=20
conf.php845ecef1e4aaece71ef357285c2df71056ae0314=20
db98699a6c68b653be1fa8dceb64204397d9814cd1=20
db/db.sqlfed89aa6a337c6ab5a89dba13702a65ab70372bd=20
httpff2a325bfd33f1fb7098b5688ffe99fe67bf5874=20
http/apifbf53a7bcd223485e56d30715a794a7e067df8d2=20
http/api/.htaccess84d1f0580e88c6351df884200ebcd526d8b145ea=20
http/api/index.php9b8a7a21fa6e4c3a9672469b9b4a7e51a336d015=20
http/www9a464b3db152808bc74512304054ac25a63cb9b7=20
http/www/files8cab2dab60f85385de1ef984a976a038176c2015=20
http/www/files/foundationa5cb50f4203d7176a505857ac80ffbbcf562c91f=20
http/www/files/foundation/cssc2a844c8a00ef41d912f53c40026580f2b10fd00=20
http/www/files/foundation/css/accessibility_foundicons.css699d805b9f585=
8111d4bc95705df22f6137ec14a=20
http/www/files/foundation/css/accessibility_foundicons_ie7.css8e0ddf1ac=
316d9231277a77bcd550895f291b5c7=20
http/www/files/foundation/css/foundation.css1d592b3fc77c4b44af67b82edbe=
e4cc51b8a97d9=20
http/www/files/foundation/css/foundation.min.css3c308c85cf36052810d35c0=
8d4f5bbc233cf61ea=20
http/www/files/foundation/css/general_foundicons.cssd5b3776730a16e4ec61=
bad31526cc0a5a24096bc=20
http/www/files/foundation/css/general_foundicons_ie7.cssa9c6f52f05e50c6=
fd8dab6c30e22c8d4ea2f15ea=20
http/www/files/foundation/css/normalize.css914f6472ffce7135f191048a923e=
07e7886f192b=20
http/www/files/foundation/css/social_foundicons.css6a3c9c07729fc466c38e=
6a40d36b298de881706b=20
http/www/files/foundation/css/social_foundicons_ie7.cssd44839248d958fdc=
96fa044dae0ea71dffd35bde=20
http/www/files/foundation/fonts5008ddfcf53c02e82d7eee2e57c38e5672ef89f6=
=20
http/www/files/foundation/fonts/.DS_Store237a0ca97e568531dc58bf7c812020=
28af1e881c=20
http/www/files/foundation/fonts/accessibility_foundicons.eot49c0d07bea6=
f18cdbc35ee938b1b3f48cacce64c=20
http/www/files/foundation/fonts/accessibility_foundicons.svg46a67f8d022=
3b881ca74ccafb44b64664552b937=20
http/www/files/foundation/fonts/accessibility_foundicons.ttf4eae85189fe=
e6930191b69e31a09b34e6a9a9c19=20
http/www/files/foundation/fonts/accessibility_foundicons.woff20733a0388=
ef77572cbc55cbf76cc46babf0a15d=20
http/www/files/foundation/fonts/general_foundicons.eota9347515264ac712b=
5d083eaa231929243ea7142=20
http/www/files/foundation/fonts/general_foundicons.svg90a5ccead2d84d036=
bd8ed66926af93b21621df5=20
http/www/files/foundation/fonts/general_foundicons.ttfdaab63141b07e0a1f=
a8efd931a98945b837bd4aa=20
http/www/files/foundation/fonts/general_foundicons.woffa9341f49f12c10aa=
a5db2bc74ed3889245ce9a3a=20
http/www/files/foundation/fonts/social_foundicons.eoteb4189cd70c623deaa=
25e5bb55ab210d27fe2d14=20
http/www/files/foundation/fonts/social_foundicons.svg01158c66b13b6f90e7=
b7d1cdb5c4e7369c6434ae=20
http/www/files/foundation/fonts/social_foundicons.ttfbd1f1e58a692b73205=
fce579faee81801d3157aa=20
http/www/files/foundation/fonts/social_foundicons.woffcd2531e2044a9c187=
5159ff1278aafac1aaa8944=20
http/www/files/foundation/img8b137891791fe96927ad78e64b0aad7bded08bdc=20
http/www/files/foundation/img/.gitkeep36b90e58095363e46845d98d979700d16=
019830e=20
http/www/files/foundation/js596287860dbdcd04dd8a78d2ee1999862286515a=20
http/www/files/foundation/js/foundation.min.jsec14148b2d83476fffebf3cba=
39d6516844b7200=20
http/www/files/foundation/js/foundationb78a35a14d000346914644cc0e9783a4=
0f64760d=20
http/www/files/foundation/js/foundation/foundation.alerts.jsc8ff3249917=
62b763dd936da49415fff1ec2de93=20
http/www/files/foundation/js/foundation/foundation.clearing.js862027c86=
31db60070e8c3ebd7b8953c0283c561=20
http/www/files/foundation/js/foundation/foundation.cookie.js24b35e12e78=
60a80edb9f16a0209715f249f96b0=20
http/www/files/foundation/js/foundation/foundation.dropdown.js6a27af4ad=
0e0865235cd3a84cd251b8f928510ba=20
http/www/files/foundation/js/foundation/foundation.forms.js323e6e1e633a=
ce0dcc873553b8df03a28bcd78bc=20
http/www/files/foundation/js/foundation/foundation.joyride.js87c3b65bd9=
231264c110749b7ad75214cee50c93=20
http/www/files/foundation/js/foundation/foundation.js3cdef5b617b054a355=
f80a5bce164cc1ed8a419e=20
http/www/files/foundation/js/foundation/foundation.magellan.js54c467efd=
46e3c199ae4dd0860ee5196403b1027=20
http/www/files/foundation/js/foundation/foundation.orbit.js65c18fc2b438=
3b5111953114c13ebdb2ba3c5cda=20
http/www/files/foundation/js/foundation/foundation.placeholder.js31a450=
ad44b7ec6593bdefc4a88c781a45c418e1=20
http/www/files/foundation/js/foundation/foundation.reveal.js1069794478f=
6c4032e1caf4ecc24bce961482835=20
http/www/files/foundation/js/foundation/foundation.section.js1696e2ad5b=
bf72ba052f9aa4105e58edee08b16f=20
http/www/files/foundation/js/foundation/foundation.tooltips.js8cc27f1c1=
8db7281602cc4f7d0a193c199ab2d40=20
http/www/files/foundation/js/foundation/foundation.topbar.js14566fdbdbd=
e4c4369ba4b8d0ce646c4621efeb1=20
http/www/files/foundation/js/vendore5afa6ca3c2624ca9e253f5626ae46355ada=
74e3=20
http/www/files/foundation/js/vendor/custom.modernizr.js6362d0f3394e4a90=
561ab33c0650d32572ae4d93=20
http/www/files/foundation/js/vendor/jquery.jsb74544c5cf84ac78d2030c28cd=
9f521e80136b5f=20
http/www/files/foundation/js/vendor/zepto.js006488437dda8a1ec87a3e912a7=
9a5918f170dde=20
http/www/files/scripts4e6c262c7d9a2fcc37206422a434e92cda10cd6a=20
http/www/files/scripts/ajax.jse2c203fe978b83f4ca8d1ba97633f5a5d50bd53b=20
http/www/files/scripts/jquery-1.9.1.js6896a531cd562cc4a2eb31e2be0e81319=
05a90e0=20
http/www/files/scripts/sha512.js272f790b91010bed997f0ed7d4a616f03e627a6=
a=20
http/www/index.phpb1fd6c496624710b8748877d7512766018178342=20
server_filesc4769e6f5ade18f1dea9eb1e44743378cb7e2c5a=20
server_files/api_classesc31151cdf2d4a6136fe95089b39eb3d3cecdf3c3=20
server_files/api_classes/user.phpe61c5338616a6b0e32e953c603944fc088a82b=
d1 server_files/libraries51d26aa3fb9789f86adf6e4b051fa98ce2b085a4=20
server_files/libraries/debugmode.php8f3a40b616c83a77235d1a16a230ee6996c=
fca2b=20
server_files/libraries/restlerc282fca7ac71e27ac69fa3ac4cb19367f7ceee00=20
server_files/libraries/restler/.gitignore7e60fed960715e64352fdd71f37ccf=
e21089a698=20
server_files/libraries/restler/Makefileffa7a78d0ba68d1bba59e04532aa856b=
14afc817=20
server_files/libraries/restler/README.md249b48318375db88df5e2dec82c3744=
a227bac26=20
s
packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
17c420b8bd99856aee6da9c1743f6df0ec18a9ca refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push<=20
20b8bd99856aee6da9c1743f6df0ec18a9cac28267338c198573ad59e89d0acc445a62b=
3d127=20
acf853d0a30287d9455dbe1707edeb16cc3e9b22=20
conf.php845ecef1e4aaece71ef357285c2df71056ae0314=20
db98699a6c68b653be1fa8dceb64204397d9814cd1=20
db/db.sqlfed89aa6a337c6ab5a89dba13702a65ab70372bd=20
httpff2a325bfd33f1fb7098b5688ffe99fe67bf5874=20
http/apifbf53a7bcd223485e56d30715a794a7e067df8d2=20
http/api/.htaccess84d1f0580e88c6351df884200ebcd526d8b145ea=20
http/api/index.php9b8a7a21fa6e4c3a9672469b9b4a7e51a336d015=20
http/www9a464b3db152808bc74512304054ac25a63cb9b7=20
http/www/files8cab2dab60f85385de1ef984a976a038176c2015=20
http/www/files/foundationa5cb50f4203d7176a505857ac80ffbbcf562c91f=20
http/www/files/foundation/cssc2a844c8a00ef41d912f53c40026580f2b10fd00=20
http/www/files/foundation/css/accessibility_foundicons.css699d805b9f585=
8111d4bc95705df22f6137ec14a=20
http/www/files/foundation/css/accessibility_foundicons_ie7.css8e0ddf1ac=
316d9231277a77bcd550895f291b5c7=20
http/www/files/foundation/css/foundation.css1d592b3fc77c4b44af67b82edbe=
e4cc51b8a97d9=20
http/www/files/foundation/css/foundation.min.css3c308c85cf36052810d35c0=
8d4f5bbc233cf61ea=20
http/www/files/foundation/css/general_foundicons.cssd5b3776730a16e4ec61=
bad31526cc0a5a24096bc=20
http/www/files/foundation/css/general_foundicons_ie7.cssa9c6f52f05e50c6=
fd8dab6c30e22c8d4ea2f15ea=20
http/www/files/foundation/css/normalize.css914f6472ffce7135f191048a923e=
07e7886f192b=20
http/www/files/foundation/css/social_foundicons.css6a3c9c07729fc466c38e=
6a40d36b298de881706b=20
http/www/files/foundation/css/social_foundicons_ie7.cssd44839248d958fdc=
96fa044dae0ea71dffd35bde=20
http/www/files/foundation/fonts5008ddfcf53c02e82d7eee2e57c38e5672ef89f6=
=20
http/www/files/foundation/fonts/.DS_Store237a0ca97e568531dc58bf7c812020=
28af1e881c=20
http/www/files/foundation/fonts/accessibility_foundicons.eot49c0d07bea6=
f18cdbc35ee938b1b3f48cacce64c=20
http/www/files/foundation/fonts/accessibility_foundicons.svg46a67f8d022=
3b881ca74ccafb44b64664552b937=20
http/www/files/foundation/fonts/accessibility_foundicons.ttf4eae85189fe=
e6930191b69e31a09b34e6a9a9c19=20
http/www/files/foundation/fonts/accessibility_foundicons.woff20733a0388=
ef77572cbc55cbf76cc46babf0a15d=20
http/www/files/foundation/fonts/general_foundicons.eota9347515264ac712b=
5d083eaa231929243ea7142=20
http/www/files/foundation/fonts/general_foundicons.svg90a5ccead2d84d036=
bd8ed66926af93b21621df5=20
http/www/files/foundation/fonts/general_foundicons.ttfdaab63141b07e0a1f=
a8efd931a98945b837bd4aa=20
http/www/files/foundation/fonts/general_foundicons.woffa9341f49f12c10aa=
a5db2bc74ed3889245ce9a3a=20
http/www/files/foundation/fonts/social_foundicons.eoteb4189cd70c623deaa=
25e5bb55ab210d27fe2d14=20
http/www/files/foundation/fonts/social_foundicons.svg01158c66b13b6f90e7=
b7d1cdb5c4e7369c6434ae=20
http/www/files/foundation/fonts/social_foundicons.ttfbd1f1e58a692b73205=
fce579faee81801d3157aa=20
http/www/files/foundation/fonts/social_foundicons.woffcd2531e2044a9c187=
5159ff1278aafac1aaa8944=20
http/www/files/foundation/img8b137891791fe96927ad78e64b0aad7bded08bdc=20
http/www/files/foundation/img/.gitkeep36b90e58095363e46845d98d979700d16=
019830e=20
http/www/files/foundation/js596287860dbdcd04dd8a78d2ee1999862286515a=20
http/www/files/foundation/js/foundation.min.jsec14148b2d83476fffebf3cba=
39d6516844b7200=20
http/www/files/foundation/js/foundationb78a35a14d000346914644cc0e9783a4=
0f64760d=20
http/www/files/foundation/js/foundation/foundation.alerts.jsc8ff3249917=
62b763dd936da49415fff1ec2de93=20
http/www/files/foundation/js/foundation/foundation.clearing.js862027c86=
31db60070e8c3ebd7b8953c0283c561=20
http/www/files/foundation/js/foundation/foundation.cookie.js24b35e12e78=
60a80edb9f16a0209715f249f96b0=20
http/www/files/foundation/js/foundation/foundation.dropdown.js6a27af4ad=
0e0865235cd3a84cd251b8f928510ba=20
http/www/files/foundation/js/foundation/foundation.forms.js323e6e1e633a=
ce0dcc873553b8df03a28bcd78bc=20
http/www/files/foundation/js/foundation/foundation.joyride.js87c3b65bd9=
231264c110749b7ad75214cee50c93=20
http/www/files/foundation/js/foundation/foundation.js3cdef5b617b054a355=
f80a5bce164cc1ed8a419e=20
http/www/files/foundation/js/foundation/foundation.magellan.js54c467efd=
46e3c199ae4dd0860ee5196403b1027=20
http/www/files/foundation/js/foundation/foundation.orbit.js65c18fc2b438=
3b5111953114c13ebdb2ba3c5cda=20
http/www/files/foundation/js/foundation/foundation.placeholder.js31a450=
ad44b7ec6593bdefc4a88c781a45c418e1=20
http/www/files/foundation/js/foundation/foundation.reveal.js1069794478f=
6c4032e1caf4ecc24bce961482835=20
http/www/files/foundation/js/foundation/foundation.section.js1696e2ad5b=
bf72ba052f9aa4105e58edee08b16f=20
http/www/files/foundation/js/foundation/foundation.tooltips.js8cc27f1c1=
8db7281602cc4f7d0a193c199ab2d40=20
http/www/files/foundation/js/foundation/foundation.topbar.js14566fdbdbd=
e4c4369ba4b8d0ce646c4621efeb1=20
http/www/files/foundation/js/vendore5afa6ca3c2624ca9e253f5626ae46355ada=
74e3=20
http/www/files/foundation/js/vendor/custom.modernizr.js6362d0f3394e4a90=
561ab33c0650d32572ae4d93=20
http/www/files/foundation/js/vendor/jquery.jsb74544c5cf84ac78d2030c28cd=
9f521e80136b5f=20
http/www/files/foundation/js/vendor/zepto.js006488437dda8a1ec87a3e912a7=
9a5918f170dde=20
http/www/files/scripts4e6c262c7d9a2fcc37206422a434e92cda10cd6a=20
http/www/files/scripts/ajax.jse2c203fe978b83f4ca8d1ba97633f5a5d50bd53b=20
http/www/files/scripts/jquery-1.9.1.js6896a531cd562cc4a2eb31e2be0e81319=
05a90e0=20
http/www/files/scripts/sha512.js272f790b91010bed997f0ed7d4a616f03e627a6=
a=20
http/www/index.phpb1fd6c496624710b8748877d7512766018178342=20
server_filesc4769e6f5ade18f1dea9eb1e44743378cb7e2c5a=20
server_files/api_classesc31151cdf2d4a6136fe95089b39eb3d3cecdf3c3=20
server_files/api_classes/user.phpe61c5338616a6b0e32e953c603944fc088a82b=
d1 server_files/libraries51d26aa3fb9789f86adf6e4b051fa98ce2b085a4=20
server_files/libraries/debugmode.php8f3a40b616c83a77235d1a16a230ee6996c=
fca2b=20
server_files/libraries/restlerc282fca7ac71e27ac69fa3ac4cb19367f7ceee00=20
server_files/libraries/restler/.gitignore7e60fed960715e64352fdd71f37ccf=
e21089a698=20
server_files/libraries/restler/Makefileffa7a78d0ba68d1bba59e04532aa856b=
14afc817=20
server_files/libraries/restler/README.md249b48318375db88df5e2dec82c3744=
a227bac26=20
s
packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
eef0f0c480e538215cfab821ec53f4997bf35630 refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
eef0f0c480e538215cfab821ec53f4997bf35630 refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
2ba8f16b7cecb56f8bc706b57028942d4867689f refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push<=20
f16b7cecb56f8bc706b57028942d4867689f53af53d73c2815c311aab47561c8d820598=
92ccc=20
acf853d0a30287d9455dbe1707edeb16cc3e9b22=20
conf.php845ecef1e4aaece71ef357285c2df71056ae0314=20
db98699a6c68b653be1fa8dceb64204397d9814cd1=20
db/db.sqlfed89aa6a337c6ab5a89dba13702a65ab70372bd=20
httpff2a325bfd33f1fb7098b5688ffe99fe67bf5874=20
http/apifbf53a7bcd223485e56d30715a794a7e067df8d2=20
http/api/.htaccess84d1f0580e88c6351df884200ebcd526d8b145ea=20
http/api/index.php9b8a7a21fa6e4c3a9672469b9b4a7e51a336d015=20
http/www9a464b3db152808bc74512304054ac25a63cb9b7=20
http/www/files8cab2dab60f85385de1ef984a976a038176c2015=20
http/www/files/foundationa5cb50f4203d7176a505857ac80ffbbcf562c91f=20
http/www/files/foundation/cssc2a844c8a00ef41d912f53c40026580f2b10fd00=20
http/www/files/foundation/css/accessibility_foundicons.css699d805b9f585=
8111d4bc95705df22f6137ec14a=20
http/www/files/foundation/css/accessibility_foundicons_ie7.css8e0ddf1ac=
316d9231277a77bcd550895f291b5c7=20
http/www/files/foundation/css/foundation.css1d592b3fc77c4b44af67b82edbe=
e4cc51b8a97d9=20
http/www/files/foundation/css/foundation.min.css3c308c85cf36052810d35c0=
8d4f5bbc233cf61ea=20
http/www/files/foundation/css/general_foundicons.cssd5b3776730a16e4ec61=
bad31526cc0a5a24096bc=20
http/www/files/foundation/css/general_foundicons_ie7.cssa9c6f52f05e50c6=
fd8dab6c30e22c8d4ea2f15ea=20
http/www/files/foundation/css/normalize.css914f6472ffce7135f191048a923e=
07e7886f192b=20
http/www/files/foundation/css/social_foundicons.css6a3c9c07729fc466c38e=
6a40d36b298de881706b=20
http/www/files/foundation/css/social_foundicons_ie7.cssd44839248d958fdc=
96fa044dae0ea71dffd35bde=20
http/www/files/foundation/fonts5008ddfcf53c02e82d7eee2e57c38e5672ef89f6=
=20
http/www/files/foundation/fonts/.DS_Store237a0ca97e568531dc58bf7c812020=
28af1e881c=20
http/www/files/foundation/fonts/accessibility_foundicons.eot49c0d07bea6=
f18cdbc35ee938b1b3f48cacce64c=20
http/www/files/foundation/fonts/accessibility_foundicons.svg46a67f8d022=
3b881ca74ccafb44b64664552b937=20
http/www/files/foundation/fonts/accessibility_foundicons.ttf4eae85189fe=
e6930191b69e31a09b34e6a9a9c19=20
http/www/files/foundation/fonts/accessibility_foundicons.woff20733a0388=
ef77572cbc55cbf76cc46babf0a15d=20
http/www/files/foundation/fonts/general_foundicons.eota9347515264ac712b=
5d083eaa231929243ea7142=20
http/www/files/foundation/fonts/general_foundicons.svg90a5ccead2d84d036=
bd8ed66926af93b21621df5=20
http/www/files/foundation/fonts/general_foundicons.ttfdaab63141b07e0a1f=
a8efd931a98945b837bd4aa=20
http/www/files/foundation/fonts/general_foundicons.woffa9341f49f12c10aa=
a5db2bc74ed3889245ce9a3a=20
http/www/files/foundation/fonts/social_foundicons.eoteb4189cd70c623deaa=
25e5bb55ab210d27fe2d14=20
http/www/files/foundation/fonts/social_foundicons.svg01158c66b13b6f90e7=
b7d1cdb5c4e7369c6434ae=20
http/www/files/foundation/fonts/social_foundicons.ttfbd1f1e58a692b73205=
fce579faee81801d3157aa=20
http/www/files/foundation/fonts/social_foundicons.woffcd2531e2044a9c187=
5159ff1278aafac1aaa8944=20
http/www/files/foundation/img8b137891791fe96927ad78e64b0aad7bded08bdc=20
http/www/files/foundation/img/.gitkeep36b90e58095363e46845d98d979700d16=
019830e=20
http/www/files/foundation/js596287860dbdcd04dd8a78d2ee1999862286515a=20
http/www/files/foundation/js/foundation.min.jsec14148b2d83476fffebf3cba=
39d6516844b7200=20
http/www/files/foundation/js/foundationb78a35a14d000346914644cc0e9783a4=
0f64760d=20
http/www/files/foundation/js/foundation/foundation.alerts.jsc8ff3249917=
62b763dd936da49415fff1ec2de93=20
http/www/files/foundation/js/foundation/foundation.clearing.js862027c86=
31db60070e8c3ebd7b8953c0283c561=20
http/www/files/foundation/js/foundation/foundation.cookie.js24b35e12e78=
60a80edb9f16a0209715f249f96b0=20
http/www/files/foundation/js/foundation/foundation.dropdown.js6a27af4ad=
0e0865235cd3a84cd251b8f928510ba=20
http/www/files/foundation/js/foundation/foundation.forms.js323e6e1e633a=
ce0dcc873553b8df03a28bcd78bc=20
http/www/files/foundation/js/foundation/foundation.joyride.js87c3b65bd9=
231264c110749b7ad75214cee50c93=20
http/www/files/foundation/js/foundation/foundation.js3cdef5b617b054a355=
f80a5bce164cc1ed8a419e=20
http/www/files/foundation/js/foundation/foundation.magellan.js54c467efd=
46e3c199ae4dd0860ee5196403b1027=20
http/www/files/foundation/js/foundation/foundation.orbit.js65c18fc2b438=
3b5111953114c13ebdb2ba3c5cda=20
http/www/files/foundation/js/foundation/foundation.placeholder.js31a450=
ad44b7ec6593bdefc4a88c781a45c418e1=20
http/www/files/foundation/js/foundation/foundation.reveal.js1069794478f=
6c4032e1caf4ecc24bce961482835=20
http/www/files/foundation/js/foundation/foundation.section.js1696e2ad5b=
bf72ba052f9aa4105e58edee08b16f=20
http/www/files/foundation/js/foundation/foundation.tooltips.js8cc27f1c1=
8db7281602cc4f7d0a193c199ab2d40=20
http/www/files/foundation/js/foundation/foundation.topbar.js14566fdbdbd=
e4c4369ba4b8d0ce646c4621efeb1=20
http/www/files/foundation/js/vendore5afa6ca3c2624ca9e253f5626ae46355ada=
74e3=20
http/www/files/foundation/js/vendor/custom.modernizr.js6362d0f3394e4a90=
561ab33c0650d32572ae4d93=20
http/www/files/foundation/js/vendor/jquery.jsb74544c5cf84ac78d2030c28cd=
9f521e80136b5f=20
http/www/files/foundation/js/vendor/zepto.js006488437dda8a1ec87a3e912a7=
9a5918f170dde=20
http/www/files/scripts4e6c262c7d9a2fcc37206422a434e92cda10cd6a=20
http/www/files/scripts/ajax.jse2c203fe978b83f4ca8d1ba97633f5a5d50bd53b=20
http/www/files/scripts/jquery-1.9.1.js6896a531cd562cc4a2eb31e2be0e81319=
05a90e0=20
http/www/files/scripts/sha512.js272f790b91010bed997f0ed7d4a616f03e627a6=
a=20
http/www/index.phpc3ed262f3c30a40ed5cb19a85ade3d891999962c=20
server_filesc4769e6f5ade18f1dea9eb1e44743378cb7e2c5a=20
server_files/api_classesc31151cdf2d4a6136fe95089b39eb3d3cecdf3c3=20
server_files/api_classes/user.php07a7fb0ccef6095c719eaed8d5f30dd933e2a4=
81 server_files/libraries51d26aa3fb9789f86adf6e4b051fa98ce2b085a4=20
server_files/libraries/debugmode.phpd1f719cbf6df5c0b5d4e2269aa4f049d8c1=
c110e=20
server_files/libraries/restlerc282fca7ac71e27ac69fa3ac4cb19367f7ceee00=20
server_files/libraries/restler/.gitignore7e60fed960715e64352fdd71f37ccf=
e21089a698=20
server_files/libraries/restler/Makefile249b48318375db88df5e2dec82c3744a=
227bac26=20
server_files/libraries/restler/behat.ymld146d2faf7cd849dea5a92e51d68210=
950afa0db=20
server_files/libraries/restler/composer.json2647195ac4d70915a9c37550e3c=
bab1be0743f60=20
server_files/libraries/restler/features2d54de98adbf5a1e14442224fa8171b9=
2b390282=20
server_files/libraries/restler/features/bootstrap6410644b72c83bb9828256=
5ed4c36a153da971b2=20
server_files/libraries/restler/features/bootstrap/FeatureContext.php735=
335f569291358a5c686c563a63d42f65f937b=20
server_files/libraries/restler/features/bootstrap/RestContext.phpdb7a95=
490db63d21bd31d8696e36c0c7b5448e2b=20
server_files/libraries/restler/features/examples52e4ee9ecc56fc6f413ad74=
f167065767762cf8d=20
server_files/libraries/restler/features/examples/README.md047040c098b29=
9ae613ea9130fbdfd692fe47fc7=20
server_files/libraries/restler/features/examples/_001_helloworld.featur=
e980e1b995f6a54a457b23d76521cce01de627f61=20
server_files/libraries/restler/features/examples/_002_minimal.feature84=
94a30df1e517c583ac3b75d8944ee54d20d2f5=20
server_files/libraries/restler/features/examples/_003_multiformat.featu=
ref904c711a9fab32bac7ea154f08b74c2afb0f453=20
server_files/libraries/restler/features/examples/_007_crud.featurec3b7f=
3cbfc922c5b30e709b8905248df55b1e98d=20
server_files/libraries/restler/features/restler7662d15589e21b722ca9b1cb=
f93c0d980cf537e0=20
server_files/libraries/restler/features/restler/README.md1ea9b86ff3664b=
1c4b4677a06fa21e501a321e19=20
server_files/libraries/restler/features/restler/annotations.feature8b28=
7855d03b65b799bcd8ab1bfd32c3b7c3e7af=20
server_files/libraries/restler/features/restler/negotiation-charset.fea=
ture6133bd92aa4418f7b7ae87ce2cbf3b31b1b3abf2=20
server_files/libraries/restler/features/restler/negotiation-format.feat=
ure62c0e60e61666ac5d9e7ad29f91f50e83b95b887=20
server_files/libraries/restler/features/restler/negotiation-language.fe=
atureaf5398fb75edd6af13a704aec2cf286cda22cdfe=20
server_files/libraries/restler/features/restler/status_codes.feature7be=
48e8c9ed0731652f93bfb597f08f97119057a=20
server_files/libraries/restler/package.ini190fe81d5dec8a7396a11e058af36=
f997932571e=20
server_files/libraries/restler/public1e233c708ae24f014dc6f4d7e64c2035e2=
c5c7b9=20
server_files/libraries/restler/public/examples9acb45400ebf68a221904d386=
3624de97c2e6316=20
server_files/libraries/restler/public/examples/_001_helloworld06d1b6d6e=
ebe8c51e03acb677ae6328a3a6785bf=20
server_files/libraries/restler/public/examples/_001_helloworld/.htacces=
sc2d3c9e0c24eefa7bb5d8f02bafebc4ce8edbe4c=20
server_files/libraries/restler/public/examples/_001_helloworld/Say.php9=
919a3eb14f0907c108ee989e6ce0e2a7213c0eb=20
server_files/libraries/restler/public/examples/_001_helloworld/index.ph=
pcc07de806e5991e33d27b22cc64050fcaa730cbe=20
server_files/libraries/restler/public/examples/_001_helloworld/readme.h=
tml038c2f9705721cad78862806d23c6843dec33069=20
server_files/libraries/restler/public/examples/_001_helloworld/readme.m=
d9068749a625fc43b3a0264c49140cfb147439aa5=20
server_files/libraries/restler/public/examples/_002_minimal0704f694155b=
8b7d68c887ba4aa95bcdfd250fef=20
server_files/libraries/restler/public/examples/_002_minimal/.htaccess29=
644e7401b629eb6d1a097872a998495ce19edf=20
server_files/libraries/restler/public/examples/_002_minimal/Math.phpe3f=
0f23c932c6cee991ea63c084fec44d9dfaafa=20
server_files/libraries/restler/public/examples/_002_minimal/index.php1f=
8fd0b99415c1b315407064737a792e0b744d88=20
server_files/libraries/restler/public/examples/_002_minimal/readme.html=
c93eeddcc30079a1bd62edb88f229ee951bb4271=20
server_files/libraries/restler/public/examples/_002_minimal/readme.md7c=
187a1f2a58391032833d64230848c380b7aab8=20
server_files/libraries/restler/public/examples/_003_multiformatc49bc802=
bf0ae84473727b94a7386cd914c85423=20
server_files/libraries/restler/public/examples/_003_multiformat/BMI.php=
9da7ae6f117734c6117a6c8b54393e91af6e742f=20
server_files/libraries/restler/public/examples/_003_multiformat/index.p=
hp10f91065493c3e09c07a94afa8e5ddeef96f3ea3=20
server_files/libraries/restler/public/examples/_003_multiformat/readme.=
html427d73c1e3e7b3fe17b012884b99d657f7f3f578=20
server_files/libraries/restler/public/examples/_003_multiformat/readme.=
mdd82721c7b2ca5ab27bf5481553f7d6ab611d4405=20
server_files/libraries/restler/public/examples/_004_error_response4cd66=
b540f1808b740ac111a4025baa4a0ab03ec=20
server_files/libraries/restler/public/examples/_004_error_response/Curr=
ency.php8100292b2350e778532a4f8c069381454a55e1bd=20
server_files/libraries/restler/public/examples/_004_error_response/inde=
x.phpc1e22f76f20d7e7a40b8b6746824ecb21c3b0edf=20
server_files/libraries/restler/public/examples/_004_error_response/read=
me.html37c7c3d1f106ae143099d1899efe111454a44dd7=20
server_files/libraries/restler/public/examples/_004_error_response/read=
me.md9d0b58ccb1b725a7356b8cd1fb8f57a55ad18b17=20
server_files/libraries/restler/public/examples/_005_protected_api472b59=
421e5154a4a9d9bae69b2bc89cb8c96e7b=20
server_files/libraries/restler/public/examples/_005_protected_api/Secur=
ed.php13869b74f5020934c2575d43639d33ddada1cd9c=20
server_files/libraries/restler/public/examples/_005_protected_api/Simpl=
e.phpfa9b07eb5b0a3b71e0f91c106d6df440adafe1c9=20
server_files/libraries/restler/public/examples/_005_protected_api/Simpl=
eAuth.phpe7412bea250fa574e1beadd428dfcd2c0770e34e=20
server_files/libraries/r
packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
bbadedcc30b580f950f9023b060769c620c963c7 refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000


On 04/11/2013 07:37 PM, Jonathan Nieder wrote:
 > Hello,
 >
 > Jo=E3o Joyce wrote:
 >
 >> I am not sure this is the right place to ask this.
 > You're in the right place.
 >
 > [...]
 >> I am trying to push some files to a server with git push. I have
 >> configured the server to push the files:
 >>      git remote set-url test ssh://user@location.com:2200/fullpath/
 >>
 >> but I am getting the following error:
 >>      git send-pack: protocol error: bad band #50
 >>      fatal: The remote end hung up unexpectedly
 > That means that where git expected to read a binary sideband number,
 > it instead received the byte \x32 (ASCII '2').
 >
 > Without more details, it's hard to debug this further.  Can you get
 > a trace of the communication by setting the envvar
 > GIT_TRACE_PACKET=3D/tmp/log on the client?
 >
 > Thanks and hope that helps,
 > Jonathan
 >

Hi,

Thank you for the help. Here is the trace:

packet:         push< 0000000000000000000000000000000000000000=20
capabilities^{}\0 report-status delete-refs side-band-64k quiet ofs-del=
ta
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000=20
17c420b8bd99856aee6da9c1743f6df0ec18a9ca refs/heads/master\0=20
report-status side-band-64k
packet:         push> 0000
packet:         push<=20
20b8bd99856aee6da9c1743f6df0ec18a9cac28267338c198573ad59e89d0acc445a62b=
3d127=20
acf853d0a30287d9455dbe1707edeb16cc3e9b22=20
conf.php845ecef1e4aaece71ef357285c2df71056ae0314=20
db98699a6c68b653be1fa8dceb64204397d9814cd1=20
db/db.sqlfed89aa6a337c6ab5a89dba13702a65ab70372bd=20
httpff2a325bfd33f1fb7098b5688ffe99fe67bf5874=20
http/apifbf53a7bcd223485e56d30715a794a7e067df8d2=20
http/api/.htaccess84d1f0580e88c6351df884200ebcd526d8b145ea=20
http/api/index.php9b8a7a21fa6e4c3a9672469b9b4a7e51a336d015=20
http/www9a464b3db152808bc74512304054ac25a63cb9b7=20
http/www/files8cab2dab60f85385de1ef984a976a038176c2015=20
http/www/files/foundationa5cb50f4203d7176a505857ac80ffbbcf562c91f=20
http/www/files/foundation/cssc2a844c8a00ef41d912f53c40026580f2b10fd00=20
http/www/files/foundation/css/accessibility_foundicons.css699d805b9f585=
8111d4bc95705df22f6137ec14a=20
http/www/files/foundation/css/accessibility_foundicons_ie7.css8e0ddf1ac=
316d9231277a77bcd550895f291b5c7=20
http/www/files/foundation/css/foundation.css1d592b3fc77c4b44af67b82edbe=
e4cc51b8a97d9=20
http/www/files/foundation/css/foundation.min.css3c308c85cf36052810d35c0=
8d4f5bbc233cf61ea=20
http/www/files/foundation/css/general_foundicons.cssd5b3776730a16e4ec61=
bad31526cc0a5a24096bc=20
http/www/files/foundation/css/general_foundicons_ie7.cssa9c6f52f05e50c6=
fd8dab6c30e22c8d4ea2f15ea=20
http/www/files/foundation/css/normalize.css914f6472ffce7135f191048a923e=
07e7886f192b=20
http/www/files/foundation/css/social_foundicons.css6a3c9c07729fc466c38e=
6a40d36b298de881706b=20
http/www/files/foundation/css/social_foundicons_ie7.cssd44839248d958fdc=
96fa044dae0ea71dffd35bde=20
http/www/files/foundation/fonts5008ddfcf53c02e82d7eee2e57c38e5672ef89f6=
=20
http/www/files/foundation/fonts/.DS_Store237a0ca97e568531dc58bf7c812020=
28af1e881c=20
http/www/files/foundation/fonts/accessibility_foundicons.eot49c0d07bea6=
f18cdbc35ee938b1b3f48cacce64c=20
http/www/files/foundation/fonts/accessibility_foundicons.svg46a67f8d022=
3b881ca74ccafb44b64664552b937=20
http/www/files/foundation/fonts/accessibility_foundicons.ttf4eae85189fe=
e6930191b69e31a09b34e6a9a9c19=20
http/www/files/foundation/fonts/accessibility_foundicons.woff20733a0388=
ef77572cbc55cbf76cc46babf0a15d=20
http/www/files/foundation/fonts/general_foundicons.eota9347515264ac712b=
5d083eaa231929243ea7142=20
http/www/files/foundation/fonts/general_foundicons.svg90a5ccead2d84d036=
bd8ed66926af93b21621df5=20
http/www/files/foundation/fonts/general_foundicons.ttfdaab63141b07e0a1f=
a8efd931a98945b837bd4aa=20
http/www/files/foundation/fonts/general_foundicons.woffa9341f49f12c10aa=
a5db2bc74ed3889245ce9a3a=20
http/www/files/foundation/fonts/social_foundicons.eoteb4189cd70c623deaa=
25e5bb55ab210d27fe2d14=20
http/www/files/foundation/fonts/social_foundicons.svg01158c66b13b6f90e7=
b7d1cdb5c4e7369c6434ae=20
http/www/files/foundation/fonts/social_foundicons.ttfbd1f1e58a692b73205=
fce579faee81801d3157aa=20
http/www/files/foundation/fonts/social_foundicons.woffcd2531e2044a9c187=
5159ff1278aafac1aaa8944=20
http/www/files/foundation/img8b137891791fe96927ad78e64b0aad7bded08bdc=20
http/www/files/foundation/img/.gitkeep36b90e58095363e46845d98d979700d16=
019830e=20
http/www/files/foundation/js596287860dbdcd04dd8a78d2ee1999862286515a=20
http/www/files/foundation/js/foundation.min.jsec14148b2d83476fffebf3cba=
39d6516844b7200=20
http/www/files/foundation/js/foundationb78a35a14d000346914644cc0e9783a4=
0f64760d=20
http/www/files/foundation/js/foundation/foundation.alerts.jsc8ff3249917=
62b763dd936da49415fff1ec2de93=20
http/www/files/foundation/js/foundation/foundation.clearing.js862027c86=
31db60070e8c3ebd7b8953c0283c561=20
http/www/files/foundation/js/foundation/foundation.cookie.js24b35e12e78=
60a80edb9f16a0209715f249f96b0=20
http/www/files/foundation/js/foundation/foundation.dropdown.js6a27af4ad=
0e0865235cd3a84cd251b8f928510ba=20
http/www/files/foundation/js/foundation/foundation.forms.js323e6e1e633a=
ce0dcc873553b8df03a28bcd78bc=20
http/www/files/foundation/js/foundation/foundation.joyride.js87c3b65bd9=
231264c110749b7ad75214cee50c93=20
http/www/files/foundation/js/foundation/foundation.js3cdef5b617b054a355=
f80a5bce164cc1ed8a419e=20
http/www/files/foundation/js/foundation/foundation.magellan.js54c467efd=
46e3c199ae4dd0860ee5196403b1027=20
http/www/files/foundation/js/foundation/foundation.orbit.js65c18fc2b438=
3b5111953114c13ebdb2ba3c5cda=20
http/www/files/foundation/js/foundation/foundation.placeholder.js31a450=
ad44b7ec6593bdefc4a88c781a45c418e1=20
http/www/files/foundation/js/foundation/foundation.reveal.js1069794478f=
6c4032e1caf4ecc24bce961482835=20
http/www/files/foundation/js/foundation/foundation.section.js1696e2ad5b=
bf72ba052f9aa4105e58edee08b16f=20
http/www/files/foundation/js/foundation/foundation.tooltips.js8cc27f1c1=
8db7281602cc4f7d0a193c199ab2d40=20
http/www/files/foundation/js/foundation/foundation.topbar.js14566fdbdbd=
e4c4369ba4b8d0ce646c4621efeb1=20
http/www/files/foundation/js/vendore5afa6ca3c2624ca9e253f5626ae46355ada=
74e3=20
http/www/files/foundation/js/vendor/custom.modernizr.js6362d0f3394e4a90=
561ab33c0650d32572ae4d93=20
http/www/files/foundation/js/vendor/jquery.jsb74544c5cf84ac78d2030c28cd=
9f521e80136b5f=20
http/www/files/foundation/js/vendor/zepto.js006488437dda8a1ec87a3e912a7=
9a5918f170dde=20
http/www/files/scripts4e6c262c7d9a2fcc37206422a434e92cda10cd6a=20
http/www/files/scripts/ajax.jse2c203fe978b83f4ca8d1ba97633f5a5d50bd53b=20
http/www/files/scripts/jquery-1.9.1.js6896a531cd562cc4a2eb31e2be0e81319=
05a90e0=20
http/www/files/scripts/sha512.js272f790b91010bed997f0ed7d4a616f03e627a6=
a=20
http/www/index.phpb1fd6c496624710b8748877d7512766018178342=20
server_filesc4769e6f5ade18f1dea9eb1e44743378cb7e2c5a=20
server_files/api_classesc31151cdf2d4a6136fe95089b39eb3d3cecdf3c3=20
server_files/api_classes/user.phpe61c5338616a6b0e32e953c603944fc088a82b=
d1 server_files/libraries51d26aa3fb9789f86adf6e4b051fa98ce2b085a4=20
server_files/libraries/debugmode.php8f3a40b616c83a77235d1a16a230ee6996c=
fca2b=20
server_files/libraries/restlerc282fca7ac71e27ac69fa3ac4cb19367f7ceee00=20
server_files/libraries/restler/.gitignore7e60fed960715e64352fdd71f37ccf=
e21089a698=20
server_files/libraries/restler/Makefileffa7a78d0ba68d1bba59e04532aa856b=
14afc817=20
server_files/libraries/restler/README.md249b48318375db88df5e2dec82c3744=
a227bac26=20
s
