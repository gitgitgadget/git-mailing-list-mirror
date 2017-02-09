Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69321FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 12:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdBIMNJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 07:13:09 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:57540 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdBIMMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 07:12:45 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 66353C537;
        Thu,  9 Feb 2017 13:11:15 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 5FF96100209;
        Thu,  9 Feb 2017 13:11:15 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 64BB060388;
        Thu,  9 Feb 2017 12:28:11 +0100 (CET)
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
        <vpqzihvpt41.fsf@anie.imag.fr>
        <CAP8UFD1V=WD-EHkBkAVET9ztvsHZr_S5GVBWrQ6F1e0LwJoksQ@mail.gmail.com>
Date:   Thu, 09 Feb 2017 13:11:15 +0100
In-Reply-To: <CAP8UFD1V=WD-EHkBkAVET9ztvsHZr_S5GVBWrQ6F1e0LwJoksQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 9 Feb 2017 11:45:45 +0100")
Message-ID: <vpqlgtfmun0.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Well Peff wrote in reply to your email:
>
>> I did co-admin last year and the year before, but I made Matthieu do all
>> the work. :)
>>
>> I do not mind doing the administrative stuff. But the real work is in
>> polishing up the ideas list and microprojects page.
>
> So I thought Peff would be ok to be the admin (do "the administrative
> stuff").

There are several things the admins need to do:

1) "administrative stuff" about money with Conservancy (aka SFC). As I
   understand it, really not much to do since Google and Conservancy
   work directly with each other for most stuff.

2) Filling-in the application, i.e. essentially copy-past from the
   website.
 
3) Then, make sure things that must happen do happen (reviewing
   applications, start online or offline discussions when needed, ...).

Last year Peff did 1) and I did most of 2+3). My understanding of Peff's
reply was "OK to continue doing 1)".

I think you (Christian) could do 2+3). It's much, much less work than
being a mentor. Honnestly I felt like I did nothing and then Peff said I
did all the work :o). I can help, but as I said I'm really short in time
budget and I'd like to spend it more on coding+reviewing.

> I don't think emails in this thread is what really counts.
> I worked on the Idea page starting some months ago, and as I wrote I
> reviewed it again and found it not too bad.

OK, so giving up now seems unfair to you indeed.

I created a Git organization and invited you + Peff as admins. I'll
start cut-and-pasting to show my good faith ;-).

> About the janitoring part, as I previously said I am reluctant to do
> that as I don't know what Dscho would be ok to mentor.
> And I also think it's not absolutely necessary to do it before
> applying as an org.

Right.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
