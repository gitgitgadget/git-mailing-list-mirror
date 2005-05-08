From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Commit template
Date: Sun, 8 May 2005 22:17:23 +0200
Message-ID: <20050508201723.GH9495@pasky.ji.cz>
References: <1965.10.10.10.24.1115579256.squirrel@linux1> <1115579764.8949.15.camel@pegasus> <2003.10.10.10.24.1115580031.squirrel@linux1> <1115580630.8949.27.camel@pegasus> <2095.10.10.10.24.1115582244.squirrel@linux1> <1115582601.8949.31.camel@pegasus> <2159.10.10.10.24.1115582791.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:14:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsAR-0001GB-9l
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVEHUTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVEHUTe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:19:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17117 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262961AbVEHURY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 16:17:24 -0400
Received: (qmail 22092 invoked by uid 2001); 8 May 2005 20:17:23 -0000
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <2159.10.10.10.24.1115582791.squirrel@linux1>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 10:06:31PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> told me that...
> On Sun, May 8, 2005 4:03 pm, Marcel Holtmann said:
> 
> > my argument is; not to mess up with the CG: lines created by cg-commit.
> > If you wanna insert a warning then you can of course add additional CG:
> > lines to the commit template.
> 
> Marcel,
> 
> Well, i'd argue that anyone making their own commit should be responsible
> for making it look however they like.  Maybe they want to only use only 60
> character wide lines and are tired of seeing the notice about CG: being
> ignored.  Gives the power user a tad more flexibility.   But I really
> don't care much either way.

I'm with Sean on this one - implemented (with current cg-commit, and I
used .git/commit-template file instead), committed, pushed out.

Sean, could you please sign off the patches you send to the mailing list
in the future?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
