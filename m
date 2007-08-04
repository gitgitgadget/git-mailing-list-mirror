From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 12:03:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com>
 <20070804091249.GA17821@uranus.ravnborg.org> <46B45B1E.5020104@midwinter.com>
 <85zm17h4pn.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
 <85myx7dwb3.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 21:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHOvw-0006iN-JV
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 21:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbXHDTEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765374AbXHDTEk
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 15:04:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47424 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765366AbXHDTEj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 15:04:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l74J3EMM014622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 12:03:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l74J38Sx006358;
	Sat, 4 Aug 2007 12:03:08 -0700
In-Reply-To: <85myx7dwb3.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54897>



On Sat, 4 Aug 2007, David Kastrup wrote:
> >
> > You must be kidding. Texinfo is the worst documentation format EVER.
> 
> Oh come on.  It was the first hyperlinked and hierarchical format
> before HTML even existed.

Yes. And it should have died after html took its place.

> Actually, a decade ago the Emacs-internal info reader was worse than
> it is now.

Wow. I've used the emacs one, and the stand-alone info one, and both are 
pretty horrid. You're saying that they used to be _worse_?

(Admittedly, my GNU emacs-fu is very weak. I use an emacs-like editor, but 
it's just an editor, and it's subtly different, so I actually find the 
"real" emacs to be really disturbing on so many levels ;)

> [ structure ]
>
> And as opposed to AsciiDoc, there _are_ readers that make use of this
> information.

None that any normal user would want to use. 

The thing is, html does a much better job of all of that, simply because 
there are useful readers. The same, btw, goes for man-pages: even though 
they have no structure at all, just the fact that normal people know how 
to use them, they are actually superior to info pages!

That's something that the FSF seems to have missed in their push for info 
format: a lot of FSF programs have really substandard man-pages, but that 
doesn't mean that people read the info ones _anyway_. Because the readers 
are so disgustingly horrible, plain man-pages are actually much more 
useful, despite the fact that they don't have any cross-referencing etc.

		Linus
