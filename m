Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770661FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 10:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdBIKRE (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 05:17:04 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:47420 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdBIKRD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 05:17:03 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id B9EF3C47D;
        Thu,  9 Feb 2017 11:15:58 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id B21A3100C09;
        Thu,  9 Feb 2017 11:15:58 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id B736760339;
        Thu,  9 Feb 2017 10:32:54 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
References: <vpq1svtstud.fsf@anie.imag.fr>
        <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
        <vpq37fowx5q.fsf@anie.imag.fr>
        <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
Date:   Thu, 09 Feb 2017 11:15:58 +0100
In-Reply-To: <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
        (Christian Couder's message of "Thu, 9 Feb 2017 10:42:14 +0100")
Message-ID: <vpqzihvpt41.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Feb 8, 2017 at 3:54 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Mon, Jan 23, 2017 at 04:02:02PM +0100, Matthieu Moy wrote:
>>>
>>>> * We need to write the application, i.e. essentially polish and update
>>>>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
>>>>   update the list of project ideas and microprojects :
>>>>   https://git.github.io/SoC-2017-Ideas/
>>>>   https://git.github.io/SoC-2016-Microprojects/
>>>
>>> That can be done incrementally by people who care (especially mentors)
>>> over the next week or so, and doesn't require any real admin
>>> coordination. If it happens and the result looks good, then the
>>> application process is pretty straightforward.
>>>
>>> If it doesn't, then we probably ought not to participate in GSoC.
>>
>> OK, it seems the last message did not raise a lot of enthousiasm (unless
>> I missed some off-list discussion at Git-Merge?).
>
> I think having 2 possible mentors or co-mentors still shows some
> enthousiasm even if I agree it's unfortunate there is not more
> enthousiasm.

A non-quoted but yet important part of my initial email was:

| So, as much as possible, I'd like to avoid being an org admin this
| year. It's not a lot of work (much, much less than being a mentor!),
| but if I manage to get some time to work for Git, I'd rather do that
| on coding and reviewing this year.

and for now, no one stepped in to admin.

Other non-negligible sources of work are reviewing microprojects and
applications. Having a few more messages in this thread would have been
a good hint that we had volunteers to do that.

> Someone steps in to do what exactly?

First we need an admin. Then as you said a bit of janitoring work on
the web pages.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
