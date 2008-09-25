From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH RFC 6/6] Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
Date: Thu, 25 Sep 2008 15:44:36 -0500
Message-ID: <1222375476-32911-6-git-send-email-mfwitten@mit.edu>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-1-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-2-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-3-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-4-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-5-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 25 22:47:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kixjx-0007oO-HD
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbYIYUp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbYIYUpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:45:25 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61480 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147AbYIYUpY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 16:45:24 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8PKisEf003967;
	Thu, 25 Sep 2008 16:44:54 -0400 (EDT)
Received: from localhost.localdomain (97-116-112-224.mpls.qwest.net [97.116.112.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8PKibJd008003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Sep 2008 16:44:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.302.ge6cbd1
In-Reply-To: <1222375476-32911-5-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96800>

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index fe53e9b..76a525a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -228,7 +228,7 @@ sendemail.bcc::
 	Email address (or alias) to always bcc.
 
 sendemail.chainreplyto::
-	Boolean value specifying the default to the '--chain_reply_to'
+	Boolean value specifying the default to the '--[no-]chain-reply-to'
 	parameter.
 
 sendemail.smtpserver::
-- 
1.6.0.2.302.ge6cbd1
