From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Fri, 28 Jul 2006 04:56:19 +0200
Message-ID: <20060728025619.GK13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de> <200607262039.25155.Josef.Weidendorfer@gmx.de> <20060728013038.GH13776@pasky.or.cz> <7vvepimoxr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 04:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6IWf-0006N9-Ks
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 04:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWG1C4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 22:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWG1C4X
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 22:56:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40392 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751065AbWG1C4W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 22:56:22 -0400
Received: (qmail 31569 invoked by uid 2001); 28 Jul 2006 04:56:19 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvepimoxr.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24363>

Dear diary, on Fri, Jul 28, 2006 at 04:41:04AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> >   (iv) I need git-apply to add/remove to/from index new/gone files,
> > while at the same time...
> >
> >   (v) I want to allow applying of patches to working copy that is not
> > completely clean, even on top of modified files
> 
> You probably should be able to talk me into doing these, but
> doesn't it already do (iv) and (v)?

Well, at once? I can do (iv) by adding --index but that contradicts (v).
But maybe I'm missing something.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
