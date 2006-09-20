From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Fix showing of path in tree view
Date: Thu, 21 Sep 2006 01:43:09 +0200
Message-ID: <20060920234309.GU8259@pasky.or.cz>
References: <20060920231224.GN13132@pasky.or.cz> <eesj84$qku$1@sea.gmane.org> <eesje4$qku$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 01:43:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBik-0007cG-Ow
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWITXnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWITXnL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:43:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12487 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750745AbWITXnK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 19:43:10 -0400
Received: (qmail 10416 invoked by uid 2001); 21 Sep 2006 01:43:09 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eesje4$qku$2@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27435>

Dear diary, on Thu, Sep 21, 2006 at 01:38:49AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Jakub Narebski wrote:
> > Trailing (final) slash is present (and I think should be present) only
> > for path in "tree" view. From the path alone you can see if it is "tree"
> > or "blob" view.

Which sounds like a nice property but the rest of the page looks totally
different anyway, so I don't know how practical that is.

> About link to root tree: we could change the commit title to link to root
> tree instead of linking to commit view.

I don't think that makes any sense. It's a _commit_ title! :-) And if I
want to get to root tree it wouldn't occur to me to click _there_
anyway.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
