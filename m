From: Nicolas Pitre <nico@cam.org>
Subject: various cleanups
Date: Mon, 26 Feb 2007 14:55:54 -0500
Message-ID: <11725197603476-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlxB-000448-Dg
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbXBZT4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXBZT4E
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:56:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030323AbXBZT4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:56:03 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3007SW61CD1Q1@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 14:56:00 -0500 (EST)
X-Mailer: git-send-email 1.5.0.572.ge86d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40653>

Here's a bunch of cleanups I've accumulated.  I attempted to work on some
pack optimizations last weekend but some other things in the code kept
bothering me.  So here is what I have so far.

Nicolas
