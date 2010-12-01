From: jari.aalto@cante.net
Subject: [PATCH] git-rebase.txt: (CONFIGURATION): order options alphabetically
Date: Wed,  1 Dec 2010 19:54:43 +0200
Organization: Private
Message-ID: <1291226083-17091-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 18:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqtJ-0001SI-Hf
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0LARys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:54:48 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:48883 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab0LARys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:54:48 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 454B913BE00
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 19:54:47 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03D6743E4D; Wed, 01 Dec 2010 19:54:47 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 3A12727D88
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 19:54:44 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNqt9-0004S5-UC; Wed, 01 Dec 2010 19:54:43 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162556>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rebase.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..6ed2537 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -195,13 +195,13 @@ Alternatively, you can undo the 'git rebase' with
 CONFIGURATION
 -------------
=20
+rebase.autosquash::
+	If set to true enable '--autosquash' option by default.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
=20
-rebase.autosquash::
-	If set to true enable '--autosquash' option by default.
-
 OPTIONS
 -------
 <newbase>::
--=20
1.7.2.3
