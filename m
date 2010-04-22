From: Serge Ziryukin <ftrvxmtrx@gmail.com>
Subject: [PATCH 1/2] fix gitk-git russian translation typos
Date: Fri, 23 Apr 2010 01:03:20 +0300
Message-ID: <20100422220320.GA16317@ftrvxmtrx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 00:04:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54VO-00048L-PX
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 00:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0DVWD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 18:03:56 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:41840 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0DVWDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 18:03:42 -0400
Received: by bwz25 with SMTP id 25so10253540bwz.28
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=H2vZGPnIWr1k5VnZLCCFHusxK2QK8nxYFt6XDYBZpeA=;
        b=i3f5GilABwnY9cjHTJ7x/2vLjdNAVa0n2dw7X/Vli3M1rZNcWEQDvJdp1HM9P8NIfq
         EA9cHiRXtegtYdV2HdgRvPqnraIFj0QkvDoh+P6BQw9t51s4EEzVEIQzFEIr0jF/DuEd
         WCfU7f5xeJNIKs8CCSFiXwkOwiooVSyeEIspY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=oVuOn8E7qZIOLhq/ZqO49jvlvPGTHgPFPimIk+5sAMI4fKUdJGdvn9OZ4mnN3BtwUS
         XCGuOC9aBJ0ibTlxHJ9tMz3p0ve9m9NXEm8GCK82AnsTHeFoaBGQpFYPDM+WAZ9JtpGE
         pBiMHgJEO+cotYb+TWy/8Rx0Zpmmgg4h2fCTM=
Received: by 10.204.126.84 with SMTP id b20mr288516bks.61.1271973820768;
        Thu, 22 Apr 2010 15:03:40 -0700 (PDT)
Received: from ftrvxmtrx@gmail.com ([86.57.195.105])
        by mx.google.com with ESMTPS id 16sm133689bwz.9.2010.04.22.15.03.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 15:03:40 -0700 (PDT)
Received: by ftrvxmtrx@gmail.com (sSMTP sendmail emulation); Fri, 23 Apr 2010 01:03:20 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.18-muttng (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145571>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Serge Ziryukin <ftrvxmtrx@gmail.com>
---
 gitk-git/po/ru.po |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitk-git/po/ru.po b/gitk-git/po/ru.po
index c3d0285..dfd1e1c 100644
--- a/gitk-git/po/ru.po
+++ b/gitk-git/po/ru.po
@@ -246,11 +246,11 @@ msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B"
=20
 #: gitk:2326 gitk:2339
 msgid "Diff this -> selected"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=D1=
=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D1=8B=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=D1=
=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
=20
 #: gitk:2327 gitk:2340
 msgid "Diff selected -> this"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=D0=BC =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=D0=
=BC =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
=20
 #: gitk:2328 gitk:2341
 msgid "Make patch"
@@ -440,11 +440,11 @@ msgstr "<%s-F>\t\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
 #: gitk:2666
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
-msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=81=
=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=B9=
=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E"
+msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=81=
=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=B9=
=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=
=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2667
 msgid "<Return>\tMove to next find hit"
-msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=81=
=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=B9=
=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E"
+msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=81=
=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=B9=
=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=
=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2668
 msgid "/\t\tFocus the search box"
@@ -452,7 +452,7 @@ msgstr "/\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8=
 =D0=BA =D0=BF=D0=BE=D0=BB=D1=8E =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=B0"
=20
 #: gitk:2669
 msgid "?\t\tMove to previous find hit"
-msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2670
 msgid "f\t\tScroll diff view to next file"
@@ -466,7 +466,7 @@ msgstr "<%s-S>\t\t=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=
=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=B8=D1=81=D0=BA =D0=B2 =D1=81=D0=BF=
=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD
 #: gitk:2672
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
-msgstr "<%s-R>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=
=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=
=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=82=D0=B5=D0=BA=D1=81=D1=82=
=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+msgstr "<%s-R>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=
=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=
=D0=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=82=D0=B5=D0=BA=D1=81=
=D1=82=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
=20
 #: gitk:2673
 #, tcl-format
@@ -855,14 +855,14 @@ msgstr "=D0=9B=D1=91=D0=B3=D0=BA=D0=B8=D0=B9: =D0=BE=
=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=
=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=B8 =D0=B8=D0=BD=
=D0=B4=D0=B5
 #: gitk:8472
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
-"=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BD=D1=8B=D0=B9: =D0=BE=D1=81=D1=82=D0=
=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=
=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5=D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=BD=D1=8B=D0=BC, =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=
=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
+"=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9: =D0=BE=D1=81=D1=
=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=
=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5=D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC, =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=
=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: gitk:8475
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
 msgstr ""
-"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=D0=B5=D0=
=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=
=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3\n"
+"=D0=96=D1=91=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=D0=B5=D0=
=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=
=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3\n"
 "(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3=D0=B8 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=BE=D1=
=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
=20
 #: gitk:8492
--=20
1.7.0.5


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvQx6gACgkQUT3RpZIpZv5PIACeJFFZK8Hn/R8cns/HCz34rapK
tCcAnjvV6bgkGbHL9R74VvOFlUnQiYDY
=QL7M
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
