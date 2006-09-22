From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 5/6] gitweb: Rename "plain" labels to "raw"
Date: Sat, 23 Sep 2006 01:09:37 +0200
Message-ID: <20060922230937.GC8259@pasky.or.cz>
References: <20060922011941.15909.32671.stgit@rover> <20060922011950.15909.78402.stgit@rover> <ef08v5$mk9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 01:09:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQu9O-0001fa-RI
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWIVXJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWIVXJj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:09:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62116 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964846AbWIVXJj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:09:39 -0400
Received: (qmail 5106 invoked by uid 2001); 23 Sep 2006 01:09:37 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ef08v5$mk9$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27540>

Dear diary, on Fri, Sep 22, 2006 at 11:04:49AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > I don't have much preference either way and as far as I'm concerned, it may
> > go the other way as well. Consistency is what is important.
> 
> "raw" link was introduced in 25b7c18ecd9779158cb1c02572396bab22c6e0cf
> by Luben Tuikov. I'd rather use "plain"...

I kind of like "raw" more because it's IMHO more obvious what it exactly
is (it could also mean some stripped-down HTML or whatever otherwise)
and is more appropriate for things that actually are not plaintext, like
pictures.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
