From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] keep .mailmap sorted
Date: Wed, 30 May 2007 11:07:58 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705301106371.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_utZlLA6DRrJ/bIPvZRt/qw)"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 17:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtPmR-0000lI-Mq
	for gcvg-git@gmane.org; Wed, 30 May 2007 17:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbXE3PID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 11:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbXE3PID
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 11:08:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12168 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXE3PIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 11:08:01 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIV004KF0PAJ240@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 May 2007 11:07:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48764>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_utZlLA6DRrJ/bIPvZRt/qw)
Content-type: TEXT/PLAIN; charset=iso-8859-15
Content-transfer-encoding: 8BIT

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/.mailmap b/.mailmap
index 4e0615e..fb93758 100644
--- a/.mailmap
+++ b/.mailmap
@@ -7,6 +7,7 @@
 
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
+Dana L. How <how@deathvalley.cswitch.com>
 Daniel Barkalow <barkalow@iabervon.org>
 David Kågedal <davidk@lysator.liu.se>
 Fredrik Kuivinen <freku045@student.liu.se>
@@ -42,4 +43,3 @@ Ville Skyttä <scop@xemacs.org>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
 anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>
-Dana L. How <how@deathvalley.cswitch.com>

--Boundary_(ID_utZlLA6DRrJ/bIPvZRt/qw)--
