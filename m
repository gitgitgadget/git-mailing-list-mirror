From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Documentation: Minor capitalization typofix
Date: Fri, 14 Jul 2006 11:24:48 +0100
Message-ID: <11528726882895-git-send-email-alp@atoker.com>
References: <11528726881431-git-send-email-alp@atoker.com> <1152872688966-git-send-email-alp@atoker.com>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 14 12:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Kqt-0002gy-By
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 12:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWGNKYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 06:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWGNKYt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 06:24:49 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:33543 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1161022AbWGNKYt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 06:24:49 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 62D4599CB; Fri, 14 Jul 2006 11:24:48 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g28ec
In-Reply-To: <1152872688966-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23885>

This ended up appearing in several man pages by inclusion.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Documentation/urls.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index a071915..2b5a7f8 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -13,7 +13,7 @@ to name the remote repository:
 	ssh://[user@]host.xz/~user/path/to/repo.git/
 	ssh://[user@]host.xz/~/path/to/repo.git
 
-SSH Is the default transport protocol and also supports an
+SSH is the default transport protocol and also supports an
 scp-like syntax.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
-- 
1.4.1.g28ec
