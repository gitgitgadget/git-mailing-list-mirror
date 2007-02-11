From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Make gitk save and restore the user set window position.
Date: Sun, 11 Feb 2007 09:27:18 -0500
Message-ID: <11712040401127-git-send-email-mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 11 15:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGFho-00019d-2U
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 15:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbXBKO3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 09:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXBKO3Z
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 09:29:25 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:12615 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXBKO3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 09:29:24 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDA00ECRYTGKKQG@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 08:27:17 -0600 (CST)
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39284>

I sent these patches to Junio and Paul last week, mistyped the git mailing list
address so they didn't get to the list so am resending for the record.

Mark Levedahl
