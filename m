From: Petr Baudis <pasky@suse.cz>
Subject: Re: contrib/ area
Date: Tue, 21 Feb 2006 08:43:32 +0100
Message-ID: <20060221074332.GK9573@pasky.or.cz>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net> <Pine.OSX.4.64.0602201737260.16179@piva.hawaga.org.uk> <7v64n95pnm.fsf@assigned-by-dhcp.cox.net> <b7bc5ebe0602202110l53418b32q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 08:43:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBSBB-0001MA-AZ
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 08:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWBUHnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 02:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBUHnT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 02:43:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16022 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750889AbWBUHnS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 02:43:18 -0500
Received: (qmail 23134 invoked by uid 2001); 21 Feb 2006 08:43:32 +0100
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <b7bc5ebe0602202110l53418b32q@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16521>

Dear diary, on Tue, Feb 21, 2006 at 06:10:05AM CET, I got a letter
where Ben Clifford <benc@hawaga.org.uk> said that...
> > As a practice for doing "even cooler merge", I did the
> > following, to see if I can treat it just like I treat gitk.
> 
> neat.
> 
> one thing that bothers me a bit about that is that the cogito code
> then ends up in both the git and cogito repositories (actually the way
> its done manually for cogito contrib/ at the moment bothers me
> anyway).

Well, in the long term, Jonas is working on a bash completion generated
automagically from the cg sources (anything maintained externally is bad
'coz it gets out of sync, mm'kay? ;).

In the short term, I can just accept patches from you - they do not even
need to get the filenames right, I can rewrite that.  You see, I don't
have the cool recursive merge strategy so merging into a subdirectory is
painful (and that bothers me too; we'll see yet).

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
