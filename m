From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 15:24:44 -0500
Message-ID: <CAMP44s2FaoL5T+eG9mKua1U5PN9SURtXOE_YE8WO8cUusf=mBw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	<7vd2ryueuu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
	<7vsj0tsnjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3DO-0006Sa-PH
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab3FGUYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:24:46 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52753 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab3FGUYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:24:45 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so173298lbc.31
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UWeaIbeOcfgwba/5t+e2jI7dKiTacKwgbjjwb/wCROI=;
        b=U12SMukLYW05nt1/8NaAUxjgNymVSnSvqizIe0EOuZoDZ2MEPna8mzwDqNXyXTHVx8
         fxNJsyLMuaO0gahS29MzLthTCXzchyzkgan+iGXSukY0QQQlxsHGAONFM3o0rJXoXB5P
         J9YsIp10Uc7iRNgKiKmPrufBuLeSSYQwWb5HxQ9D9ZERq2AIXqQE8wP2Q8eDKNLGI9cy
         9fA0szAnoTw9kZ9Fn5qkK4ukkaAVTghTlUj0xiScO3VAih1v2bQ+vzw3g9t6SViXxlBW
         3pHZe/NoZO/iedyuF+i7BSsWswEqSVJr7uo7w0Ts4xvsZyyvM0UuYJJLBr7nIGQgg7sD
         wR+g==
X-Received: by 10.112.157.226 with SMTP id wp2mr1908494lbb.65.1370636684472;
 Fri, 07 Jun 2013 13:24:44 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 13:24:44 -0700 (PDT)
In-Reply-To: <7vsj0tsnjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226695>

On Fri, Jun 7, 2013 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I think we heard enough from packaging folks that a new dependency
>>> is unwelcome.
>>
>> What are you talking about? Which are these "packaging folks" we heard from?
>
> Dscho is one of the primary people behind msysgit effort, and I
> consulted with others from the circle with an draft before I sent
> the message to the list for sanity checking (fearing that I may be
> worrying about adding new dependencies needlessly).

He said he won't do it, but I said I would. Doesn't that solve the problem?

> Jonathan
> packages git for Debian and he is negative on adding new dependency
> needlessly.

I don't see any comment from Jonathan.

> It was unexpected that we hear from a pkgsrc person but
> the response was also negative.

You mean Greg Troxel? He is only one of the persons that help, and I
did shut down his argument, didn't I?

>>> Also we heard from no regular/high-value reviewers
>>> that they feel comfortable reviewing additions in Ruby.
>>
>> Correction; *current* regular/high-value reviewers.
>
> That is exactly what I meant.
>
> The code review is not only about following best practices in the
> implementation language.  If somebody who is an expert in a language
> we do not currently depend on, but who does not know how the parts
> of Git are supposed to fit together enough to judge the soundness of
> the design of new code written in that new language, or does not
> know how the tests, documentation and log messages are supposed to
> written around here, that person cannot be the only reviewer for
> changes written in that language to ensure quality standard.
>
> The reviewer pool for code written in a new language _must_ be
> seeded by some from the current set of reviewers whose judgement
> I/we can trust.

By that standard nothing will ever change. Ever.

Even twenty years from now, you will still only trust people that are
familiar with shell, Perl, and C. Because the only way to gain your
trust, is by being proficient in shell, Perl, and C.

-- 
Felipe Contreras
