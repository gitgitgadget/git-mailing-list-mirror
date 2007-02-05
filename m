From: Michael <barra_cuda@katamail.com>
Subject: [PATCH] Documentation: add KMail in SubmittingPatches
Date: Mon, 5 Feb 2007 14:27:32 +0100
Message-ID: <200702051427.32532.barra_cuda@katamail.com>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net> <200702041716.39999.robin.rosenberg.lists@dewire.com> <7vlkjdr8hj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 14:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE3nU-0006VX-La
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 14:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXBENV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 08:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbXBENV4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 08:21:56 -0500
Received: from slim-3c.inet.it ([213.92.5.125]:55600 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422AbXBENVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 08:21:53 -0500
Received: from dial-up-mi-449.lombardiacom.it ([::ffff:212.34.226.195]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.226.195+uejJkTxt8a; Mon, 05 Feb 2007 14:21:49 +0100
User-Agent: KMail/1.9.4
In-Reply-To: <7vlkjdr8hj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Message-ID: <20070205132150.123659@dial-up-mi-449.lombardiacom.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Michael <barra_cuda@katamail.com>
---
 Documentation/SubmittingPatches |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ce85d06..a3dafa5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -316,7 +316,6 @@ settings but I haven't tried, yet.
 	mail.identity.id?.compose_html		=> false
 
 
-
 Gnus
 ----
 
@@ -331,3 +330,21 @@ whitespaces (fatal in patches).  Running 'C-u g' to 
display the
 message in raw form before using '|' to run the pipe can work
 this problem around.
 
+
+KMail
+-----
+
+This should help you to submit patches inline using KMail.
+
+1) Prepare the patch as a text file.
+
+2) Click on New Mail.
+
+3) Go under "Options" in the Composer window and be sure that
+"Word wrap" is not set.
+
+4) Use Message -> Insert file... and insert the patch.
+
+5) Back in the compose window: add whatever other text you wish to the
+message, complete the addressing and subject fields, and press send.
+
-- 
1.4.4.2
