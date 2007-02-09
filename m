From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove mailmap.linux
Date: Fri, 09 Feb 2007 12:18:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702091210110.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 18:18:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFZON-0005Z4-SC
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 18:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423083AbXBIRSa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 12:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423038AbXBIRSa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 12:18:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39632 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423083AbXBIRS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 12:18:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD7001RFHESFEG0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Feb 2007 12:18:28 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39187>

This file is incomplete, unmaintained, and it doesn't belong in the GIT 
package anyway.

A more complete version is already included in the Linux -mm tree and
is about to make its way into mainline RSN.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/contrib/mailmap.linux b/contrib/mailmap.linux
deleted file mode 100644
index e4907f8..0000000
--- a/contrib/mailmap.linux
+++ /dev/null
@@ -1,42 +0,0 @@
-#
-# Even with git, we don't always have name translations.
-# So have an email->real name table to translate the
-# (hopefully few) missing names
-#
-# repo-abbrev: /pub/scm/linux/kernel/git/
-#
-Adrian Bunk <bunk@stusta.de>
-Andreas Herrmann <aherrman@de.ibm.com>
-Andrew Morton <akpm@osdl.org>
-Andrew Vasquez <andrew.vasquez@qlogic.com>
-Christoph Hellwig <hch@lst.de>
-Corey Minyard <minyard@acm.org>
-David Woodhouse <dwmw2@shinybook.infradead.org>
-Domen Puncer <domen@coderock.org>
-Douglas Gilbert <dougg@torque.net>
-Ed L Cashin <ecashin@coraid.com>
-Evgeniy Polyakov <johnpol@2ka.mipt.ru>
-Felix Moeller <felix@derklecks.de>
-Frank Zago <fzago@systemfabricworks.com>
-Greg Kroah-Hartman <gregkh@suse.de>
-James Bottomley <jejb@mulgrave.(none)>
-James Bottomley <jejb@titanic.il.steeleye.com>
-Jeff Garzik <jgarzik@pretzel.yyz.us>
-Jens Axboe <axboe@suse.de>
-Kay Sievers <kay.sievers@vrfy.org>
-Mitesh shah <mshah@teja.com>
-Morten Welinder <terra@gnome.org>
-Morten Welinder <welinder@anemone.rentec.com>
-Morten Welinder <welinder@darter.rentec.com>
-Morten Welinder <welinder@troll.com>
-Nguyen Anh Quynh <aquynh@gmail.com>
-Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
-Peter A Jonsson <pj@ludd.ltu.se>
-Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
-Rudolf Marek <R.Marek@sh.cvut.cz>
-Rui Saraiva <rmps@joel.ist.utl.pt>
-Sachin P Sant <ssant@in.ibm.com>
-Santtu Hyrkk,Av(B <santtu.hyrkko@gmail.com>
-Simon Kelley <simon@thekelleys.org.uk>
-Tejun Heo <htejun@gmail.com>
-Tony Luck <tony.luck@intel.com>
