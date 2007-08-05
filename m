From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 09:51:06 +0200
Message-ID: <85bqdmctcl.fsf@lola.goethe.zz>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
	<85bqdndqgr.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 09:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHate-0003Iu-Lg
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbXHEHvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbXHEHvP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:51:15 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:34156 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753845AbXHEHvO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 03:51:14 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 6160531F383;
	Sun,  5 Aug 2007 09:51:13 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 45296ABAE0;
	Sun,  5 Aug 2007 09:51:13 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id D891E30A992;
	Sun,  5 Aug 2007 09:51:12 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7D7821C4F932; Sun,  5 Aug 2007 09:51:06 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 4 Aug 2007 21\:29\:26 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3857/Sun Aug  5 08:20:59 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54963>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 4 Aug 2007, David Kastrup wrote:
>> >
>> > None that any normal user would want to use.
>> 
>> Linus, do you really think that the editor _you_ use is used by more
>> people than Emacs?  Think again.
>
> No.
>
> But I'm also not confused enough to think that people should use 
> micro-emacs for reading man-pages.

Could you refrain from using name-calling on everybody that does not
share your preferences?  It is annoying to hear you talk all the time
about "normal", "sane", "confused" and so on.

> The UNIX philosophy is "do one thing, and do it well".

And Emacs does text, and does it well.  It is just that very much
information can ultimately be viewed as text.  For example, I can run
grep or locate inside of Emacs.  Nothing exciting.  And then I can
click on the lines those put out, and get moved to the corresponding
line in the source code, in my editor.  Again, nothing exciting, but
it does not work with disconnected tools without the glue Emacs
provides.  There are other IDEs providing that sort of thing, but
usually they work just with output they produced themselves.

Using Emacs to read man-pages means that I can grab manpage content
easily with my accustomed editing commands and paste them into a mail
I am composing.  Without having to use a mouse or GUI.

It enables workflows that are not possible outside of it.  It is ok if
you don't find the tradeoff appealing, but that does not make you
"normal" and other people "confused" and "insane".

So please get a grip and focus on what we were actually talking
about.  Not Emacs, but rather documentation formats.

> Man-pages with man.

Actually, Emacs "woman" does a pretty good job with those, offers
convenient man page name completion and works on Windows and similar
platforms without needing

> html with a web browser. And edit stuff with an editor.
>
> Why the *hell* do you confuse my choice of editor with my choice of
> man-page format? I didn't.

Why the hell do you keep changing the topic and go off on sideline
rants.

> That whole "do everything in emacs" is a disease. And then emacs
> users think that it's "sane".

Focus.  How do you propose to manage documention of a hundred pages an
more conveniently, finding information easily by text, index,
hyperlinks?  A single large HTML page?  A documentation directory full
of *.txt files which you can grep through (not that Emacs would not be
useful for that, too)?

How do you find all information pertaining to "remote tracking
branches" in the git documentation?  Explain your workflow with that,
and explain why a sane person would prefer that over typing
info git
i remote TAB RET , , ,
and being taken to the respective text locations in turn.

Standalone info _is_ a single application doing a single job:
navigating large hyperlinked plain text documentation efficiently.  It
may be an _ugly_ application, but instead of saying what you use
instead in your daily workflow, you revert to name-calling.

If you have a _working_ solution to offer for that task, try
presenting it instead of calling people using other tools names.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
