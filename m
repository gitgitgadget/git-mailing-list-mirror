From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] add GIT-CFLAGS to .gitignore
Date: Thu, 22 Jun 2006 23:06:39 +0200
Message-ID: <20060622210639.GC24822@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Thu Jun 22 23:07:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWOD-0002ae-Mh
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWFVVG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 17:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWFVVG5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 17:06:57 -0400
Received: from mail20.bluewin.ch ([195.186.19.65]:32144 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1030365AbWFVVG5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 17:06:57 -0400
Received: from spinlock.ch (83.77.61.153) by mail20.bluewin.ch (Bluewin 7.3.110.2)
        id 449255CA00176DD3; Thu, 22 Jun 2006 21:06:51 +0000
Received: (nullmailer pid 5059 invoked by uid 1000);
	Thu, 22 Jun 2006 21:06:39 -0000
To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22373>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 65aa939..7b954d5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+GIT-CFLAGS
 GIT-VERSION-FILE
 git
 git-add
-- 
1.4.1.rc1
