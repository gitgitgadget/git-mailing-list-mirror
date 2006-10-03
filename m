From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Error in test description of t1200-tutorial
Date: Tue, 03 Oct 2006 02:02:15 +0200
Message-ID: <20061003000215.31265.84542.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 03 02:02:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUXjX-0004q6-Ha
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 02:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965535AbWJCACA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 20:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965536AbWJCAB7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 20:01:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:22123 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S965535AbWJCAB6
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 20:01:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 5522980289C
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 01:59:05 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11432-01 for <git@vger.kernel.org>; Tue,  3 Oct 2006 01:59:05 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by torino.dewire.com (Postfix) with ESMTP id 0AB1080286A
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 01:59:03 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6A07228F59
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 02:02:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id eFDUuTIKAVTp for <git@vger.kernel.org>;
	Tue,  3 Oct 2006 02:02:16 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 3B17528B58
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 02:02:16 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28241>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 t/t1200-tutorial.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index c7db20e..0272dd4 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2005 Johannes Schindelin
 #
 
-test_description='Test git-rev-parse with different parent options'
+test_description='A simple turial in the form of a test case'
 
 . ./test-lib.sh
 
