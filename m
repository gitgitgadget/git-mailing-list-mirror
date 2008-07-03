From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] fix typoed config option 'indexversion' in man page.
Date: Thu, 3 Jul 2008 03:07:33 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0807030303580.30922@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 03:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEDJJ-0004mQ-Dx
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 03:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYGCBHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 21:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYGCBHg
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 21:07:36 -0400
Received: from mail.bredband2.net ([82.209.166.4]:6614 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751562AbYGCBHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:07:36 -0400
Received: (qmail 9205 invoked from network); 3 Jul 2008 01:06:47 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <gitster@pobox.com>; 3 Jul 2008 01:06:47 -0000
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87216>

---

Noticed by David Parra on #git.

  Documentation/config.txt |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52d01b8..fd56dac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -945,7 +945,7 @@ pack.threads::
  	Specifying 0 will cause git to auto-detect the number of CPU's
  	and set the number of threads accordingly.

-pack.indexVersion::
+pack.indexversion::
  	Specify the default pack index version.  Valid values are 1 for
  	legacy pack index used by Git versions prior to 1.5.2, and 2 for
  	the new pack index with capabilities for packs larger than 4 GB
-- 
1.5.6.GIT
