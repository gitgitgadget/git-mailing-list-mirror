From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Mon, 25 Sep 2006 22:15:00 +0200
Message-ID: <20060925201500.GG20017@pasky.or.cz>
References: <200609212356.31806.jnareb@gmail.com> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz> <200609231533.02455.jnareb@gmail.com> <20060923140535.GK8259@pasky.or.cz> <ef95rk$o4q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 22:16:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRwra-0002RX-Id
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 22:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWIYUPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWIYUPe
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 16:15:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62356 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751013AbWIYUPC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 16:15:02 -0400
Received: (qmail 17331 invoked by uid 2001); 25 Sep 2006 22:15:00 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ef95rk$o4q$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27752>

Dear diary, on Mon, Sep 25, 2006 at 08:06:44PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> So when putting message if into commit message, just put the commit
> message in separate line, perhaps even with some indentation, like
> below:
>   Msg-Id: <200609231533.02455.jnareb@gmail.com>

Oh please. :-) The tool should bend, not the user.

Are you going to mandate that for bug references as well? Or should I
proofread all of my commits (if they aren't actually just autoformatted
by fmt without my further review) to verify that they don't actually end
up wrapped, and manually reformat the whole paragraph?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
