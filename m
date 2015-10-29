From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: improve some translations
Date: Thu, 29 Oct 2015 22:19:22 +0100
Message-ID: <1446153562-12133-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 22:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrujc-0000E0-8L
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 22:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbbJ2V1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2015 17:27:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35128 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbbJ2V1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 17:27:43 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2015 17:27:43 EDT
Received: by wmll128 with SMTP id l128so2872064wml.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=mTytWOfZA3MJyh/sixPQHZNInIkrQfP/R+2t7VZ/Izc=;
        b=etWt5ue3doIpswGnE2eZT/xXf4jxiQ3Zzljfct5JCQAv4+ftIWZQaB0c+te/ZSK3Fd
         JOW/RNyf70QDuDHUBZS+XpA3au0AueBy2pGWK/7/LYxdcoGD8rWLcDY6yZ1Xm6UliFUS
         Tk+Wr4iuj890Q9zB61ShiIjAODx3YRYr5Ibu5VTfS8b/SFbWpWXkj1A/7fP8y6T+mVWq
         DIxI7rHz+KrpOgdJqxsA2XvITCCSOiQIY1tgNIhQ8I+T7sdBPf01cVDQMAOheyNt1SuV
         944tUkCAkrSNDl5Fb/QrqcZfSu2FmzNG1gk3uBukyYcf0sQVaXVbj+PKEvvX9HQsq0a8
         6J3w==
X-Received: by 10.28.217.6 with SMTP id q6mr6790124wmg.5.1446153565573;
        Thu, 29 Oct 2015 14:19:25 -0700 (PDT)
Received: from localhost (cable-86-56-116-100.cust.telecolumbus.net. [86.56.116.100])
        by smtp.gmail.com with ESMTPSA id r13sm5411616wmg.12.2015.10.29.14.19.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Oct 2015 14:19:24 -0700 (PDT)
X-Mailer: git-send-email 2.6.2.441.gf54246d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280459>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index c682aaf..be30642 100644
--- a/po/de.po
+++ b/po/de.po
@@ -592,7 +592,7 @@ msgstr "Fehler beim Schreiben der Signatur nach '%s=
': %s"
 #: grep.c:1718
 #, c-format
 msgid "'%s': unable to read %s"
-msgstr "'%s': konnte nicht lesen %s"
+msgstr "'%s': konnte %s nicht lesen"
=20
 #: grep.c:1735
 #, c-format
@@ -11749,7 +11749,7 @@ msgstr "unbekannte Option: $opt"
=20
 #: git-stash.sh:397
 msgid "No stash found."
-msgstr "Kein \"stash\" gefunden."
+msgstr "Kein Stash-Eintrag gefunden."
=20
 #: git-stash.sh:404
 #, sh-format
@@ -11773,7 +11773,7 @@ msgstr "'$args' ist keine \"stash\"-Referenz"
=20
 #: git-stash.sh:457
 msgid "unable to refresh index"
-msgstr "unf=C3=A4hig den Index zu aktualisieren"
+msgstr "Konnte den Index nicht aktualisieren."
=20
 #: git-stash.sh:461
 msgid "Cannot apply a stash in the middle of a merge"
--=20
2.6.2.441.gf54246d
