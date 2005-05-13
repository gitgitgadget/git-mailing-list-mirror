From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] update README and #include in git.txt
Date: Sat, 14 May 2005 00:57:57 +0200
Message-ID: <20050513225757.GH32232@pasky.ji.cz>
References: <4283CB19.3050208@dgreaves.com> <20050513221306.GB32232@pasky.ji.cz> <42852A44.7010806@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 01:14:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjM2-0006ZE-HW
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVEMXL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVEMW7f
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:59:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36489 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262613AbVEMW6B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:58:01 -0400
Received: (qmail 8326 invoked by uid 2001); 13 May 2005 22:57:57 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42852A44.7010806@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 12:29:24AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> >>Index: README
> >>===================================================================
> >>--- 3c79088f1832d78012ccdb63e5da1ab88fcf408e/README  (mode:100644)
> >>+++ e0e578bb02a7d8db1c105fddf5b5168ad0c79088/README  (mode:100644)
> >>@@ -1,9 +1,13 @@
> >>+////////////////////////////////////////////////////////////////
> >>+	GIT - the stupid content tracker
> >>
> >>
> >>-
> >>-	GIT - the stupid content tracker
> >>+Note that this README is written in asciidoc format and is #include'd
> >>+in the git.txt docs
> >>
> >>
> >>+The rest of this README is #included in the git.txt file
> >>+////////////////////////////////////////////////////////////////
> >> "git" can mean anything, depending on your mood.
> >>
> >>  - random three-letter combination that is pronounceable, and not
> >>    
> >>
> >
> >I'd probably prefer this being much less prominent. Can it be rather at
> >the bottom of the file?
> >  
> >
> If you mean the header in the ///'s?
> yes - but I wanted editors to realise it is asciidoc so kept it at the top.

But it's called README, not EDITME. And I think it's cluttering for the
readers.

> >You're reintroducing the "typos" fixed before, apparently.
> >  
> >
> I didn't notice the i.e. vs ie - I'm not that bothered ;)

But there were other typo fixes there and the big reindenting won't show
up any further changes to the text. I don't want to lose them so I'm
concerned now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
