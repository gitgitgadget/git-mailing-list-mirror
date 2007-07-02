From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] Correctly document the name of the global excludes file configuration
Date: Mon,  2 Jul 2007 10:48:34 -0600
Message-ID: <11833949141179-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 18:48:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5P4v-0005es-R9
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 18:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbXGBQsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 12:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbXGBQsh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 12:48:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52274 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893AbXGBQsh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 12:48:37 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7C6BF334D;
	Mon,  2 Jul 2007 12:48:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Jul 2007 12:48:36 -0400
X-Sasl-enc: wk8p5vdck9rtnAxSx9Xf6PGjuPUBtTczLSOOTt07qXBh 1183394915
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id DDE7F1849;
	Mon,  2 Jul 2007 12:48:35 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51381>

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 50503e8..1d96adf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -275,7 +275,7 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
-core.excludeFile::
+core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.  See
-- 
1.5.2.2.238.g7cbf2f2
