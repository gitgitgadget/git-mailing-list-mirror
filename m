From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Scribblings for a cogito/git tutorial
Date: Fri, 21 Oct 2005 18:46:56 -0300
Message-ID: <200510212146.j9LLkun3004745@inti.inf.utfsm.cl>
References: <pasky@suse.cz>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, git@vger.kernel.org,
	"Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Oct 23 20:52:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETkwE-00013V-9k
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 20:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVJWSvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVJWSvT
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 14:51:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:61922 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750993AbVJWSvT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 14:51:19 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9LLkun3004745;
	Fri, 21 Oct 2005 18:46:56 -0300
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: Message from Petr Baudis <pasky@suse.cz> 
   of "Fri, 21 Oct 2005 22:51:29 +0200." <20051021205129.GI30889@pasky.or.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10501>

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Mon, Oct 17, 2005 at 05:04:54PM CEST, I got a letter
> where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> > I've also been asked around here for a cogito+git tutorial, to that end
> > I've made up a script that simulates several developers interacting.
> > Hacking around is simulated by patching, ed(1) scripts (merges don't turn
> > out the same diff every time), and plain copying new files in. I've set up
> > a GPG key with an empty passphrase (comment is "Experimental") to have
> > signed tags, etc. in a convenient manner. The idea is to create interesting
> > histories (for browsing) and show off the commands in a compact way. If
> > only there was a convenient way to run a strech of the (bash) script, look
> > at the results, and then resume...
> > 
> > Comments, suggestions, patches are welcome! 
> > 
> > Repository of the script and supporting files is at
> > <http://pincoya.inf.utfsm.cl/Script.git>

> Thanks, it's very nice! If you don't mind (actually, is it / can it be GPL?),

Certainly, I realized later that I didn't clarify the license. It's on my
TODO list ;-)

I'm also thinking on changing the octopus example into one that works and
clean up some stuff. And perhaps make Bob into a diehard git user, for
contrast.

> I added it to Cogito as Documentation/tutorial-script/ .

I'm honored.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
