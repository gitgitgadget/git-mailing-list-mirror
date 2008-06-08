From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Remove exec bit from builtin-fast-export.c
Date: Sun, 8 Jun 2008 16:40:13 +0200
Message-ID: <200806081640.13170.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:41:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5M4z-00071P-FI
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbYFHOkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbYFHOkP
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:40:15 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:41385 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYFHOkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:40:15 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 9107E33B5C;
	Sun,  8 Jun 2008 16:40:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6037964480;
	Sun,  8 Jun 2008 16:40:13 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84273>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Just in case you care...

 -- Hannes

 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 builtin-fast-export.c

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
old mode 100755
new mode 100644
-- 
1.5.6.rc2.6.g3056b
