From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 21/63] po/is.po: add Icelandic translation
Date: Sat,  4 Sep 2010 22:10:24 +0000
Message-ID: <1283638229-14199-5-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0x4-0003Lx-AD
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab0IDWK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:10:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57357 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0IDWK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:10:56 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so1463766wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GJOYa2hmiL4wq13PYB6x7FjTOLqyRI+4bAvfWnrXook=;
        b=C/MnxoieZC94q/N0dipYzFmd9m2xeM8vRvxw98gUEgNWrgIYYepHFsnWcmelpSt4y+
         9wV38NMDrrT1kwyvDtRfdmHb5d7aQ1P/NYKqfgDjXUjdaGJ6ZvXcaLxIQwU70dpJCEgK
         j0rTBl5p5UHFM2CViHNDiBNIavY+ameYdYpTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o+Pn235abiSX/uonqWIhhL69p0QQqIbqF1U7eHNh/NZYOb+Ly8OfftVt+XeDu5ItjR
         aAljCXrxwBSzJDsPSFGvVGFdfLYLFFnv+73l89VSiHT2y6id/k4ccYDtQ+olHFubaitJ
         ACJE4DconJoHO60BPoBDsMt5Y2Ym893dRF6cE=
Received: by 10.216.17.130 with SMTP id j2mr2321527wej.47.1283638255083;
        Sat, 04 Sep 2010 15:10:55 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.10.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:10:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155370>

Translate the non-TEST messages added in recent patches against
init-db.c. This brings Icelandic translation coverage up to 100%.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/po/is.po b/po/is.po
index 2c38b32..85d15b8 100644
--- a/po/is.po
+++ b/po/is.po
@@ -11,6 +11,101 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Gat ekki gert %s skrifanlega af h=C3=B3p"
+
+#, c-format
+msgid "insanely long template name %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega langt sni=C3=B0snafn %s"
+
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "gat ekki stat-a=C3=B0 '%s'"
+
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "gat ekki stat-a=C3=B0 sni=C3=B0i=C3=B0 '%s'"
+
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B3ppuna '%s'"
+
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega langur tengill %s"
+
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "gat ekki b=C3=BAi=C3=B0 til tengilinn '%s' '%s'"
+
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "gat ekki afrita=C3=B0 '%s' til '%s'"
+
+#, c-format
+msgid "ignoring template %s"
+msgstr "hunsa sni=C3=B0i=C3=B0 %s"
+
+#, c-format
+msgid "insanely long template path %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega l=C3=B6ng sl=C3=B3=C3=B0 =C3=A1 s=
ni=C3=B0 %s"
+
+#, c-format
+msgid "templates not found %s"
+msgstr "sni=C3=B0i=C3=B0 fannst ekki %s"
+
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "aftira ekki sni=C3=B0in vegna rangar =C3=BAtg=C3=A1fu %d fr=C3=
=A1 '%s'"
+
+#, c-format
+msgid "insane git directory %s"
+msgstr "brj=C3=A1l=C3=BA=C3=B0 git mappa %s"
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git lind =C3=AD %s%s\n"
+
+msgid "Reinitialized existing"
+msgstr "Endurger=C3=B0i"
+
+msgid "Initialized empty"
+msgstr "Bj=C3=B3 til t=C3=B3ma"
+
+msgid " shared"
+msgstr " sameiginlega"
+
+msgid "cannot tell cwd"
+msgstr "finn ekki n=C3=BAverandi m=C3=B6ppu"
+
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "gat ekki b=C3=BAi=C3=B0 til m=C3=B6ppuna %s"
+
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "get ekki fari=C3=B0 inn =C3=AD m=C3=B6ppuna %s"
+
+#, c-format
+msgid "%s (or --work-tree=3D<directory>) not allowed without specifyin=
g %s (or --git-dir=3D<directory>)"
+msgstr "%s (e=C3=B0a --work-tree=3D<mappa>) ekki leyfilegt =C3=A1samt =
%s (e=C3=B0a --git-dir=3D<mappa>)"
+
+msgid "Cannot access current working directory"
+msgstr "Get ekki opna=C3=B0 n=C3=BAverandi vinnum=C3=B6ppu"
+
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Get ekki opna=C3=B0 vinnutr=C3=A9 '%s'"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
 msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
 msgstr "Sj=C3=A1 'git help SKIPUN' til a=C3=B0 sj=C3=A1 hj=C3=A1lp fyr=
ir tiltekna skipun."
=20
--=20
1.7.2.3.313.gcd15
