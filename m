From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate one message
Date: Sat,  4 Apr 2015 10:11:09 +0200
Message-ID: <1428135069-7847-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 10:11:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeJAz-0002Kj-CW
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 10:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbDDILU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2015 04:11:20 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37161 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbDDILO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 04:11:14 -0400
Received: by wiaa2 with SMTP id a2so159736123wia.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=rjNRzvqJ4ELPBtoaerFqSH5OeldDRCFYeEHvHkZ+LAo=;
        b=g/rOgJOQxUBWIHQLVrZoiA5031ev3BKFwBhf2jKesU0jlMWcV0RyyOYST/TnZ4NjPj
         yreH9x8fFWpoRCwp72gPuKjwuCJB+PJfYCZM1gY96ysLrLdXNKLNHO0gODY0NEBsFjiQ
         6tDcJFLvPMrX3sVQlCdMU0P2AX5f/+vQqOwrFb0ZcbyukcK1AjZAVu/sbazbv0G/xgwl
         uJI7ZPtW6Sjz0lz4AWfdmzNEYwaEUmRVSUYDnMV2hcd5Jg2vNUOaxDL7KBEryeZPq1ur
         tfsenIePF+0MmxvbR4VBEspDUbsqGIbkI23dD+vmwFXLmVWc9NJcO1gAGmlIl75M4BXy
         7NLA==
X-Received: by 10.180.74.112 with SMTP id s16mr12080391wiv.73.1428135073168;
        Sat, 04 Apr 2015 01:11:13 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id k2sm2090643wix.4.2015.04.04.01.11.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 04 Apr 2015 01:11:12 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.212.g5b27f3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266768>

Translate one message came from git.pot update in 6eebb35
(l10n: git.pot: v2.4.0 round 2 (1 update)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 49f35fe..2feaec1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1164,10 +1164,9 @@ msgstr ""
 "die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"--signed=
 push\")"
=20
 #: send-pack.c:366
-#, fuzzy
 msgid "the receiving end does not support --atomic push"
 msgstr ""
-"die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"--signed=
 push\")"
+"die Gegenseite unterst=C3=BCtzt keinen atomaren Versand (\"--atomic p=
ush\")"
=20
 #: sequencer.c:172 builtin/merge.c:782 builtin/merge.c:893 builtin/mer=
ge.c:995
 #: builtin/merge.c:1005
--=20
2.4.0.rc1.212.g5b27f3f
