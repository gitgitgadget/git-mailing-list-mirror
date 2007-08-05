From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 13:23:04 +0200
Message-ID: <85y7gq8btz.fsf@lola.goethe.zz>
References: <46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<20070805094247.GE12507@coredump.intra.peff.net>
	<85abt6b91w.fsf@lola.goethe.zz>
	<20070805095928.GA15949@coredump.intra.peff.net>
	<851weib7v3.fsf@lola.goethe.zz>
	<20070805102242.GA17000@coredump.intra.peff.net>
	<85ps229sck.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHeCd-0000x3-R3
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbXHELXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756005AbXHELXQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:23:16 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:43867 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755730AbXHELXP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 07:23:15 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 1677313620;
	Sun,  5 Aug 2007 13:23:14 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id F2304345C03;
	Sun,  5 Aug 2007 13:23:13 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id C61B9212F62;
	Sun,  5 Aug 2007 13:23:13 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D1C431C3D500; Sun,  5 Aug 2007 13:23:04 +0200 (CEST)
In-Reply-To: <85ps229sck.fsf@lola.goethe.zz> (David Kastrup's message of "Sun\, 05 Aug 2007 12\:40\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3859/Sun Aug  5 11:16:51 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54994>

David Kastrup <dak@gnu.org> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sun, Aug 05, 2007 at 12:20:32PM +0200, David Kastrup wrote:
>>
>>> Well, just for kicks I let firefox loose on
>>> 
>>> info:gcc#Extended Asm
>>
>> OK, I didn't know there was a URL style defined for info.
>
> Neither did I, actually.  If anybody would actually use them, I'd have
> to teach firefox to pass them off to Emacs.

The details can be found in <URL:man:uri(7)>.

If you find this syntax referring to a man page weird, you should
probably not complain about me writing (info "(gcc) Extended Asm") as
a reference.

When there are few readers of a format, it is easier to use a
"natural" spelling.

Anyway, I have seen in a posting about mathematics someone write an
equation including sqrt(3) and saw Emacs highlight this expression.
So I clicked on it.  And Emacs opened the man-page.  Definitely not
what I had expected...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
