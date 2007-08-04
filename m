From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 21:55:48 +0200
Message-ID: <85bqdndqgr.fsf@lola.goethe.zz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 21:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHPjF-0001z4-6F
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 21:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765389AbXHDTz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765360AbXHDTz4
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 15:55:56 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:56606 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762795AbXHDTzz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 15:55:55 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 46110183B5F;
	Sat,  4 Aug 2007 21:55:52 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 341961143B8;
	Sat,  4 Aug 2007 21:55:52 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id A33AF2351A6;
	Sat,  4 Aug 2007 21:55:51 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3C8F01C4F932; Sat,  4 Aug 2007 21:55:48 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 4 Aug 2007 12\:03\:08 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54899>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 4 Aug 2007, David Kastrup wrote:
>> >
>> > You must be kidding. Texinfo is the worst documentation format EVER.
>> 
>> Oh come on.  It was the first hyperlinked and hierarchical format
>> before HTML even existed.
>
> Yes. And it should have died after html took its place.

The problem is that html, not even now, offers useful standardized
structural navigation information, so no reader can offer keypresses
to follow the non-existing information.  I'd really like HTML to have
taken its place.  However, in spite of all the bloat of HTML
processors (firefox takes more memory than Emacs, and Emacs is my
bloody _desktop_), and in spite of it being orders of magnitude
slower, it does not offer this navigation.  It offers no cross-page
search facilities.

You can't navigate through the structure of the equivalent of hundreds
of printed pages in an HTML browser.  Not by navigating, not by plain
text searching.

I'll be all set to bury Texinfo once HTML has taken its place.
Unfortunately, it has taken a different place up to now.

>> Actually, a decade ago the Emacs-internal info reader was worse
>> than it is now.
>
> Wow. I've used the emacs one, and the stand-alone info one, and both
> are pretty horrid. You're saying that they used to be _worse_?

The standalone reader was rather horrid a few years ago: it used not
to know the normal page and cursor commands and beeped at quite a few
things.  It is quite better now.  Bit it is not Emacs.

> (Admittedly, my GNU emacs-fu is very weak. I use an emacs-like
> editor, but it's just an editor, and it's subtly different, so I
> actually find the "real" emacs to be really disturbing on so many
> levels ;)
>
>> [ structure ]
>>
>> And as opposed to AsciiDoc, there _are_ readers that make use of
>> this information.
>
> None that any normal user would want to use.

Linus, do you really think that the editor _you_ use is used by more
people than Emacs?  Think again.

Anyway, Emacs might, for all your polemics are worth, be an editor
that a "normal user" would not want to use: it has a tough learning
curve.  It has considerably flattened in recent years, and
particularly Emacs 22 is a big step forward, but no sane person would
use Emacs if there was anything else that sucked less.

There isn't.  And in spite of all your denial, there isn't for
Texinfo, either.  You can't do a plain text search through hundreds of
HTML pages.  You need a single page for that, and then navigation,
already bad in HTML, becomes absolutely horrid.

Your best bet nowadays might be a PDF reader with plain text search in
the document intended for printing.  Something which has a page layout
and fonts not suited for screen reading.

You can't usefully find your way through a hundreds-pages manual page.

> The thing is, html does a much better job of all of that, simply
> because there are useful readers.

But there aren't.  Not for documents of several hundred pages.  Not
until you download all of them and then do a grep on the flat files
when you are looking for some keyword anywhere in the whole bunch.

That is an amount of suckage that neither Emacs nor the info reader
could ever hope to replicate.

> The same, btw, goes for man-pages: even though they have no
> structure at all, just the fact that normal people know how to use
> them, they are actually superior to info pages!

For single pages, yes.  For hundreds of pages, this falls apart.  Man
pages don't scale.

> That's something that the FSF seems to have missed in their push for
> info format: a lot of FSF programs have really substandard
> man-pages, but that doesn't mean that people read the info ones
> _anyway_. Because the readers are so disgustingly horrible, plain
> man-pages are actually much more useful, despite the fact that they
> don't have any cross-referencing etc.

Again, you presume to know the rest of the world, and the rest of the
world is "normal" and just like you.

I will readily agree with you that for the longest time, reading info
files outside of Emacs was painful enough to make it mostly useless.
With the current standalone info reader, it is merely annoying.

And inside of Emacs (and using Emacs is not as much the equivalent of
doing appendectomy on yourself with a fork because there is no
_equivalent_ to do the same job, but has progressed to a reasonably
sharp knife), info has moved from "tolerable" to "quite usable" under
Emacs 22: you can easily search whole documents, single nodes,
chapters.  Pretty much everything is clickable by mouse (with mouse
button 1), including the structural information that _stays_ on top of
your window.

Anyway, like it or not, the current form of git documentation is not
structured, and that means that it is very hard to get the big
picture.  Texinfo might have readers that suck, but other formats
don't have readers doing the job at all when we are talking about
finding your way in a document of some hundred pages.  PDF at the
current point of time is about the closest you can come, and it is
print-oriented and slow.  And it certainly does not offer something
like typing
i assembl RET
in order to jump through the index at the first page referring to
assembly language.

Like with TeX itself, the scandal is not that decade-old technology is
still in use, but rather that nobody has replaced it with anything
actually doing the same job, in spite of all the information being
freely available and in spite of the old technology being really
arcane.

Find me an HTML reader that allows keypress-based structured
navigation through documents of a few hundred pages, and _then_ talk
about Texinfo being supplanted.

Heck, _nobody_ likes Texinfo, including myself.  It is a stupid format
and not remarkably fun to write or understand.  It is just that there
are no bloody tools doing the same job.  After all these years, and in
spite of a really terrible standalone reader for the longest time.

I can perfectly well understand your lack of enthusiasm.  And feel
free to call me and the FSF and info and who- and whatever else any
name you like (you won't be able to refrain anyhow).  But the fact
remains that the best way to find some information in the current git
documentation is not using HTML.  It is not using man, unless you
already know what you are looking for.

No, currently the _only_ viable search interface into git's
documentation as a whole consists of grep and less.

And for your favorite "normal user" scapegoat, that sucks even worse
than the standalone info reader, let alone Emacs.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
