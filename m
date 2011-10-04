From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] po/pl.po: Eliminate fuzzy translations
Date: Tue, 04 Oct 2011 10:23:48 +0200
Message-ID: <4E8AC294.2060608@in.waw.pl>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com> <m3ipre4dtf.fsf@localhost.localdomain> <CACBZZX7wj=j9Mx-m0HrRoRHP1HOSVpn-7o0YVnY6LsfWzuw8aw@mail.gmail.com> <201110032337.09975.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?TWFyY2luIENpZcWbbGFr?= <saper@saper.info>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 10:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB0HN-00027h-Sx
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 10:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab1JDIXD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 04:23:03 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:51661 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289Ab1JDIXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 04:23:00 -0400
Received: from beck.fuw.edu.pl ([193.0.82.235])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RB0HD-0004Xx-Sw; Tue, 04 Oct 2011 10:23:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Icedove/3.1.13
In-Reply-To: <201110032337.09975.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182748>

On 10/03/2011 11:37 PM, Jakub Narebski wrote:
+# Terminologia dla kluczowych termin=C3=B3w z Subversion:
+# path - =C5=9Bcie=C5=BCka
+# URL - URL
+# file - plik
+# directory - katalog
+# update - aktualizacja
+# commit - zatwierdzenie, zatwierdzenie zmian
This seems kind of awkward. E.g. 'initial commit' would become=20
'pocz=C4=85tkowe zatwierdzenie zmian' or 'pierwsze zatwierdzenie', whic=
h just=20
doesn't sound right. What about starting with the mercurial term=20
'changeset'? Git users also use 'commit' to mean 'change', so maybe
the polish translation of this crucial term should be 'zmiana':
'initial commit' -- 'pocz=C4=85tkowa zmiana' or 'pierwsza zmiana'
'commit message' -- 'opis zmiany'

+# version control - zarz=C4=85dzanie wersjami
+# repository - repozytorium
+# branch - odga=C5=82=C4=99zienie
'ga=C5=82=C4=85=C5=BA'? I think that's the translation which is used in=
 informal=20
conversations.

+# tag - tag
'metka', 'etykieta' according to the dictionary. I'm aware of 'metka'
being used in CS anywhere, but it is short, and pretty cool, IMO.

+# merge - =C5=82=C4=85czenie zmian
'=C5=82=C4=85czenie ga=C5=82=C4=99zi'?

+# conflict - konflikt
+# property - atrybut
+# revision - wersja
+# log message - opis zmian
+# entry/item - element
+# ancestry - pochodzenie
+# ancestor - przodek
+# working copy - kopia robocza
+# working dir - bie=C5=BC=C4=85cy katalog
+# usage - wykorzystanie
'u=C5=BCycie', 'wywo=C5=82anie'?
E.g. 'standardowe wywo=C5=82anie tego programu to: prog arg'

+# source - =C5=BAr=C3=B3d=C5=82owy
+# destination - docelowy
+# hook - skrypt (skrypt repozytorium)
+# exclude - wykluczy=C4=87
+# crop - obci=C4=85=C4=87
+# cache - pami=C4=99=C4=87 podr=C4=99czna
+# child - obiekt podrz=C4=99dny
Standard CS term is 'ojciec' and 'syn' for 'parent/child'.

+# obliteration - obliteracja
'wymazanie'?

+# patch - =C5=82ata
+# notes - adnotacja

Zbyszek
