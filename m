From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 19:33:31 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706101933.36760.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101704.51374.ismail@pardus.org.tr> <e5bfff550706100736v110055acn8ecca19f5c3f5cff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart39386902.gFvqxBQNY4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 18:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxQMX-0002p5-2C
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 18:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbXFJQd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXFJQdz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 12:33:55 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:45642 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750817AbXFJQdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 12:33:55 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 3CF3260300C5;
	Sun, 10 Jun 2007 19:33:47 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706100736v110055acn8ecca19f5c3f5cff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49748>

--nextPart39386902.gFvqxBQNY4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 17:36:42 you wrote:
> On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > Uploaded to http://cekirdek.pardus.org.tr/~ismail/tmp/qgit4-report.txt .
>
> Ok. You seem to miss all the debug libraries  _and_ the whole
> libQtUiTools library.

Nope not a Qt problem. Removing -frepo from CXXFLAGS fixes the issue. Gcc=20
4.2.0 doesn't seem to like it for some reason.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart39386902.gFvqxBQNY4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmwn4Ee9qviWcMsnAQKx0xAAlfTuPelQkGcdfWhveLVs4sN+5q1QzmlR
dUpE9E8KCi0aJ0WVmpDrP57qXwb5LzF2u5cz5ANnADfCS/yAXEOoWreKX30Hybm5
SIe3lEiTJaSX4h0e6n4sgnhOI1CyW/OuNfeCuFoL3fXfiodWrr7tpCpMCmjxeBoY
YhEJh6ixq+JLFQziGH0H1iaDFtWveGRuT3lTD9/U02K9NlgJc8sNmlxiCnTwNFY3
xYYc5Q4vzj//5/WMqfUheshj2PoP5pUfQzF8Dm7EH27NKcjkWx550vGqDxJf95rL
flVerStvx+MTxEkSyyVgfO7g9X77xDTuAOwvDHwyBwLnm9sSt8GNCuOTJz1lu1cf
eENd5J8tU9UnpaADqBGdrdtcD2Y11QkkardBLFMzsIavuqhv1kIXIgdPVGtUdnkk
hpkykOJt56zCVs5R8pQMSifGqrGzPpR6MO9PlnbUucMI+js5GIZ/mlwQR+goe06Y
NjxhZ9B4u6d3YV+7pMkvjWExKi1BUb3LKkbc23Tmi6Xfq9HFFIf+amFDN4cf9ek0
JFb/7XiwzBPWSkaxntGUvIkNRJgmvv0iH6QUYwiXJRXL6/QN3sJoqOpF2RoPs6mc
krW7t+1qxqqOD+6ieb+k5Lag8OSYKFAtETh9Ae9nF2qjkFSCmTSZ/F9VcFOym3AX
QJNIS2WQ1Cs=
=2Ef4
-----END PGP SIGNATURE-----

--nextPart39386902.gFvqxBQNY4--
