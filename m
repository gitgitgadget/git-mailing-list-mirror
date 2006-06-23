From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Fri, 23 Jun 2006 13:10:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231310290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <20060622205859.GF21864@pasky.or.cz>
 <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 13:11:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtjZ6-0001kg-9I
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 13:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbWFWLK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 07:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933050AbWFWLK5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 07:10:57 -0400
Received: from mail.gmx.de ([213.165.64.21]:56466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933037AbWFWLK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 07:10:56 -0400
Received: (qmail invoked by alias); 23 Jun 2006 11:10:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 23 Jun 2006 13:10:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22405>

Hi,

On Thu, 22 Jun 2006, Linus Torvalds wrote:

> On Thu, 22 Jun 2006, Petr Baudis wrote:
> > 
> > Isn't manually numbering the enum choices somewhat pointless, though?
> > (Actually makes it more difficult to do changes in it later.)
> 
> Yeah, I just mindlessly followed Johannes' original scheme. 

... which wasn't his, to begin with ...
