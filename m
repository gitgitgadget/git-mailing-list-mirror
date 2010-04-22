From: Serge Ziryukin <ftrvxmtrx@gmail.com>
Subject: [PATCH 2/2] fix git-gui russian translation typos
Date: Fri, 23 Apr 2010 01:04:28 +0300
Message-ID: <20100422220428.GA16333@ftrvxmtrx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 00:04:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54W1-0004O4-O9
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 00:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0DVWEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 18:04:51 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:50198 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0DVWEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 18:04:50 -0400
Received: by bwz25 with SMTP id 25so10254781bwz.28
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=rFMmGJ3dnlcx7LmStOTdbKpKEdumMDcrQMnwSXGZ8TM=;
        b=Zn1eQxR/6MlgY+wxvr/kt6CYEhBLPjCxIv9I2WPcY/HyAsnlFQo0yd3YeJ53YHVDU3
         c/Lwl5C8iVgD8aBK1lWGsObhIFSHm8bYsCqEpC/ue/l6PHGPaTobsAzymW0E6f8pqONR
         +3q9Ks6G+g9bGVfcs7IeMhy+Jk/iLFcunsOMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=acgAUYDl8CeztMH7ZDAjaDimK+q25H03AJOcAdFFFjljxGLi4Iwng/93fUSkN5tNz5
         iyqD+Tjh+T8/lbgfOxGNgSIgFevJmOJ3tpWAiMotfrNBz7iugBGG1pp7nG0qnssMwFiC
         zBJ5utijmELdZORz9Ze/9Rd7DNRDJGq4EZhQQ=
Received: by 10.204.10.152 with SMTP id p24mr2723337bkp.94.1271973888716;
        Thu, 22 Apr 2010 15:04:48 -0700 (PDT)
Received: from ftrvxmtrx@gmail.com ([86.57.195.105])
        by mx.google.com with ESMTPS id 15sm133291bwz.0.2010.04.22.15.04.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 15:04:48 -0700 (PDT)
Received: by ftrvxmtrx@gmail.com (sSMTP sendmail emulation); Fri, 23 Apr 2010 01:04:28 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.18-muttng (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145572>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Serge Ziryukin <ftrvxmtrx@gmail.com>
---
 git-gui/po/ru.po |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/po/ru.po b/git-gui/po/ru.po
index 364c074..c15bdfa 100644
--- a/git-gui/po/ru.po
+++ b/git-gui/po/ru.po
@@ -2292,11 +2292,11 @@ msgstr "=D0=A1=D0=BB=D0=BE=D0=B2=D0=B0=D1=80=D1=8C =
=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82 =D0=BA %s."
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BC=D0=BE=D0=
=B3=D0=BB=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=81=D1=
=8F"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BC=D0=BE=D0=
=B3=D0=BB=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C=D1=
=81=D1=8F"
=20
 #: lib/spellcheck.tcl:80
 msgid "Unrecognized spell checker"
-msgstr "=D0=9D=D0=B5=D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D0=BD=
=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=
=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=9D=D0=B5=D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D0=BD=
=D0=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =
=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
=20
 #: lib/spellcheck.tcl:186
 msgid "No Suggestions"
--=20
1.7.0.5


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvQx+wACgkQUT3RpZIpZv7BiQCfXX9wlEXcYADLRgCTm8i1f1RY
uqIAn1K+/wap/fCju66lpsBMNilH7359
=MIhH
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
