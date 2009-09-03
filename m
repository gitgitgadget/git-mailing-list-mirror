From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-clone: add missing coma in --reference documentation
Date: Thu, 3 Sep 2009 13:24:16 +0200
Message-ID: <20090903112416.GI4770@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 13:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjAQW-0002KH-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 13:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbZICLYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 07:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbZICLYS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 07:24:18 -0400
Received: from virgo.iok.hu ([212.40.97.103]:50475 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754946AbZICLYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 07:24:17 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 314965809B;
	Thu,  3 Sep 2009 13:24:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2267144904;
	Thu,  3 Sep 2009 13:24:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2632F11F0027; Thu,  3 Sep 2009 13:24:16 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127651>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-clone.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b14de6c..87c13ab 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -76,7 +76,7 @@ then the cloned repository will become corrupt.
 
 
 --reference <repository>::
-	If the reference repository is on the local machine
+	If the reference repository is on the local machine,
 	automatically setup .git/objects/info/alternates to
 	obtain objects from the reference repository.  Using
 	an already existing repository as an alternate will
-- 
1.6.4
