From: Petr Baudis <pasky@ucw.cz>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 10:10:05 +0200
Message-ID: <20050428081005.GG8612@pasky.ji.cz>
References: <42703E79.8050808@zytor.com> <1114673723.12012.324.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:08:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR43d-0007QX-Jf
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 10:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVD1IMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 04:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVD1IM3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 04:12:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23222 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261922AbVD1IKK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 04:10:10 -0400
Received: (qmail 17939 invoked by uid 2001); 28 Apr 2005 08:10:05 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1114673723.12012.324.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 09:35:23AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Wed, 2005-04-27 at 18:38 -0700, H. Peter Anvin wrote:
> > http://www.kernel.org/git/
> 
> Looks like the ordering is wrong. A chronological sort means that
> commits which were made three weeks ago, but which Linus only pulled
> yesterday, do not show up at the top of the tree.

  Linus                     ASM (Anonymous Subsystem Maintainer)

    |------------------------.
   A|                        |B
    |                        |
    |                        \-------------\
    |                        :             |
    \------------------------\             |E
   C|                        |D            |
    |                        /-------------/
    |                        |F
    /------------------------/

How would you show that? F E D C B A? F D C A E B?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
