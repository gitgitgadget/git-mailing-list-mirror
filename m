From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] fix typo in git-am manpage
Date: Wed, 21 Mar 2007 10:37:36 +0200
Message-ID: <20070321083736.GF20583@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 09:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTwJX-0004mK-Fx
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 09:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbXCUIg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 04:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbXCUIg4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 04:36:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:22730 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbXCUIgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 04:36:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so214089uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:36:54 -0700 (PDT)
Received: by 10.66.232.9 with SMTP id e9mr2753970ugh.1174466214490;
        Wed, 21 Mar 2007 01:36:54 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id o30sm1590086ugd.2007.03.21.01.36.52;
        Wed, 21 Mar 2007 01:36:53 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42783>

Fix typo in git-am manpage

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 4fb1d84..13a7389 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -70,7 +70,7 @@ default.   You could use `--no-utf8` to override this.
 	the patch.
 
 -C<n>, -p<n>::
-	These flag are passed to the `git-apply` program that applies
+	These flags are passed to the `git-apply` program that applies
 	the patch.
 
 --interactive::

-- 
MST
