From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 10:07:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607271003270.4168@g5.osdl.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org> <Pine.LNX.4.63.0607271846390.8976@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:08:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69Kr-0001Fs-6m
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWG0RHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWG0RHm
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:07:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751773AbWG0RHl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:07:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RH7MnW012321
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 10:07:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RH7LYm009558;
	Thu, 27 Jul 2006 10:07:21 -0700
To: Grzegorz Kulewski <kangur@polcom.net>
In-Reply-To: <Pine.LNX.4.63.0607271846390.8976@alpha.polcom.net>
X-Spam-Status: No, hits=-0.573 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24306>



On Thu, 27 Jul 2006, Grzegorz Kulewski wrote:
> 
> I think that part of the anwser for question "Why do people use GIT?" is that
> they trust you and other maintainers that you do a good and stable job. Won't
> creating several ports/forks/whatever destroy at least part of this?

Sure. But the point is, the GPLv2 isn't exactly up for discussion. People 
can complain all they want, but if they want to trust me, they'll take the 
GPLv2. It's that easy.

And if people don't want the GPLv2, they have alternatives as outlined. 
Yes, their code will be less reliable and good, but hey, that's kind of my 
_point_. A lot of the quality of open source projects comes from the fact 
that you see how it gets used, and the LGPL is strictly inferior, because 
it ends up hiding all the _important_ parts behind a veil of impenetrable 
secrecy.

Quite frankly, I don't want to see bug-reports and interfaces that I can't 
actually duplicate and follow myself. I'm so _totally_ uninterested in 
those kinds of things that it's not even funny.

			Linus
