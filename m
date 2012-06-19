From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 2/3] =?UTF-8?q?git-gui:=20de.po:=20translate=20"bare"=20as=20?= =?UTF-8?q?"blo=C3=9F"?=
Date: Tue, 19 Jun 2012 20:25:40 +0200
Message-ID: <1340130341-5224-3-git-send-email-ralf.thielow@googlemail.com>
References: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: patthoyts@users.sourceforge.net, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Jun 19 20:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh37m-00062a-S5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab2FSSZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 14:25:57 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36846 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2FSSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:25:56 -0400
Received: by bkcji2 with SMTP id ji2so5415595bkc.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nOK0Evct0jxmqzR/Dsf49rVKCmp0loP+ZDVxilZahGE=;
        b=GBbQD8dNaBCMpIEZH2bfsWZdufh8+fFLjKRvCIDQPyJyDd9oNGzBdyzgMUXCN6cMI1
         66HjiV7/MPEvbDv9BafhLL+r1iyWxFpsoV/1aqyzTM1T6kA9mR7B/wCczz6lukXJ7qEx
         hHJAKSohaAnRTg8haK5cGzIvdqwMLIcqd2F5fdNsI6Hc3us6eKSsc8jyGhVeT0WQ938R
         ybvg78Ypnwc25l7KwbDjq1k9n9naIvbWSCEULRVDFpLEPH90f8AvpznmIZE9BwwJx7F5
         CovwZ5Uh+UoupT6YeF1o7OlZno399chXCZXJmEUFMB/1QXN7NvQfVM5QvKMsa59Xw9DT
         TuOA==
Received: by 10.205.126.8 with SMTP id gu8mr5270720bkc.61.1340130354905;
        Tue, 19 Jun 2012 11:25:54 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id e20sm24459087bkw.3.2012.06.19.11.25.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 11:25:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200220>

According to the translation in git-core, we
translate "bare" as "blo=C3=9F".

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po | 2 +-
 1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-=
)

diff --git a/po/de.po b/po/de.po
index 91221ef..55fde80 100644
--- a/po/de.po
+++ b/po/de.po
@@ -72,7 +72,7 @@ msgstr ""
=20
 #: git-gui.sh:1154
 msgid "Cannot use bare repository:"
-msgstr "Leeres Projektarchiv kann nicht benutzt werden:"
+msgstr "Blo=C3=9Fes Projektarchiv kann nicht benutzt werden:"
=20
 #: git-gui.sh:1162
 msgid "No working directory"
--=20
1.7.11
