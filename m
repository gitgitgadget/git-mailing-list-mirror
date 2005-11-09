From: Petr Baudis <pasky@suse.cz>
Subject: Re: latest stg/git commandline completions code
Date: Wed, 9 Nov 2005 23:23:38 +0100
Message-ID: <20051109222338.GK16061@pasky.or.cz>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Blaisorblade <blaisorblade@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:26:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZyM6-0003RW-MR
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbVKIWXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbVKIWXn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:23:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56545 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030452AbVKIWXm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 17:23:42 -0500
Received: (qmail 23404 invoked by uid 2001); 9 Nov 2005 23:23:38 +0100
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11423>

Dear diary, on Tue, Nov 08, 2005 at 11:16:28AM CET, I got a letter
where Ben Clifford <benc@hawaga.org.uk> told me that...
> I've added some stuff to this to do a few cogito, gitk and (one) git  
> completions, split into different files. I thought I might as well  
> toss what I have out for anyone interested to play with.
> 
> I tried to put it in a new git repo online, but I'm having  
> difficulties - the poor link I'm on makes it not so much fun to  
> experiment. So I've tarred up my local repo warts and all and put it at:
> 
> http://www.hawaga.org.uk/ben/tech/gitcompletion- 
> a108bdc110dad770ec5c092759a8bc511790d21f.tar

Nice, I would like to add cg completion to Cogito's contrib/ - could you
please add some header to it with (c) information and stuff? (And make
it available somewhere just as a plain file.)

Besides, it would be probably best to just autogenerate the
auto-completion code - the usage information in Cogito is supposed to be
100% consistent and correct, so it should be a reliable source for that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
