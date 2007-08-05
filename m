From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 11:54:51 +0200
Message-ID: <85abt6b91w.fsf@lola.goethe.zz>
References: <200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<20070805094247.GE12507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcpI-0008S9-AS
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbXHEJzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbXHEJzE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:55:04 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:51521 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753707AbXHEJzB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 05:55:01 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 4157324B7B4;
	Sun,  5 Aug 2007 11:55:00 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 2D1D223D303;
	Sun,  5 Aug 2007 11:55:00 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 5F1373425EC;
	Sun,  5 Aug 2007 11:54:59 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 875E41C4F932; Sun,  5 Aug 2007 11:54:51 +0200 (CEST)
In-Reply-To: <20070805094247.GE12507@coredump.intra.peff.net> (Jeff King's message of "Sun\, 5 Aug 2007 05\:42\:47 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3858/Sun Aug  5 09:40:13 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54980>

Jeff King <peff@peff.net> writes:

> On Sat, Aug 04, 2007 at 07:49:36PM +0200, David Kastrup wrote:
>
>> I can specify something like
>> 
>> (info "(gcc) Extended Asm")
>> 
>> and when you are reading mail in Emacs, you can click on that line
>> and get to the respective page in a manual comprising hundreds of
>> pages.
>
> Ugh. A documentation referencing system that works only in one
> particular editor,

That works in readers of the info format.  Do HTML references work
outside of HTML readers?

> or with one particular documentation format?
>
> Please, the net decided on a standard for referencing resources long
> ago, and they are called URLs.

The last time I looked, URLs were not a common way to implement
bookmarks except in HTML, namely "with one particular documentation
format".

And you don't need an HTML reader to use those "resources" in HTML?
Get real.

Anyway, the referencing in _Texinfo_ gets translated into info
references in info formats, URL bookmarks in HTML, PDF links in PDF
and a textual description (since you can't let a URL point into a
section of a plain text file) in plain text output.  All those are
_common_ ways of making references, and certainly "the net" has not
decided to pick any of those exclusively.

That the particular format "info" _also_ is able to represent the
respective information originally written into _Texinfo_ source is
hardly a disadvantage.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
