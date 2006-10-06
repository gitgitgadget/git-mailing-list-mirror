From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Fri, 6 Oct 2006 17:53:31 +0200
Message-ID: <20061006155331.GR20017@pasky.or.cz>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu> <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu> <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu> <7vfyedg56m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609270006020.9602@attu4.cs.washington.edu> <Pine.LNX.4.63.0609270948140.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rientjes <rientjes@cs.washington.edu>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 17:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVs12-00070o-7f
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 17:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWJFPxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 11:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWJFPxd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 11:53:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58039 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751513AbWJFPxd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 11:53:33 -0400
Received: (qmail 14979 invoked by uid 2001); 6 Oct 2006 17:53:31 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609270948140.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28409>

Dear diary, on Wed, Sep 27, 2006 at 09:50:11AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> Git's source code is very clean and readable, even if there are inversions 
> you might not be used to.

I think it's a good sign that _this_ is what we argue about. ;-)

-- 
				Petr "Pasky the 10 > x Loather" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
