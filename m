From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git-windows and git-svn?
Date: Fri, 2 Nov 2007 22:07:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711022206190.4362@racer.site>
References: <fgg6cd$3ep$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Abdelrazak Younes <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Fri Nov 02 23:09:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io4hC-0001lI-Qs
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 23:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbXKBWIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXKBWIh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:08:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:36803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755190AbXKBWIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:08:37 -0400
Received: (qmail invoked by alias); 02 Nov 2007 22:08:35 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp050) with SMTP; 02 Nov 2007 23:08:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dVMpNXucdlMKLRvzXDTqqusTlwo9XOdZ/xz6FI/
	kuRaj8Q8HP18Nu
X-X-Sender: gene099@racer.site
In-Reply-To: <fgg6cd$3ep$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63182>

Hi,

On Fri, 2 Nov 2007, Abdelrazak Younes wrote:

> I would like to try git on Windows together with git-svn, I downloaded 
> Git-1.5.3-preview20071027.exe and tried:
> 
> yns@xxx /d/devel/lyx/git/trunk
> $ git-svn init svn://svn.lyx.org/lyx/lyx-devel/trunk
> Useless use of a constant in void context at /bin/git-svn line 848.
> Can't locate Digest/MD5.pm in @INC (@INC contains: /lib
> /usr/lib/perl5/5.6.1/msy
> s /usr/lib/perl5/5.6.1 /usr/lib/perl5/site_perl/5.6.1/msys
> /usr/lib/perl5/site_p
> erl/5.6.1 /usr/lib/perl5/site_perl .) at /bin/git-svn line 2420.
> BEGIN failed--compilation aborted at /bin/git-svn line 2420.
> 
> Is there something I am doing wrong?

The proper mailinglist for this is msysgit@googlegroups.com.  And right 
next to the "Downloads" tab you clicked on to download the installer, 
there is an "Issues" tab.  There you'll find that we're working on it.

Hth,
Dscho
