From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] missing file
Date: Wed, 10 Jan 2007 12:56:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701101251530.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 18:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4hh9-0006xr-4u
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 18:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbXAJR4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbXAJR4m
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 12:56:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17089 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964980AbXAJR4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 12:56:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBN00FI0Z6HV060@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Jan 2007 12:56:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36518>

Oops. Commit 515377ea9ec6192f82a2fa5c5b5b7651d9d6cf6c missed one 
file.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
new file mode 100644
index 0000000..36838c7
--- /dev/null
+++ b/Documentation/git-init.txt
@@ -0,0 +1 @@
+include::git-init-db.txt[]
