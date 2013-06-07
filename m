From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 00:57:33 +0530
Message-ID: <CALkWK0m4V4KYyKW8KJMRsCgOxqcLi0XDYZvS4w++6BKVVvioyw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz> <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
 <7vd2ryueuu.fsf@alter.siamese.dyndns.org> <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, David Lang <david@lang.hm>,
	Greg Troxel <gdt@ir.bbn.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
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
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2Kh-0006F7-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab3FGT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:28:15 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58940 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3FGT2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:28:14 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so4961858iea.18
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D4KYcyYoAMo5MWTDYtyFLmUVnesIFQPvOkzZv9aTcic=;
        b=YY1ULdePJS5c0gYD9QmxMjVBDqb7nONnvLGzBk1Z5qCsP7LhKGy/gBOxwQez8vYkmJ
         xGkdo4qXvQ/IYgo7vOmGzFD6A2YQENpbkrDNYjxF1srhKUliMLiX71C2drvhUKTKqd4D
         Y5apN0fIoFlH6Ku7p88Pj91AUydUio0TK51HbhR9q+HzHzEdhc+3I963ttaiIjjI+mhJ
         VKiOvMQO3sn81qWzMtKKqksc0HSXaZMghkJoEmm4yeuiwUrz9nK4EwnUE5pan/m0b7qm
         oN3aOkLOPHcey/ovKH4m+Ox+nSySrPOjcIM8aXLbAfZNYQXG4r9/hmHnSJRJq7hWS7i/
         MayQ==
X-Received: by 10.50.70.101 with SMTP id l5mr1894438igu.104.1370633293769;
 Fri, 07 Jun 2013 12:28:13 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 12:27:33 -0700 (PDT)
In-Reply-To: <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226681>

Felipe Contreras wrote:
>> Also we heard from no regular/high-value reviewers
>> that they feel comfortable reviewing additions in Ruby.
>
> Correction; *current* regular/high-value reviewers.

Correct.  The opinions of inactive community members and
non-contributors are less useful.

> We could change, and we would probably receive a big influx of fresh
> contributors happy that they can contribute in their favorite
> language. But we won't do that, why? Because you already decided
> that's not going to happen, because you are making the false
> assumption that things in the future can only be like things have been
> in the past.

Okay, so here's the deal: commit a lot of good ruby code to contrib*,
and attract users/ contributors.  Eventually, if you're right about
git.git growing a healthy ruby ecosystem, we'll get ruby in core.  As
I've said multiple times, this agenda-based approach just sucks,
because we can't predict the future.

* I'll help out in whatever little way I can
