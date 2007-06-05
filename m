From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [PATCH] +test-sha1 to .gitignore
Date: Tue, 05 Jun 2007 10:24:07 -0700
Message-ID: <86ejkqpb60.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 19:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvclp-0005mm-O6
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 19:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbXFERYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 13:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXFERYI
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 13:24:08 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:9694 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbXFERYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 13:24:07 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 29BD71DEF75; Tue,  5 Jun 2007 10:24:07 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.6.14; tzolkin = 6 Ix; haab = 2 Zotz
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49212>


---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 15aed70..8e75c99 100644
--- a/.gitignore
+++ b/.gitignore
@@ -151,6 +151,7 @@ test-delta
 test-dump-cache-tree
 test-genrandom
 test-match-trees
+test-sha1
 common-cmds.h
 *.tar.gz
 *.dsc
-- 
1.5.2.1.111.gc94b


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
