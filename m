Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA01DC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 23:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EE66023E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 23:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbhJOXbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 19:31:50 -0400
Received: from defaultvalue.org ([45.33.119.55]:55984 "EHLO defaultvalue.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239000AbhJOXbt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 19:31:49 -0400
Received: from trouble.defaultvalue.org (localhost [127.0.0.1])
        (Authenticated sender: rlb@defaultvalue.org)
        by defaultvalue.org (Postfix) with ESMTPSA id 22300200FB;
        Fri, 15 Oct 2021 18:29:12 -0500 (CDT)
Received: by trouble.defaultvalue.org (Postfix, from userid 1000)
        id B651014E081; Fri, 15 Oct 2021 18:29:11 -0500 (CDT)
From:   Rob Browning <rlb@defaultvalue.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: explain and illustrate multi-line
 headers
In-Reply-To: <xmqqa6ja9t54.fsf@gitster.g>
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
 <YWRpPw4eTwTmgVvC@coredump.intra.peff.net> <xmqq4k9ncopr.fsf@gitster.g>
 <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net> <xmqqzgre5glb.fsf@gitster.g>
 <xmqqtuhlisqe.fsf_-_@gitster.g> <87zgrcgpez.fsf@trouble.defaultvalue.org>
 <xmqq5ytzcyr6.fsf@gitster.g> <87v91zgjr9.fsf@trouble.defaultvalue.org>
 <xmqqa6ja9t54.fsf@gitster.g>
Date:   Fri, 15 Oct 2021 18:29:11 -0500
Message-ID: <87sfx1hnp4.fsf@trouble.defaultvalue.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rob Browning <rlb@defaultvalue.org> writes:
>
>> Agreed.  I'd just lazily guessed it might be 822 (was also thinking of
>> ...
>> Ahh, right, of course.
>> ...
>> Indeed.
>>
>> Thanks
>
> So, back to the original discussion; would the replacement
> documentation update be satisfactory?

Certainly, and thanks.

-- 
Rob Browning
rlb @defaultvalue.org and @debian.org
GPG as of 2011-07-10 E6A9 DA3C C9FD 1FF8 C676 D2C4 C0F0 39E9 ED1B 597A
GPG as of 2002-11-03 14DD 432F AE39 534D B592 F9A0 25C8 D377 8C7E 73A4
