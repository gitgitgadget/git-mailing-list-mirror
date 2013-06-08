From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 12:40:19 -0500
Message-ID: <CAMP44s1pkNd1NBM_q8Hb71jDOMXrX7_szQvNudGafYYQpdBt0Q@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
	<CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
	<CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
	<CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
	<CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
	<CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
	<20130608171513.GA28029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:40:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlN7s-0000ou-Hc
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab3FHRkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 13:40:22 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36306 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3FHRkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:40:21 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so4144331lbv.27
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AtRWP7aTRwqX6a3t7UFeh4zgEdGAKs0cZ0FGfYL0e9A=;
        b=gQqicRjovJIFrL7wPyyQ8LtiigqENaGnlCbSvVWzEosKkUP+QflSuceTbR4DxqJjXz
         fUa4LWij5c/okvLhr4HsSmknxtgohH3NvGJ1QNXWpOWAiOLhgLKZo/ycoa7cngtcUfhY
         THj+QsRuVcuOog9q+TVWWM3la0qSwrKhK+yGPEiAZzv3C0RsO3Q5Lt3NAyqNg4dBfnUf
         smDnAkN5JMGUTNLXO23jMJ01ruh0vSxjYTck30kJ8WFX1pugviV1joQOPZ2Ypkianqtv
         a12pkRS1wbs6KhLAJrXFqUbRvXdY7Z7SfqVNsC7wAs0sdBxOXdF5BTACs88bxCsIukNz
         Uc2Q==
X-Received: by 10.152.27.170 with SMTP id u10mr1699253lag.45.1370713220015;
 Sat, 08 Jun 2013 10:40:20 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 10:40:19 -0700 (PDT)
In-Reply-To: <20130608171513.GA28029@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226848>

On Sat, Jun 8, 2013 at 12:15 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 08, 2013 at 08:20:28AM -0500, Felipe Contreras wrote:
>
>> > There are a lot of static variables in builtin/ (and outside too),
>> > which make it non-entrant, or at least not safe.
>>
>> So?
>>
>> > fork provides a process space isolation, some depend on that.
>>
>> Process space isolation from what?
>
> Manipulation of global variables. Here are a few examples off the top of
> my head:
>
> Try running "git diff" from your Ruby hook, then try running "git
> diff-files" within the same process. I believe the latter will start
> respecting porcelain diff config like diff.mnemonicprefix. To clear
> state you need to reset a list of global variables back to their initial
> states (some of which are the BSS-default zero, but some of which are
> not).
>
> Try running "git log" followed by another "git log". The log family of
> commands does not clear its marks from the commit objects, since it
> expects to exit after the traversal. The second log will sometimes give
> wrong answers if its traversal overlaps with the first (e.g., commits
> marked SEEN or UNINTERESTING that should not be). You can add a call to
> clear them at the end of the process, but that does not cover any cases
> where we die().
>
> These are problems that can be solved. But there is a lot of work
> involved in finding these subtle bugs and coming up with fixes. I think
> you would be better off working on an implementation of git that was
> designed from scratch to work in-process, like libgit2.

So you are in favor of never ever having an official Git library. Got it.

> libgit2 doesn't have feature parity with regular git yet, but there are
> many clients based around it that use the library internally for speed,
> and then exec regular git to fill in the gaps.

There's a reason why the Git project doesn't use libgit2, and for the
same reason the official Ruby scripts should not use it.

As history indicates, the Git project will never have any pressure to
fix it's re-entrancy and re-run issues, so these issues will remain
there forever.

Only if you allow code that exposes those issues will there ever be
any pressure to fix them.

-- 
Felipe Contreras
