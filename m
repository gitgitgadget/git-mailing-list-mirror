From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/5] more progress display stuff
Date: Tue, 30 Oct 2007 14:57:30 -0400
Message-ID: <1193770655-20492-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwI9-0001bd-1D
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbXJ3S6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbXJ3S6F
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:58:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbXJ3S6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:58:05 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ0021VNC05WB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:57:36 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1463.gf79ad2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62731>

This is the result of some changes and cleanup I did to nicely support
progress with throughput display, and avoid those random crashes the
previous patches introduced.  All tests are OK now after every patch.

This is meant to replace my latest 2 patches currently in pu.


Nicolas
