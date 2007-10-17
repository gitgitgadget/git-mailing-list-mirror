From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/6] miscelaneous stuff
Date: Tue, 16 Oct 2007 21:55:44 -0400
Message-ID: <1192586150-13743-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9P-0003Wi-8R
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936197AbXJQBz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936189AbXJQBzy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:55:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbXJQBzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:55:53 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:51 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61306>

This is a few patches I've been accumulating.  Included is a rework of
the progress display so it uses much less screen lines, as well as a
couple code cleanups.


Nicolas
