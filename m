From: Jim Jensen <jhjjhjjhj@gmail.com>
Subject: problem with git gui on cygwin.
Date: Tue, 11 Nov 2008 16:04:18 +0000 (UTC)
Message-ID: <loom.20081111T155614-227@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 17:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzw4R-0007zZ-QJ
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 17:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYKKQZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 11:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYKKQZH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 11:25:07 -0500
Received: from main.gmane.org ([80.91.229.2]:37471 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbYKKQZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 11:25:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Kzw35-0001vT-1O
	for git@vger.kernel.org; Tue, 11 Nov 2008 16:25:03 +0000
Received: from adsl-8-168-184.mia.bellsouth.net ([65.8.168.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 16:25:03 +0000
Received: from jhjjhjjhj by adsl-8-168-184.mia.bellsouth.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 16:25:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.8.168.184 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100648>

I have been trying to use git for a small project using cygwin.  I copied my
repository from one windows XP system to a Vista system using a usb drive.  On
the new system when I use "git gui" I get a pop up that says "Git directory not
found: .git"

This happens with git gui and gitk.  The command line programs I tried, git show
and git status appear to work.

I updated cygwin and have git version 1.6.0.2.

Does anyone know what the problem is?
