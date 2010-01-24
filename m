From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Make test numbers unique
Date: Sun, 24 Jan 2010 22:40:20 +0100
Organization: 
Message-ID: <201001242240.20457.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 22:41:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZAD7-0000NU-Ej
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 22:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0AXVla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 16:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502Ab0AXVl3
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 16:41:29 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:9272 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753444Ab0AXVl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 16:41:29 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7D51FCDF85;
	Sun, 24 Jan 2010 22:41:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8B04F19F5EC;
	Sun, 24 Jan 2010 22:40:20 +0100 (CET)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137920>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 :-P

 ...rse-upstream.sh => t1507-rev-parse-upstream.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t1506-rev-parse-upstream.sh => t1507-rev-parse-upstream.sh} (100%)

diff --git a/t/t1506-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
similarity index 100%
rename from t/t1506-rev-parse-upstream.sh
rename to t/t1507-rev-parse-upstream.sh
-- 
1.6.6.264.ga6155
