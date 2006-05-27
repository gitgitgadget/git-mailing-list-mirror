From: Pavel Roskin <proski@gnu.org>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 22:36:22 -0400
Message-ID: <1148697382.5599.1.camel@dv>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
	 <20060526193325.d2a530a4.tihirvon@gmail.com>
	 <20060526163829.GB10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 04:36:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjofR-0004fX-OV
	for gcvg-git@gmane.org; Sat, 27 May 2006 04:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWE0Cgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 22:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWE0Cgd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 22:36:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:31652 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751273AbWE0Cgc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 22:36:32 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FjofH-0006Ud-MC
	for git@vger.kernel.org; Fri, 26 May 2006 22:36:31 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fjof9-0001YM-3Q; Fri, 26 May 2006 22:36:23 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060526163829.GB10488@pasky.or.cz>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20830>

On Fri, 2006-05-26 at 18:38 +0200, Petr Baudis wrote:
> Dear diary, on Fri, May 26, 2006 at 06:33:25PM CEST, I got a letter
> where Timo Hirvonen <tihirvon@gmail.com> said that...
> > I backup my $HOME using git, so there's a .git directory in ~.
> 
> Then it should be called ~/.gitconfig. :-)

No, make it .gitrc for compatibility with .cvsrc, .lynxrc and others.

I know, it's becoming a bikeshed issue :-)

-- 
Regards,
Pavel Roskin
