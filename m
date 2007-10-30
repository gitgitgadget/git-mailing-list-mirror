From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/5] add some copyright notice to the progress display code
Date: Tue, 30 Oct 2007 15:41:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710301535160.21255@xanadu.home>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
 <1193770655-20492-3-git-send-email-nico@cam.org>
 <1193770655-20492-4-git-send-email-nico@cam.org>
 <1193770655-20492-5-git-send-email-nico@cam.org>
 <1193770655-20492-6-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 20:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imwxu-0006Mn-AY
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXJ3TlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbXJ3TlS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:41:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49708 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625AbXJ3TlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:41:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ00C2DPCPL4A0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 15:41:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1193770655-20492-6-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62741>

Some self patting on the back to keep my ego alive.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/progress.c b/progress.c
index 23ee9f3..2c4057a 100644
--- a/progress.c
+++ b/progress.c
@@ -1,3 +1,13 @@
+/*
+ * Simple text-based progress display module for GIT
+ *
+ * Copyright (c) 2007 by Nicolas Pitre <nico@cam.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
 #include "git-compat-util.h"
 #include "progress.h"
 
