Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE651FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 14:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933159AbdBHOye (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 09:54:34 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:36249 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754292AbdBHOyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 09:54:33 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id DC01EC69D;
        Wed,  8 Feb 2017 15:54:25 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id D64CE100C84;
        Wed,  8 Feb 2017 15:54:25 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id DEDF060324;
        Wed,  8 Feb 2017 15:11:21 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        "Siddharth Kannan" <kannan.siddharth12@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
References: <vpq1svtstud.fsf@anie.imag.fr>
        <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
Date:   Wed, 08 Feb 2017 15:54:25 +0100
Message-ID: <vpq37fowx5q.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 23, 2017 at 04:02:02PM +0100, Matthieu Moy wrote:
>
>> * We need to write the application, i.e. essentially polish and update
>>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
>>   update the list of project ideas and microprojects :
>>   https://git.github.io/SoC-2017-Ideas/
>>   https://git.github.io/SoC-2016-Microprojects/
>
> That can be done incrementally by people who care (especially mentors)
> over the next week or so, and doesn't require any real admin
> coordination. If it happens and the result looks good, then the
> application process is pretty straightforward.
>
> If it doesn't, then we probably ought not to participate in GSoC.

OK, it seems the last message did not raise a lot of enthousiasm (unless
I missed some off-list discussion at Git-Merge?).

The application deadline is tomorrow. I think it's time to admit that we
won't participate this year, unless someone steps in really soon.

If we don't participate, I'll add a disclaimer at the top of the
SoC-related pages on git.github.io to make sure students don't waste
time preparing an application.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
