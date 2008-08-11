From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] Documentation: rev-list-options: Fix a typo
Date: Tue, 12 Aug 2008 01:55:35 +0200
Message-ID: <ac1b3fe540b183acc8cdd87d36c55256cc56a204.1218498922.git.trast@student.ethz.ch>
References: <200808120151.56067.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:57:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KShFz-0003O6-Sw
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbYHKXzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbYHKXzw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:55:52 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9004 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558AbYHKXzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:55:52 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:55:50 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:55:50 +0200
X-Mailer: git-send-email 1.6.0.rc2.56.g86ca
In-Reply-To: <200808120151.56067.trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Aug 2008 23:55:50.0245 (UTC) FILETIME=[C8212950:01C8FC0D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92028>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/rev-list-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3aa3809..83070ed 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -71,7 +71,7 @@ For example, if you have this topology:
          o---x---a---a  branch A
 -----------------------------------------------------------------------
 +
-you would get an output line this:
+you would get an output like this:
 +
 -----------------------------------------------------------------------
 	$ git rev-list --left-right --boundary --pretty=oneline A...B
-- 
1.6.0.rc2.56.g86ca
