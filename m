From: Serge Ziryukin <ftrvxmtrx@gmail.com>
Subject: [PATCH] gitk-git: follow-up patch to fix one missed typo
Date: Fri, 23 Apr 2010 10:19:36 +0300
Message-ID: <20100423071936.GA17181@ftrvxmtrx>
References: <20100422220320.GA16317@ftrvxmtrx> <201004231000.44435.igor@gplsoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: Igor Murzov <intergalactic.anonymous@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 09:20:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5DBE-0006bo-G6
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 09:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab0DWHT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 03:19:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51338 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0DWHT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 03:19:56 -0400
Received: by wyb39 with SMTP id 39so5358566wyb.19
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=dDOG6o9uNy3RwPPitj0NOi45YP/SONiIuIDW38FjxqQ=;
        b=DTmVZLkKJQfjG1Rj28+dRFyGIX+ZysKGcLzbmRhdrLC7V3aL0DuHZuXWHBrqTNq+Aa
         s121cJn9JWrDlUJg6Q308tjH8eOocr8cSkCCki017qVldubYwYrT90nCUxFGemngZP7y
         eXbK2IsS10y1E9Vtzib2P3cEcy4IdSoyX8pjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E1nfN5tQTH9dUJ3HgnnNGhTDWbuus0wKKsd017RUPxkMU7YDr6uEMgdsByVvZn8F21
         ncFCwuJ0aGrEVSvXoPaFBglbkiTwdffz6kllVMuw2sqrO4wlXVkIIz2fHi2kzjhTN/He
         mAyVmavYX3NegRmw6Ey75Ato5ydfn466vgmOA=
Received: by 10.216.85.143 with SMTP id u15mr1795622wee.205.1272007194848;
        Fri, 23 Apr 2010 00:19:54 -0700 (PDT)
Received: from ftrvxmtrx@gmail.com ([212.98.167.157])
        by mx.google.com with ESMTPS id x1sm47577wbx.19.2010.04.23.00.19.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 00:19:54 -0700 (PDT)
Received: by ftrvxmtrx@gmail.com (sSMTP sendmail emulation); Fri, 23 Apr 2010 10:19:36 +0300
Content-Disposition: inline
In-Reply-To: <201004231000.44435.igor@gplsoft.org>
User-Agent: Mutt/1.5.18-muttng (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145592>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Spotted by Igor Murzov, thanks.

Signed-off-by: Serge Ziryukin <ftrvxmtrx@gmail.com>
---
 gitk-git/po/ru.po |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/po/ru.po b/gitk-git/po/ru.po
index dfd1e1c..13a99ef 100644
--- a/gitk-git/po/ru.po
+++ b/gitk-git/po/ru.po
@@ -863,7 +863,7 @@ msgid ""
 "(discard ALL local changes)"
 msgstr ""
 "=D0=96=D1=91=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=D0=B5=D0=
=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=
=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3\n"
-"(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3=D0=B8 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=BE=D1=
=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
+"(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3=D0=B5 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=BE=D1=
=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
=20
 #: gitk:8492
 msgid "Resetting"
--=20
1.7.0.5


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvRSggACgkQUT3RpZIpZv5wXwCgmfJhC7yFJr2N4/oakTVcqy9o
Sm0AnRqGoglg0suFMquNJ1ZrEz40o6o+
=sCyt
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
