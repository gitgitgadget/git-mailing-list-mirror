Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD1BC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49CC61246
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFIS6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:58:25 -0400
Received: from vps.thesusis.net ([34.202.238.73]:39768 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFIS6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 14:58:21 -0400
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 7F9532FB10; Wed,  9 Jun 2021 14:55:56 -0400 (EDT)
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <60be91757c6ca_db80d2086e@natae.notmuch>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Date:   Wed, 09 Jun 2021 14:47:02 -0400
In-reply-to: <60be91757c6ca_db80d2086e@natae.notmuch>
Message-ID: <87czsu98ar.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Felipe Contreras <felipe.contreras@gmail.com> writes:

> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
>>  . `Acked-by:` says that the person who is more familiar with the area
>>    the patch attempts to modify liked the patch.
>>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
>> -  reviewer and means that she is completely satisfied that the patch
>> +  reviewer and means that they are completely satisfied that the patch

Say wait a minute.  If that is a "singular they", then why was the "is"
changed to "are"?  I think that belies the fact that there is no such
thing as a "singular they".

