From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 01/10] =?UTF-8?q?l10n:=20de.po:=20translate=20"bare"=20as=20?= =?UTF-8?q?"blo=C3=9F"?=
Date: Tue,  8 May 2012 19:33:36 +0200
Message-ID: <1336498425-17890-2-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoIw-00027H-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab2EHRe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52319 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab2EHReZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:25 -0400
Received: by werb10 with SMTP id b10so2143834wer.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jfODdZ6ZxBgkSUyo/2GakIJh6+FbdlYrYJUfRYZxpuk=;
        b=0J7LN9yVI4eEOaWEq5Qbqo70FOijUlDF4dO1L64LE8WS7BDQ+YMFThuo03nxTdtOFb
         88gl57AYa5r0JQHWtTKEApOdJq9Vycw2nsXfzZieq6bZWEXhGWHSZkLA7MWXJXpOk6C5
         6i1vyUS/8vJvFpKIVohXYlh6fV6XTQf7EgrTWCEe1AkX4ivHXzmOiP3+KgBieDuv21of
         3ErOeNfK9bmTxZbI/isAc4MFMXPJLN+mvxb+DDiZLn91jIdA0/oXfuABMcYIMpE7OaYT
         E+1WPdH2/C7su+tGcdtHzXQR7gvuMSUTxLCiSuEbzSFVf4ZgC+EU3IHRDIf6OmjOSOUz
         k5xA==
Received: by 10.180.24.66 with SMTP id s2mr37207714wif.7.1336498464434;
        Tue, 08 May 2012 10:34:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197400>

=46rom: Thomas Rast <trast@student.ethz.ch>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |    4 ++--
 1 Datei ge=C3=A4ndert, 2 Zeilen hinzugef=C3=BCgt(+), 2 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index 066f3ef..09099fc 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1355,7 +1355,7 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht erst=
ellen."
 #: builtin/clone.c:728
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
-msgstr "Klone in leeres Projektarchiv '%s'...\n"
+msgstr "Klone in blo=C3=9Fes Projektarchiv '%s'...\n"
=20
 #: builtin/clone.c:730
 #, c-format
@@ -3081,7 +3081,7 @@ msgstr "Kann keine %s Zur=C3=BCcksetzung mit Pfad=
en machen."
 #: builtin/reset.c:325
 #, c-format
 msgid "%s reset is not allowed in a bare repository"
-msgstr "%s Zur=C3=BCcksetzung ist in einem leeren Projektarchiv nicht =
erlaubt"
+msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=9Fen Projektarchiv=
 nicht erlaubt"
=20
 #: builtin/reset.c:341
 #, c-format
--=20
1.7.10.129.g1ec31a3
