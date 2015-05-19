From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] l10: de.po: punctuation fixes
Date: Tue, 19 May 2015 10:51:33 +0200
Message-ID: <1b4e0ba64c033fccb47528a0c5e03b66d3f5773b.1432025365.git.git@drmicha.warpmail.net>
References: <cover.1432025365.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 10:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YudFu-0007cj-UT
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 10:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbbESIvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 04:51:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41082 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753648AbbESIvj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 04:51:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 0636B20AE4
	for <git@vger.kernel.org>; Tue, 19 May 2015 04:51:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 19 May 2015 04:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=t+YVfelywKg8EkYsKamcdTF5kgo=; b=eywBRO
	7dyTnIlpUwG8gw0GV0Z5/igss+Z60n6j6Wz4poRyNQIieGLhYBClzWYfCSsgNP5U
	dTy+mBp9wlSFuKYCC83S+5KDMvOwn8HViJnVa+Ei5/KArdncA4hdskZuGUfz84mx
	3hzjYv8O/KJdqxTy1e5+wJrasEMOEoW0yE0T4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=t+YVfelywKg8EkY
	sKamcdTF5kgo=; b=AXSHNxADQxPR8Dqd0k5tz/bb19JGVZTEapcWrxljoyyXL/p
	mrf7+L/IXeleBZSHLMdi+uP20TMBLNY3/65Y6FyK+EhuiOrCbumO6BSCHETY9rX6
	fHw5Cbst0p8TmKwUl6bcOZswMK0RjvZ+6MMlGH8LLGrqKi0W+lThtT6x0qT4=
X-Sasl-enc: HOyz8zKXzvDJO4k30gMQPDsHKpWKeoEF3mwK8Sk59+D5 1432025498
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8D0DA6801CB;
	Tue, 19 May 2015 04:51:38 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <cover.1432025365.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269347>

This respects the ellipsis style used in de.po.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 25258e3..6405f3e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10479,7 +10479,7 @@ msgstr ""
 msgid "Using index info to reconstruct a base tree..."
 msgstr ""
 "Verwende Informationen aus der Staging-Area, um ein Basisverzeichnis =
"
-"nachzustellen"
+"nachzustellen ..."
=20
 #: git-am.sh:157
 msgid ""
@@ -10495,7 +10495,7 @@ msgstr "Falle zur=C3=BCck zum Patchen der Basis=
 und des 3-Wege-Merges ..."
=20
 #: git-am.sh:182
 msgid "Failed to merge in the changes."
-msgstr "Merge der =C3=84nderungen fehlgeschlagen"
+msgstr "Merge der =C3=84nderungen fehlgeschlagen."
=20
 #: git-am.sh:277
 msgid "Only one StGIT patch series can be applied at once"
--=20
2.4.0.rc3.332.g886447c
