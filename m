From: jidanni@jidanni.org
Subject: [PATCH/RFC] contrib/examples/README: warn of obsolescence
Date: Tue, 13 Jan 2009 08:45:18 +0800
Message-ID: <87fxjoowyp.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 01:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXQe-0007V3-6Y
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbZAMApY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZAMApY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:45:24 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:34613 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751491AbZAMApX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 19:45:23 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id E906440C85
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 16:45:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105427>

We attempt to give an explanation of the status of the files in this
directory.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 contrib/examples/README |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 contrib/examples/README

diff --git a/contrib/examples/README b/contrib/examples/README
new file mode 100644
index 0000000..b10910c
--- /dev/null
+++ b/contrib/examples/README
@@ -0,0 +1 @@
+Note that these are obsolete versions of programs now replaced by C code.
-- 
1.6.0.6
