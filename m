From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git-format-patch.txt: fix explanation of an example.
Date: Thu, 01 Nov 2007 17:21:39 +0300
Message-ID: <87fxzq2gi4.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 15:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inavs-0000Cr-Dl
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbXKAOVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbXKAOVu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:21:50 -0400
Received: from javad.com ([216.122.176.236]:2638 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368AbXKAOVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:21:50 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA1ELlm53066
	for <git@vger.kernel.org>; Thu, 1 Nov 2007 14:21:48 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InavT-0002Hn-17
	for git@vger.kernel.org; Thu, 01 Nov 2007 17:21:39 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62964>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/git-format-patch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c9857a2..dc5e9ba 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -168,7 +168,7 @@ git-format-patch origin::
 	is created in the current directory.
 
 git-format-patch \--root origin::
-	Extract all commits which that leads to 'origin' since the
+	Extract all commits which lead to 'origin' since the
 	inception of the project.
 
 git-format-patch -M -B origin::
-- 
1.5.3.4
