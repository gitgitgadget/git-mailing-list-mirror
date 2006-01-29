From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Mon, 30 Jan 2006 09:29:53 +1300
Message-ID: <46a038f90601291229u3d357b7ci98109656e432e891@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	 <20060129183731.GE19685@redhat.com>
	 <Pine.LNX.4.64.0601291438251.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dave Jones <davej@redhat.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 21:30:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3JBQ-0003Ih-GI
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWA2U36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWA2U35
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:29:57 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:29889 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751168AbWA2U35 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:29:57 -0500
Received: by wproxy.gmail.com with SMTP id 57so931044wri
        for <git@vger.kernel.org>; Sun, 29 Jan 2006 12:29:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tr0lox2JpLAsF4NyPVRz3ztrSw9VykQ00Iq6T11SP9oX0MGENwKN15YAA/Eu760W5zfcpDzV4nPzD0QElMCDiHdRiDCtglOAx3pCRyo/1xzths7wJxh/EhCBXXcQ1K8wsI2lcQiMUcGSCU/r655NmhucGEYqDXXMQk94iwNjQEg=
Received: by 10.54.127.3 with SMTP id z3mr6862570wrc;
        Sun, 29 Jan 2006 12:29:53 -0800 (PST)
Received: by 10.54.70.12 with HTTP; Sun, 29 Jan 2006 12:29:53 -0800 (PST)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601291438251.25300@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15243>

On 1/30/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > There's also another git usage that I doubt I'm alone in doing.
> > I regularly use git to import cvs trees from sourceforge etc for
> > random projects, because I now find browsing history of projects
> > with tools like gitk much nicer than any cvs tool I've used.
> > (cvs annotate is the only thing I really miss).
>
> I think this is the real driving factor for git adoption: it doesn't have
> to be 10x better for people to use it, because individuals can use it for
> interacting with CVS projects without causing anybody else any pain.

IMHO, this is a killer feature of GIT. From a CVS/SVN user point of
view, it has vendor branches done right. At work, we do that with
Moodle, Elgg, EPrints and GForge. And the list is growing. That's why
I'm working on the toolchain to make interop with CVS smooth so I can
land patches in  upstream projects where I have cvs access.

cheers,


m
