Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D4C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC5F613AC
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFISof (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:44:35 -0400
Received: from vps.thesusis.net ([34.202.238.73]:39750 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhFISoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 14:44:34 -0400
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 4E5FE2FAFF; Wed,  9 Jun 2021 14:42:09 -0400 (EDT)
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <60be7adcdf3b_db9162081e@natae.notmuch>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Date:   Wed, 09 Jun 2021 14:29:35 -0400
In-reply-to: <60be7adcdf3b_db9162081e@natae.notmuch>
Message-ID: <87fsxq98xq.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Felipe Contreras <felipe.contreras@gmail.com> writes:

> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> 
>> Technical writing seeks to convey information with minimal friction. One
>> way that a reader can experience friction is if they encounter a
>> description of "a user" that is later simplified using a gendered
>> pronoun. If the reader does not consider that pronoun to apply to them,
>> then they can experience cognitive dissonance that removes focus from
>> the information.

Why should the pronoun apply to the reader?  If the documentation wants
to refer to the reader, it should use "you".  If it's using "he" then
it's referring to someone else previously mentioned in the
documentation, not to me.  Just because I am male does not mean I suffer
from confusion when I read documentation like: "Alice wants to
communicate with others securely.  She can do that by using gpg."

> But it's not part of standard English language.

<snip>

> You can use "nucular" if you want (many people do). I will use
> "nuclear".

You can use "nucular", but you will look stupid.

> Both can be valid, and we shouldn't demand the use of one over the
> other.

Sure we can; one is not valid.  You also may not "axe" me a question, or
drink an "expresso".

Also you argued against using they because it is not standard English,
but then argued that it is fine to use non standard English.

