From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 7 Oct 2006 20:41:48 +0200
Message-ID: <20061007184148.GE20017@pasky.or.cz>
References: <20061007141040.16912.50717.stgit@rover> <20061007183702.40162.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 20:42:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWH7S-0002Yh-Nr
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 20:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWJGSlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 14:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWJGSlv
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 14:41:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48786 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751826AbWJGSlv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 14:41:51 -0400
Received: (qmail 21335 invoked by uid 2001); 7 Oct 2006 20:41:48 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061007183702.40162.qmail@web31802.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28493>

Dear diary, on Sat, Oct 07, 2006 at 08:37:02PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> --- Petr Baudis <pasky@suse.cz> wrote:
> > Currently that's inconsistently reachable only by first displaying the
> > tree.
> 
> I cannot say that there is any "inconsistency" there per se.  I also
> fail to see the value of this patch.

Currently the bottom navbar is more or less the same as the list of
links in the tree entry (there's the HEAD link but that's a special
case).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
