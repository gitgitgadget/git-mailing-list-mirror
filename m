From: Petr Baudis <pasky@suse.cz>
Subject: Re: Random Git Issues/Wishlist
Date: Sun, 24 Sep 2006 01:18:25 +0200
Message-ID: <20060923231825.GG20017@pasky.or.cz>
References: <20060722195502.GS13776@pasky.or.cz> <20060723042725.GA12306@spearce.org> <tnxirln5mqy.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 01:18:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRGlf-0001Wv-Ri
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 01:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWIWXS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWIWXS1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 19:18:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3999 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750893AbWIWXS1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 19:18:27 -0400
Received: (qmail 22533 invoked by uid 2001); 24 Sep 2006 01:18:25 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxirln5mqy.fsf@arm.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27639>

  Mailcromancy for fun'n'profit.

Dear diary, on Mon, Jul 24, 2006 at 12:19:01PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@arm.com> said that...
> The StGIT feature wish-list after the OLS is:
> 
> - patch history (I'll probably use reflogs as you suggested)
> - configurable pull command (currently uses git-pull only)
> - commit directly to a patch which is not top
> - patch synchronisation between between branches (as some people,
>   including me have the same patches based on different branches and
>   they have scripts for moving the changes in one to the others)
> - document the workflow on the StGIT wiki
> - maybe a separate undo command rather than passing a --undo option to
>   push and refresh

  After talking with some more random and less random people, another
_big_ wishlist item is having something like a series file (not
necessarily used for storing stuff but just as a user interface), so
that you can easily _reorder_ your patches - that's an onerous task with
StGIT currently, involving a lot of involved popping and pushing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
