From: Petr Baudis <pasky@suse.cz>
Subject: Re: Scribblings for a cogito/git tutorial
Date: Mon, 24 Oct 2005 00:36:35 +0200
Message-ID: <20051023223635.GV30889@pasky.or.cz>
References: <20051021205129.GI30889@pasky.or.cz> <200510212156.j9LLudEQ005267@inti.inf.utfsm.cl> <20051021205129.GI30889@pasky.or.cz> <200510212146.j9LLkun3004745@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Oct 24 00:37:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EToSG-0001Pj-PX
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJWWgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 18:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJWWgi
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 18:36:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25065 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750820AbVJWWgh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 18:36:37 -0400
Received: (qmail 13273 invoked by uid 2001); 24 Oct 2005 00:36:35 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200510212156.j9LLudEQ005267@inti.inf.utfsm.cl> <200510212146.j9LLkun3004745@inti.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10509>

Dear diary, on Fri, Oct 21, 2005 at 11:46:56PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> I'm also thinking on changing the octopus example into one that works and
> clean up some stuff. And perhaps make Bob into a diehard git user, for
> contrast.

Nice idea to show all the angles - although for Cogito I think I will
stay with pure Cogito (wherever possible), no need to scare the users...
;-))

Dear diary, on Fri, Oct 21, 2005 at 11:56:39PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> > > Repository of the script and supporting files is at
> > > <http://pincoya.inf.utfsm.cl/Script.git>
> 
> > Thanks, it's very nice! If you don't mind (actually, is it / can it be GPL?),
> > I added it to Cogito as Documentation/tutorial-script/ .
> 
> It seems you got the whole history of the script into cogito's history. Is
> that right?

Nope. I couldn't just merge (like gitk-in-git) since I needed to move
the files to a subdirectory, so I would have to do that manually. And I
decided to just flatten it since it was just two revisions, after all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
