From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add .mailmap for git-shortlog output with the git repository
Date: Mon, 25 Dec 2006 23:25:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612252322360.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_LlIHY5mCJ4UPVRJtFhmoVQ)"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 05:25:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz3sw-0008Dr-1j
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 05:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWLZEZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 23:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWLZEZq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 23:25:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28584 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbWLZEZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 23:25:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAV00L365MWYAA0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Dec 2006 23:25:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35409>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_LlIHY5mCJ4UPVRJtFhmoVQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

The git repository itself was messed up in a couple cases.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000..2c658f4
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,37 @@
+#
+# This list is used by git-shortlog to fix a few botched name translations
+# in the git archive, either because the author's full name was messed up
+# and/or not always written the same way, making contributions from the
+# same person appearing not to be so.
+#
+
+Aneesh Kumar K.V <aneesh.kumar@gmail.com>
+Chris Shoemaker <c.shoemaker@cox.net>
+Daniel Barkalow <barkalow@iabervon.org>
+David Kågedal <davidk@lysator.liu.se>
+Fredrik Kuivinen <freku045@student.liu.se>
+H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
+H. Peter Anvin <hpa@tazenda.sc.orionmulti.com>
+H. Peter Anvin <hpa@trantor.hos.anvin.org>
+Horst H. von Brand <vonbrand@inf.utfsm.cl>
+Joachim Berdal Haga <cjhaga@fys.uio.no>
+Jon Loeliger <jdl@freescale.com>
+Jon Seymour <jon@blackcubes.dyndns.org>
+Karl Hasselström <kha@treskal.com>
+Kent Engstrom <kent@lysator.liu.se>
+Lars Doelle <lars.doelle@on-line.de>
+Lars Doelle <lars.doelle@on-line ! de>
+Lukas Sandström <lukass@etek.chalmers.se>
+Martin Langhoff <martin@catalyst.net.nz>
+Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
+Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
+René Scharfe <rene.scharfe@lsrfire.ath.cx>
+Robert Fitzsimons <robfitz@273k.net>
+Santi Béjar <sbejar@gmail.com>
+Sean Estabrooks <seanlkml@sympatico.ca>
+Shawn O. Pearce <spearce@spearce.org>
+Tony Luck <tony.luck@intel.com>
+Ville Skyttä <scop@xemacs.org>
+YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
+anonymous <linux@horizon.com>
+anonymous <linux@horizon.net>

--Boundary_(ID_LlIHY5mCJ4UPVRJtFhmoVQ)--
