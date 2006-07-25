From: Mike Galbraith <efault@gmx.de>
Subject: git-1.4.1.1-1 git-clone-pack: unable to read from git-index-pack
Date: Tue, 25 Jul 2006 14:13:28 +0200
Message-ID: <1153829608.2258.32.camel@Homer.simpson.net>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 25 14:07:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Lgo-0002Xh-7j
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 14:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWGYMGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWGYMGs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 08:06:48 -0400
Received: from mail.gmx.de ([213.165.64.21]:61349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932344AbWGYMGr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 08:06:47 -0400
Received: (qmail invoked by alias); 25 Jul 2006 12:06:46 -0000
Received: from p54B5AC1A.dip0.t-ipconnect.de (EHLO Homer) [84.181.172.26]
  by mail.gmx.net (mp018) with SMTP; 25 Jul 2006 14:06:46 +0200
X-Authenticated: #14349625
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.6.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24171>

Greetings,

Having finally acquired DSL (only 400kbps, but at least I'm in the
twentieth century [not typo]), I decided to finally give git a try.  I
installed git-1.4.1.1-1, and armed myself with Jeff's how-to.  I didn't
get far before git saved me the trouble of truly testing my resolve :)

	-Mike

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
error: git-clone-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
clone-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed
