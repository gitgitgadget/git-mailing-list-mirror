From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 00:28:15 +0200
Message-ID: <20050420222815.GM19112@pasky.ji.cz>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONc9-0008Oo-HU
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVDTW21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDTW21
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:28:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53215 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261837AbVDTW2X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:28:23 -0400
Received: (qmail 10275 invoked by uid 2001); 20 Apr 2005 22:28:15 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 12:09:06AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Yeah, yeah, it looks different from "cvs update", but dammit, wouldn't it 
> be cool to just write "cg-<tab><tab>" and see the command choices? Or 
> "cg-up<tab>" and get cg-update done for you..

I like this idea! :-) I guess that is in fact exactly what I have been
looking for, and (as probably apparent from the current git-pasky
structure) I prefer to have the scripts separated anyway.

I think I will go for it. I also thought about having this _and_ a 'cg'
command which would act as a completely dumb multiplexer, but I decided
to toss that idea since it would only create usage ambiguity and other
problems on the long run.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
