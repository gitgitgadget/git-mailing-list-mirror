From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH] Documentation: For consistency, use CVS instead of cvs.
Date: Thu, 23 Aug 2007 20:40:08 -0400
Message-ID: <20070824004008.GA21778@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 02:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IONDz-000596-Dj
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 02:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765424AbXHXAkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 20:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764508AbXHXAkP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 20:40:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:12622 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764657AbXHXAkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 20:40:13 -0400
Received: by wr-out-0506.google.com with SMTP id 36so514642wra
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 17:40:11 -0700 (PDT)
Received: by 10.90.93.6 with SMTP id q6mr7623523agb.1187916011187;
        Thu, 23 Aug 2007 17:40:11 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id 32sm7643115aga.2007.08.23.17.40.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2007 17:40:10 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Thu, 23 Aug 2007 20:40:09 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56543>

When not referring to the cvs command, CVS makes more sense.

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 Documentation/config.txt              |    4 ++--
 Documentation/git-cvsexportcommit.txt |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 462595c..a9fb221 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -465,11 +465,11 @@ rerere.enabled::
 	be encountered again.  See gitlink:git-rerere[1].
 
 gitcvs.enabled::
-	Whether the cvs server interface is enabled for this repository.
+	Whether the CVS server interface is enabled for this repository.
 	See gitlink:git-cvsserver[1].
 
 gitcvs.logfile::
-	Path to a log file where the cvs server interface well... logs
+	Path to a log file where the CVS server interface well... logs
 	various stuff. See gitlink:git-cvsserver[1].
 
 gitcvs.allbinary::
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 6c423e3..4c8d1e6 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -59,7 +59,7 @@ OPTIONS
 	Useful for patch series and the like.
 
 -u::
-	Update affected files from cvs repository before attempting export.
+	Update affected files from CVS repository before attempting export.
 
 -v::
 	Verbose.
-- 
1.5.3.rc6.17.g1911
