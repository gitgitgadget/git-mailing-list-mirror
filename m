From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 14:04:11 -0500
Message-ID: <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	<7vd2ryueuu.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 07 21:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1xR-0001gz-UC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab3FGTEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:04:14 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:47237 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3FGTEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:04:13 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so3983935lab.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M9B249znzGMO+Nq98Sa8rtv02vcV3fJjDRtc7Toz+IM=;
        b=ZFH3ZOZ34FfaJXlCDixdBRB/tu/OXhmg/dZ9hX3nStcFA7zOD+WnRTQjDO6qN1aZeW
         bABlr+IxcxnTHTBD3nRJYMh4y9G+EyNZD+XpMpA0hpSIyoDHYh9urHo5ZGuqEcqhD87g
         18Mj/qV9N+zJGirIjgBA7030LQytCiQZfj4Ls6LGAI0KsmAwMReej7Ih8n8SOJHdA8Vf
         7CYwWb9EbKVrr8vMa6TO4I01O9IvZ7qIW5tv7JltJx6BZZ0av7hDU/vjiFgF5m+fNSKd
         g8zgC1B7MAqEvVI0H53NFzancWYMvDDOXfsqkRl4aroeMvSnbvowIvsxO/L9QYzRqarY
         fBmg==
X-Received: by 10.152.27.102 with SMTP id s6mr19190lag.47.1370631851597; Fri,
 07 Jun 2013 12:04:11 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:04:11 -0700 (PDT)
In-Reply-To: <7vd2ryueuu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226674>

On Fri, Jun 7, 2013 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> I think Felipe is using the argument that perl is declining to answer
>> the question "why didn't you write git-related in perl instead?";
>> that's it.
>
> A question which nobody asked, I presume?
>
> I think we heard enough from packaging folks that a new dependency
> is unwelcome.

What are you talking about? Which are these "packaging folks" we heard from?

> Also we heard from no regular/high-value reviewers
> that they feel comfortable reviewing additions in Ruby.

Correction; *current* regular/high-value reviewers.

> So at least for now, the conclusion is to take approach #1, i.e.
> somebody who finds "related" a good addition rewrites it in Perl to
> promote it out of contrib/ once the design issues settle (of course
> it is still a possibility that no such volunteer appears).

Regardless of what you conclude, Perl still continues to die, and by
clinging to a dying language, all we do is hurt the project.

There's tons of people that are familiar with Git and Ruby, but these
people are not in this mailing list because there's nothing for them
to discuss, because Git doesn't use Ruby. By making conclusions based
on the comments from people who do follow the mailing list
*currently*, you are being biased towards the status quo.

It's no surprise that you decided to keep the status quo.

We could change, and we would probably receive a big influx of fresh
contributors happy that they can contribute in their favorite
language. But we won't do that, why? Because you already decided
that's not going to happen, because you are making the false
assumption that things in the future can only be like things have been
in the past.

-- 
Felipe Contreras
