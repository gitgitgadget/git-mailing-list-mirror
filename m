From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 5 Aug 2007 12:29:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708051221290.5037@woody.linux-foundation.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com>
 <20070804091249.GA17821@uranus.ravnborg.org> <46B45B1E.5020104@midwinter.com>
 <85zm17h4pn.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
 <85myx7dwb3.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
 <85bqdndqgr.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org>
 <85bqdmctcl.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org>
 <85bqdlj1lh.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHloC-0002nU-NT
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbXHETae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbXHETae
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:30:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43505 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755976AbXHETad (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 15:30:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75JTFCl004624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 12:29:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75JT9sp022515;
	Sun, 5 Aug 2007 12:29:09 -0700
In-Reply-To: <85bqdlj1lh.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55059>



On Sun, 5 Aug 2007, David Kastrup wrote:
>
> > The fact that you cannot see that fact is a sign of your personal
> > (and rather odd) preferences.
> 
> Yes, name-calling and ad hominem attacks again.

No. Emacs _is_ odd. It's not even installed by default on most modern 
Linux distributions.

There's no name-calling there. That's just a solid fact. You are 
emacs-fixated when you keep on trying to bring up totally irrelevant 
emacs issues.

> Please try to remember that Texinfo is a _source_ format, and it
> produces reasonably hyperrefed and coherent PDF and HTML documents as
> well as plain ASCII.  That it is also able to produce working info
> files should not bother you.

You do not even know what you are talking about.

AsciiDoc is *also* a source format. But the source format is already 
readable IN ITSELF. Which is the whole point!

I don't even bother to run "make doc".  I bet that is true of almost 
everybody else too. Why? Because the *source* format we use (asciidoc) is 
already basically as readable as any formatted man-page would ever be.

You don't have to even *know* that they are AsciiDoc pages - they're just 
called "*.txt", and that's what they are. Text. With very minimal fixups 
that *allow* them to be used as source for things like html, and 
admittedly you get prettier output, but it really is perfectly 
straightforward to just read them, in ways that pretty much no other 
documentation format allows. Everybody else puts very intrusive crap in 
there, so that you *have* to be aware of in ways you don't need to worry 
about in AsciiDoc.

Headers? Lists? They look like headers and lists in the .txt files. No 
need to think about it as a reader. 

See? Texinfo is decidedly inferior. But you don't have to take it so 
personally. So is pretty much anything else. Anything XML/SGML is even 
*worse*.

			Linus
