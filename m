From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/1] update gitignore
Date: Wed, 16 Sep 2009 12:01:35 +0200
Message-ID: <1253095295-28919-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gister@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 12:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnrgZ-0002PR-1q
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 12:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584AbZIPKVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758308AbZIPKVv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 06:21:51 -0400
Received: from rood.intersec.com ([88.191.78.202]:45474 "EHLO mx2.intersec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758499AbZIPKVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 06:21:49 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2009 06:21:49 EDT
Received: from mx2.intersec.com (localhost [127.0.0.1])
	by mx2.intersec.com (Postfix) with ESMTP id 7FA1D52085;
	Wed, 16 Sep 2009 12:01:51 +0200 (CEST)
X-Intersec-Trusted-Host: yes
X-Mailer: git-send-email 1.6.5.rc1.185.g9cbfa
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128637>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 47672b0..5604b82 100644
--- a/.gitignore
+++ b/.gitignore
@@ -105,6 +105,9 @@ git-reflog
 git-relink
 git-remote
 git-remote-curl
+git-remote-ftp
+git-remote-http
+git-remote-https
 git-repack
 git-replace
 git-repo-config
-- 
1.6.5.rc1.185.g9cbfa
