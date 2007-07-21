From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-gui i18n repo on repo.or.cz
Date: Sat, 21 Jul 2007 03:12:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707210300490.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Xudong Guan <xudong.guan@gmail.com>,
	Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 04:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC4dJ-0002aK-4Z
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 04:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbXGUCXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 22:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbXGUCXq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 22:23:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:48665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753032AbXGUCXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 22:23:45 -0400
Received: (qmail invoked by alias); 21 Jul 2007 02:13:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 21 Jul 2007 04:13:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sWkYems6sNuaW/cl/OtMlHcBgcVqRkTqze92q0o
	mDquLfqBMDQJqO
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53132>

Hi people,

I proudly present...

	http://repo.or.cz/w/git-gui/git-gui-i18n.git

It is meant to be rebased to git-gui's master pretty often.  It has also a 
mob branch where you can push your new changes into.

For those who do not know what a mob branch is: By using the URL 
mob@repo.or.cz:/srv/git/git-gui/git-gui-i18n.git, without password, 
_everybody_ can push into the branch named "mob" (but _only_ into that).

This facilitates participation without the need of a password, or commit 
permissions, since it is mean to be pulled/cherry-picked by the repo 
maintainer, who can decide what is good and what is bad.  For the moment, 
the maintainer is yours truly.  If somebody volunteers, I am certainly not 
sad.

I would like to ask people to not push with "+" into the mob branch, but 
pull it instead, so that we do not lose any valuable data.  It is probably 
a good idea to send an email to the repo maintainer, too.

For the time being, I will rebase the master branch relatively often, 
and try to stay on top of the mob branch.

At the moment, the repo contains three branches: master (which I would 
like to be rebased onto git-gui's master quite frequently), 
christian-orig, the patch series which Christian sent, and which branched 
off git-gui's master roughly 8 days ago, and the mob branch.

Ciao,
Dscho
