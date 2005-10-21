From: Petr Baudis <pasky@suse.cz>
Subject: Re: Scribblings for a cogito/git tutorial
Date: Fri, 21 Oct 2005 22:51:29 +0200
Message-ID: <20051021205129.GI30889@pasky.or.cz>
References: <200510171504.j9HF4stb006164@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Oct 21 22:52:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET3rT-0003OF-57
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 22:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVJUUvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVJUUvc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 16:51:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2523 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965167AbVJUUvb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 16:51:31 -0400
Received: (qmail 9533 invoked by uid 2001); 21 Oct 2005 22:51:29 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200510171504.j9HF4stb006164@laptop11.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10447>

Dear diary, on Mon, Oct 17, 2005 at 05:04:54PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> I've also been asked around here for a cogito+git tutorial, to that end
> I've made up a script that simulates several developers interacting.
> Hacking around is simulated by patching, ed(1) scripts (merges don't turn
> out the same diff every time), and plain copying new files in. I've set up
> a GPG key with an empty passphrase (comment is "Experimental") to have
> signed tags, etc. in a convenient manner. The idea is to create interesting
> histories (for browsing) and show off the commands in a compact way. If
> only there was a convenient way to run a strech of the (bash) script, look
> at the results, and then resume...
> 
> Comments, suggestions, patches are welcome! 
> 
> Repository of the script and supporting files is at
> <http://pincoya.inf.utfsm.cl/Script.git>

Thanks, it's very nice! If you don't mind (actually, is it / can it be GPL?),
I added it to Cogito as Documentation/tutorial-script/ .

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
