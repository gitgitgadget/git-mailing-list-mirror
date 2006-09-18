From: Jeff King <peff@peff.net>
Subject: [PATCH] gitignore: add git-show-ref and git-pack-refs
Date: Mon, 18 Sep 2006 02:36:21 -0400
Message-ID: <20060918063621.GA11139@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 08:36:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCk2-00055F-7p
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965475AbWIRGgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965478AbWIRGgY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:36:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:22197 "HELO
	peff.net") by vger.kernel.org with SMTP id S965475AbWIRGgY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 02:36:24 -0400
Received: (qmail 27001 invoked from network); 18 Sep 2006 02:35:35 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Sep 2006 02:35:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Sep 2006 02:36:21 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27233>


Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index bdeedb6..0ffe14a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,6 +74,7 @@ git-name-rev
 git-mv
 git-pack-redundant
 git-pack-objects
+git-pack-refs
 git-parse-remote
 git-patch-id
 git-peek-remote
@@ -105,6 +106,7 @@ git-shortlog
 git-show
 git-show-branch
 git-show-index
+git-show-ref
 git-ssh-fetch
 git-ssh-pull
 git-ssh-push
-- 
1.4.2.1.g01ff
