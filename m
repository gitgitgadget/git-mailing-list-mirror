Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0866C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86825221FE
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 15:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKUPx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 10:53:59 -0500
Received: from vps.thesusis.net ([34.202.238.73]:48004 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgKUPx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 10:53:59 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Nov 2020 10:53:58 EST
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id E5EA221B0B;
        Sat, 21 Nov 2020 10:46:46 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iVCZu8k3Vccq; Sat, 21 Nov 2020 10:46:46 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 9E29221B0A; Sat, 21 Nov 2020 10:46:46 -0500 (EST)
References: <CAMP44s08AzXt-+duXyFAvJpuke=XTKT=7cibxKKy4bXhAFqxtw@mail.gmail.com>
User-agent: mu4e 1.5.6; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>
Subject: Re: There is nothing wrong with the word "master"
In-reply-to: <CAMP44s08AzXt-+duXyFAvJpuke=XTKT=7cibxKKy4bXhAFqxtw@mail.gmail.com>
Date:   Sat, 21 Nov 2020 10:46:46 -0500
Message-ID: <87mtzavhjt.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Felipe Contreras writes:

> Hello,
>
> I want to state for the record my objection to the rename of the initial branch.
<snip>

I agree, and appreciate you taking the time to write a very well thought
out message.  Unfortunately I doubt that any of this matters to those
making the change.
