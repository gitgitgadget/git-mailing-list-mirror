From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH] Unclutter cg status with --directory as GIT does
Date: Wed, 29 Mar 2006 17:04:14 +0200
Message-ID: <200603291704.14870.blaisorblade@yahoo.it>
References: <20060329142559.12059.52795.stgit@zion.home.lan> <20060329145427.GI27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 17:06:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOcET-00015L-Pb
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 17:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWC2PEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC2PEZ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 10:04:25 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:48259 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750774AbWC2PEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 10:04:25 -0500
Received: (qmail 94572 invoked from network); 29 Mar 2006 15:04:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=BWUT08+gEubcrC3eMp2F+VhRy9rNhZxMKXA5GjgbRNxcGTPCQH9QQYMo1HDldOYYHBEPsTdAIVYpl0fOpgZLuaJIVahPEf5p2l2q7xgYE5iJsFQOSmWMoQCSUrnKJuGTAfmc89sH/QCF0dbwRhwJQM3TISyrXFGaQ+vz8TktvBQ=  ;
Received: from unknown (HELO ?151.97.230.49?) (blaisorblade@151.97.230.49 with login)
  by smtp006.mail.ukl.yahoo.com with SMTP; 29 Mar 2006 15:04:18 -0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.3
In-Reply-To: <20060329145427.GI27689@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18171>

On Wednesday 29 March 2006 16:54, Petr Baudis wrote:
> Dear diary, on Wed, Mar 29, 2006 at 04:25:59PM CEST, I got a letter
> where Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> said that...

> > Pass the new --directory option (from git 1.1) to git-ls-others for
> > list_untracked_files, as does git-status - it's very useful.

> > Probably this must be deferred to when the git 1.1 dependency is added,
> > however please queue it for then.

> Uh, I'm confused. Cogito now depends on git-1.1, and

> as you can see, if list_untracked_files was pssed the 'squashdirs'
> option, it will already pass it. What cg command would you like to
> squash dirs except cg-status?

Sorry, that's just an old patch then, I didn't note you did it yourself.

I wrote it before you had the 1.1 dependency and didn't notice you made 
something similar.

Bye and sorry for the noise
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
