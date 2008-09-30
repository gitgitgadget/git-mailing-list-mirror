From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 5/9] Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
Date: Tue, 30 Sep 2008 07:58:28 -0500
Message-ID: <1222779512-58936-5-git-send-email-mfwitten@mit.edu>
References: <20080929174445.GA6015@coredump.intra.peff.net>
 <1222779512-58936-1-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-2-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-4-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Sep 30 15:12:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkf1r-00011W-NX
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 15:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbYI3NLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 09:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYI3NLc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 09:11:32 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56152 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301AbYI3NLc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 09:11:32 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8UCwfiZ010311;
	Tue, 30 Sep 2008 08:58:41 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-2.mpls.qwest.net [97.116.104.2])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8UCwWOO010491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Sep 2008 08:58:40 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222779512-58936-4-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97116>

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 81970f3..6b62032 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -221,7 +221,7 @@ sendemail.bcc::
 	Email address (or alias) to always bcc.
 
 sendemail.chainreplyto::
-	Boolean value specifying the default to the '--chain_reply_to'
+	Boolean value specifying the default to the '--[no-]chain-reply-to'
 	parameter.
 
 sendemail.smtpserver::
-- 
1.6.0.2.304.gdcf23.dirty
