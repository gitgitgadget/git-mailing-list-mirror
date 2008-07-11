From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/5] t1007-hash-object.sh: use quotes for the test description
Date: Fri, 11 Jul 2008 02:12:04 +0200
Message-ID: <9568dd5d03cd0f1da8872fd71f8bb253560e2352.1215734605.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
 <8275a6b4a676d33a1ae80f29f85c52b7bbda9a84.1215734605.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH6GJ-0008EW-3W
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 02:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYGKAMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 20:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbYGKAMN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 20:12:13 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35022 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYGKAMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 20:12:12 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 940231DDC5B;
	Fri, 11 Jul 2008 02:12:10 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7BB2B1A990A; Fri, 11 Jul 2008 02:12:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <8275a6b4a676d33a1ae80f29f85c52b7bbda9a84.1215734605.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215734604.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88066>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/t1007-hash-object.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 0526295..1ec0535 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description=git-hash-object
+test_description="git-hash-object"
 
 . ./test-lib.sh
 
-- 
1.5.6.2.450.g8d367.dirty
