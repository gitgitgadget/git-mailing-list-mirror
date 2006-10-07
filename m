From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 7 Oct 2006 21:15:52 +0200
Message-ID: <20061007191552.GG20017@pasky.or.cz>
References: <20061007184148.GE20017@pasky.or.cz> <20061007185253.90045.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 21:18:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHeO-0003eG-S4
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWJGTPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWJGTPy
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:15:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54731 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932778AbWJGTPx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 15:15:53 -0400
Received: (qmail 25623 invoked by uid 2001); 7 Oct 2006 21:15:52 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061007185253.90045.qmail@web31810.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28500>

Dear diary, on Sat, Oct 07, 2006 at 08:52:53PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> Another thing is that currently tree/directory entries' third (links)
> column to be shortest of all, and this gives my eyes another indication
> that this is a tree.

What would people think about first listing all the trees, then all the
blobs? Just like LANG=C ls does, as well as cvsweb and overally most of
the rest of the relevant world.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
