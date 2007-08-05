From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 21:06:06 +0200
Message-ID: <85y7gphkdd.fsf@lola.goethe.zz>
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
	<85bqdmctcl.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org>
	<85bqdlj1lh.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708051118590.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHlQc-0005he-Qv
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbXHETGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbXHETGK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:06:10 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:47335 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752907AbXHETGI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 15:06:08 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 65CAB326706;
	Sun,  5 Aug 2007 21:06:07 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 4F12D1143BA;
	Sun,  5 Aug 2007 21:06:07 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 212833027E4;
	Sun,  5 Aug 2007 21:06:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8ABBC1C3D500; Sun,  5 Aug 2007 21:06:06 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708051118590.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 5 Aug 2007 11\:23\:00 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3864/Sun Aug  5 19:21:44 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55055>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 5 Aug 2007, David Kastrup wrote:
>> 
>> You are still unable to focus on anything but name-calling and editors
>> rather than documentation formats.
>
> No, it's the same thing.
>
> I started out by saying that Texinfo is horrible. It's horrible
> because it doesn't *buy* you anything.

No, that's not what makes it horrible.

> The only thing it buys you (the "info" format) is totally
> irrelevant, which I tried to explain.

By calling everybody names that would dare using it.  That's not
really an explanation.

> AsciiDoc is much nicer. It does everything that Texinfo does for us,
> and it's readable on its own as plain text, something Texinfo isn't.

Readable plain text can be generated from Texinfo, so that is a red
herring.

> So by advocating Texinfo, you're advocating something that is
> OBJECTIVELY WORSE than what we have now.
>
> And I tried to explain why, by pointing out that info files (which
> was the case you tried to push as an advantage) aren't actually an
> advantage to any normal user.

Linus, your "normal user" does not get any documentation that can
usefully be employed for navigating a large body of documentation.

Anyway, this particular flame feast might be somewhat irrelevant: I
have read up a bit on AsciiDoc and Docbook, and it would appear that
quite a lot of what is needed for putting the required information for
indexes and nodes and other structural information is there in both
formats, and there is a tool called docbook2X that can presumably
convert to Texinfo (currently it barfs on the usermanual).  So
basically a lot can be achieved by structuring the existing
documentation into book form in AsciiDoc and peppering it with
indexing (apparently only a single index is possible) and other
structural information.

This will make the AsciiDoc sources less readable, while improving the
structural information content of the generated output, presumably
also when not going via Texinfo conversion.

Restructuring the available documentation into something that _can_ be
used as a coherent book, whether as a single PDF, single or multiple
HTML pages or even (avaunt!) info is probably not too horrible a
long-term prospect, and if info gives you the heebies, just don't call
"make info install-info", and you'll never get contaminated with it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
