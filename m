From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Documentation/git-gc.txt: change "references" to "reference"
Date: Mon, 19 Oct 2009 22:22:25 -0700
Message-ID: <1256016145-21680-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 20 07:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N07Dn-0004gY-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 07:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbZJTFZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 01:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbZJTFZM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 01:25:12 -0400
Received: from zoom.lafn.org ([206.117.18.8]:48631 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbZJTFZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 01:25:11 -0400
Received: from macbookpro (pool-173-51-225-123.lsanca.fios.verizon.net [173.51.225.123])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id n9K5P5xV031522
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Oct 2009 22:25:06 -0700 (PDT)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1N07Ax-0005fA-65; Mon, 19 Oct 2009 22:22:27 -0700
X-Mailer: git-send-email 1.6.5
X-Virus-Scanned: clamav-milter 0.95.1 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130758>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Documentation/git-gc.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 1f6df6a..4cd9cdf 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -120,7 +120,7 @@ Notes
 particular, it will keep not only objects referenced by your current set
 of branches and tags, but also objects referenced by the index, remote
 tracking branches, refs saved by 'git-filter-branch' in
-refs/original/, or reflogs (which may references commits in branches
+refs/original/, or reflogs (which may reference commits in branches
 that were later amended or rewound).
 
 If you are expecting some objects to be collected and they aren't, check
-- 
1.6.5
