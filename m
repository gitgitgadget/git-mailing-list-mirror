From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] l10n: de.po: correct singular form
Date: Mon, 26 Jan 2015 16:34:32 +0100
Message-ID: <fe64dea04c77a6157d74473bd34cb7dffbf9d31d.1422286422.git.git@drmicha.warpmail.net>
References: <960f016f1252640ccc3b1071ad5c8d6d2b1fbd0e.1422286422.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 16:34:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFlgX-0000vr-An
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 16:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbbAZPeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2015 10:34:37 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58874 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753399AbbAZPeg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2015 10:34:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id A184620787
	for <git@vger.kernel.org>; Mon, 26 Jan 2015 10:34:35 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 26 Jan 2015 10:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:mime-version:in-reply-to:references:content-type
	:content-transfer-encoding; s=smtpout; bh=B3FSmMxY2pC14pSKPnfAP5
	DMh8U=; b=ZXnHBs9ySs2fMHZGAm/GDJNZznhL+ySRk1gSpkmVIhwtIZI6uEH+0G
	6WUObdLqhKMTMH3g5Z3bvTLZuz6deIco6SOC4PG5gG97BrkojqSEmv0W5yK5klPz
	Neji3CFCi7rv+N6m9sM+LYanqFKzK5t7cpWD3rFzstK469tNife+s=
X-Sasl-enc: 46jfM1iuYFf+PtZep2+fNNyveRxY8ZJj1sI7MWA7M275 1422286475
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3BFFB6801AD;
	Mon, 26 Jan 2015 10:34:35 -0500 (EST)
X-Mailer: git-send-email 2.3.0.rc1.222.gae238f2
In-Reply-To: <960f016f1252640ccc3b1071ad5c8d6d2b1fbd0e.1422286422.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263031>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 65a8ac0..6af1599 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3559,21 +3559,21 @@ msgid ""
 "Warning: you are leaving %d commit behind, not connected to\n"
 "any of your branches:\n"
 "\n"
 "%s\n"
 msgid_plural ""
 "Warning: you are leaving %d commits behind, not connected to\n"
 "any of your branches:\n"
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Sie lassen %d Commit zur=C3=BCck. Folgende Commits sind in\n=
"
+"Warnung: Sie lassen %d Commit zur=C3=BCck. Folgender Commit ist in\n"
 "keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
 msgstr[1] ""
 "Warnung: Sie lassen %d Commits zur=C3=BCck. Folgende Commits sind in\=
n"
 "keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
=20
 #: builtin/checkout.c:729
--=20
2.3.0.rc1.222.gae238f2
