From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Documentation/interpret-trailers: Grammar fix
Date: Wed,  7 Oct 2015 18:46:22 +0200
Message-ID: <1444236382-14557-1-git-send-email-tklauser@distanz.ch>
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 18:46:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjrrT-0003cz-9y
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 18:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbbJGQq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 12:46:29 -0400
Received: from mail.zhinst.com ([212.126.164.98]:53287 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbbJGQq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 12:46:28 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Wed, 7 Oct 2015 18:46:22 +0200
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279184>

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index d6d9231..0ecd497 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -67,7 +67,7 @@ OPTIONS
 --trim-empty::
 	If the <value> part of any trailer contains only whitespace,
 	the whole trailer will be removed from the resulting message.
-	This apply to existing trailers as well as new trailers.
+	This applies to existing trailers as well as new trailers.
 
 --trailer <token>[(=|:)<value>]::
 	Specify a (<token>, <value>) pair that should be applied as a
-- 
2.6.0
