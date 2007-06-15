From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] Documentation/gitmodules: fix asciidoc
Date: Fri, 15 Jun 2007 15:42:31 +1200
Message-ID: <11818789512948-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2ht-000781-60
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbXFODmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbXFODmj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:42:39 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:47740 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbXFODmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:42:39 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Hz2hj-0007Be-V8; Fri, 15 Jun 2007 15:42:31 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id E037ECB9E8; Fri, 15 Jun 2007 15:42:31 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.0.45.gfea6d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50236>

---
  I was getting documentation build errors without this

 Documentation/gitmodules.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 7814b6a..5c9fe9c 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -5,9 +5,11 @@ NAME
 ----
 gitmodules - defining submodule properties
 
+
 SYNOPSIS
 --------
-.gitmodules
+[verse]
+'.gitmodules'
 
 
 DESCRIPTION
-- 
1.5.2.0.45.gfea6d-dirty
