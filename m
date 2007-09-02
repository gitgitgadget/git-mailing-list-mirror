From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Fix typo in 1.5.3 release notes
Date: Sun, 2 Sep 2007 14:46:46 +0200
Message-ID: <20070902124646.GO24721@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 02 14:47:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRor8-0003KT-NN
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 14:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965578AbXIBMrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 08:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965670AbXIBMrB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 08:47:01 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46219 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965114AbXIBMrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 08:47:00 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IRoqu-0006cs-H3
	from <vmiklos@frugalware.org>; Sun, 02 Sep 2007 14:46:59 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 812CC13A411A; Sun,  2 Sep 2007 14:46:46 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4974]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57323>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/RelNotes-1.5.3.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.5.3.txt b/Documentation/RelNotes-1.5.3.txt
index 317c8b9..d03894b 100644
--- a/Documentation/RelNotes-1.5.3.txt
+++ b/Documentation/RelNotes-1.5.3.txt
@@ -152,7 +152,7 @@ Updates since v1.5.2
     cloning locally.
 
   - URL used for "git clone" and friends can specify nonstandard SSH port
-    by using sh://host:port/path/to/repo syntax.
+    by using ssh://host:port/path/to/repo syntax.
 
   - "git bundle create" can now create a bundle without negative refs,
     i.e. "everything since the beginning up to certain points".
-- 
1.5.2.2
