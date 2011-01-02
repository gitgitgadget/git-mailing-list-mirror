From: Marcus Gustafsson <marcus@marcus.ax>
Subject: Publish website incl. submodules
Date: Sun, 2 Jan 2011 21:01:33 +0200
Message-ID: <2297A4F8-A021-47E2-BD86-D3B5561F0AE3@marcus.ax>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 02 22:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZV6l-0002fB-Md
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 22:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab1ABVEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 16:04:48 -0500
Received: from legolas.alcom.aland.fi ([194.112.1.132]:42022 "EHLO
	legolas.alcom.aland.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab1ABVEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jan 2011 16:04:48 -0500
X-Greylist: delayed 7388 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jan 2011 16:04:47 EST
Received: from aragon.alcom.aland.fi (aragon [194.112.0.1])
	by legolas.alcom.aland.fi (8.12.11.20060308/8.12.11) with ESMTP id p02J1b5S002449
	for <git@vger.kernel.org>; Sun, 2 Jan 2011 21:01:37 +0200
Received: from [192.168.2.11] (79-133-10-116.bredband.aland.net [79.133.10.116])
	by aragon.alcom.aland.fi (8.12.11.20060308/8.12.11) with ESMTP id p02J1Yru015626
	for <git@vger.kernel.org>; Sun, 2 Jan 2011 21:01:35 +0200
X-Mailer: Apple Mail (2.1082)
X-Alcom-AS: Sun, 02 Jan 2011 21:01:39 EET
X-Alcom-AV: Sun, 02 Jan 2011 21:01:40 EET
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164426>

Hello!

I'm quite, but not completely, new to Git. So far I've figured out everything I needed to know, but I just stumbled upon something which requires some help... I found the link to the mailinglist on https://git.wiki.kernel.org/index.php/GitCommunity

I want to use git to manage a (php-based) website. I'll be using "git submodules" to incorporate a few external tools. My question is: what's the best setup for publishing the latest version to the webserver, making sure even the submodules are updated to the correct version. I suppose I should use master-branch as the "latest version which to push", so the submodules should be updated to the version master is using.

Sincerely,
Marcus Gustafsson