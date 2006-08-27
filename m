From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Add git-zip-tree to .gitignore
Date: Sun, 27 Aug 2006 13:19:49 +0200
Message-ID: <44F17FD5.2030000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 13:20:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHIgK-0007IU-ET
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 13:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWH0LTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 07:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWH0LTv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 07:19:51 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59070
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750796AbWH0LTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 07:19:51 -0400
Received: from [10.0.1.3] (p508E7AB6.dip.t-dialin.net [80.142.122.182])
	by neapel230.server4you.de (Postfix) with ESMTP id 02DBC5006;
	Sun, 27 Aug 2006 13:19:49 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26093>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/.gitignore b/.gitignore
index 55cd984..58a7c92 100644
--- a/.gitignore
+++ b/.gitignore
@@ -124,6 +124,7 @@ git-verify-pack
 git-verify-tag
 git-whatchanged
 git-write-tree
+git-zip-tree
 git-core-*/?*
 gitweb/gitweb.cgi
 test-date
