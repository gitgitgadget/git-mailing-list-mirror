From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add a link to the gfi doc in the main index
Date: Wed, 07 Feb 2007 16:43:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702071642030.13009@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEuZy-00046q-EG
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbXBGVnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbXBGVnr
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:43:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14925 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161436AbXBGVnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:43:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD400G7H4CX9Q40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Feb 2007 16:43:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38977>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 6dba8d8..4409242 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -92,6 +92,7 @@ git-diff-index                          plumbinginterrogators
 git-diff                                mainporcelain
 git-diff-stages                         plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
+git-fast-import                         plumbingmanipulators
 git-fetch                               mainporcelain
 git-fetch-pack                          synchingrepositories
 git-fmt-merge-msg                       purehelpers
