From: jidanni@jidanni.org
Subject: [PATCH,v2] contrib/examples/README: give an explanation of the status of these files
Date: Tue, 13 Jan 2009 09:19:42 +0800
Message-ID: <877i50ovdd.fsf_-_@jidanni.org>
References: <7viqokf21j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 13 02:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXxu-00081h-QV
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419AbZAMBTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbZAMBTq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:19:46 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:43366 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753521AbZAMBTq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 20:19:46 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 0AABFC482B;
	Mon, 12 Jan 2009 17:19:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105435>

We attempt to give an explanation of the status of the files in this
directory.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 contrib/examples/README |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 contrib/examples/README

diff --git a/contrib/examples/README b/contrib/examples/README
new file mode 100644
index 0000000..6946f3d
--- /dev/null
+++ b/contrib/examples/README
@@ -0,0 +1,3 @@
+These are original scripted implementations, kept primarily for their
+reference value to any aspiring plumbing users who want to learn how
+pieces can be fit together.
-- 
1.6.0.6
