From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] Documentation/git-mailinfo: fix typo
Date: Wed, 11 May 2016 20:42:54 +0000
Message-ID: <1462999375-27664-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 22:43:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0ayV-0000Hb-RL
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 22:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbcEKUnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 16:43:16 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:32879 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751673AbcEKUnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 16:43:15 -0400
Received: (qmail 2991 invoked from network); 11 May 2016 20:43:12 -0000
Received: (qmail 16476 invoked from network); 11 May 2016 20:43:12 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 11 May 2016 20:43:12 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294362>

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Documentation/git-mailinfo.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 0947084..3bbc731 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -85,7 +85,7 @@ with comments and suggestions on the message you are responding to, and to
 conclude it with a patch submission, separating the discussion and the
 beginning of the proposed commit log message with a scissors line.
 +
-This can enabled by default with the configuration option mailinfo.scissors.
+This can be enabled by default with the configuration option mailinfo.scissors.
 
 --no-scissors::
 	Ignore scissors lines. Useful for overriding mailinfo.scissors settings.
-- 
2.7.3
