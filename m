From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] user-manual.txt: fix a tiny typo.
Date: Sun, 18 Mar 2007 18:39:56 +0100
Message-ID: <87odmqtpqr.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 18:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSzMM-0007fh-UK
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 18:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbXCRRj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 13:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbXCRRj6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 13:39:58 -0400
Received: from mx.meyering.net ([82.230.74.64]:35366 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbXCRRj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 13:39:57 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 6D0C216E6; Sun, 18 Mar 2007 18:39:56 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42508>

"file patch" was doubtless intended to be "file path",
but "directory name" is clearer.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d7b227e..72668f0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1698,7 +1698,7 @@
 then you can just pull changes from each other's repositories
 directly; note that all of the commands (gitlink:git-clone[1],
 git-fetch[1], git-pull[1], etc.) that accept a URL as an argument
-will also accept a local file patch; so, for example, you can
+will also accept a local directory name; so, for example, you can
 use

 -------------------------------------------------
--
1.5.0.4.402.g8035
