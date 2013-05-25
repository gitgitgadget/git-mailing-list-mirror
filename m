From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] trivial: Add missing period in documentation
Date: Sat, 25 May 2013 16:23:42 -0400
Message-ID: <1369513422-15326-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 22:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgL9d-0007z3-1w
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 22:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab3EYUdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 16:33:17 -0400
Received: from mtv-iport-3.cisco.com ([173.36.130.14]:30876 "EHLO
	mtv-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757943Ab3EYUdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 16:33:17 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 May 2013 16:33:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=829; q=dns/txt; s=iport;
  t=1369513997; x=1370723597;
  h=from:to:cc:subject:date:message-id;
  bh=nOByJgPmooKj3aFqmYYzBqUSwrkHRiR7mFccgFyAi4c=;
  b=Nt6uKPjeC7b0rT5o7hOnjbOhE4lyTHBrQ9lBYXcc7B0Nnz2D0Sf7qzbA
   67jfh9ub9XQVrveJewzNc9zsMKt7ZjaRcd6I7ooj2QjZJzv/X41/LCM+C
   XluRRQMQNTALrd46d6fKa37f5P9WmzysvIcOUxot39gJHezXVeCTSzrlG
   s=;
X-IronPort-AV: E=Sophos;i="4.87,741,1363132800"; 
   d="scan'208";a="79575493"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by mtv-iport-3.cisco.com with ESMTP; 25 May 2013 20:23:45 +0000
Received: from ipsn-lnx-hordp.cisco.com (rtp-hordp-8914.cisco.com [10.117.80.101])
	by mtv-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id r4PKNhD8006739;
	Sat, 25 May 2013 20:23:44 GMT
X-Mailer: git-send-email 1.8.3.426.gea353ce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225531>

---
 Documentation/diff-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 104579d..b8a9b86 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -480,7 +480,7 @@ endif::git-format-patch[]
 
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules in the diff generation. <when> can be
-	either "none", "untracked", "dirty" or "all", which is the default
+	either "none", "untracked", "dirty" or "all", which is the default.
 	Using "none" will consider the submodule modified when it either contains
 	untracked or modified files or its HEAD differs from the commit recorded
 	in the superproject and can be used to override any settings of the
-- 
1.8.3.426.gea353ce.dirty
