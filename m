Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5561F403
	for <e@80x24.org>; Thu,  7 Jun 2018 23:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeFGXxZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 19:53:25 -0400
Received: from lang.hm ([66.167.227.134]:47082 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeFGXxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 19:53:25 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w57NrGt0025367;
        Thu, 7 Jun 2018 16:53:16 -0700
Date:   Thu, 7 Jun 2018 16:53:16 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
In-Reply-To: <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
Message-ID: <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
References: <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE> <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <20180607223442.GA5322@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz> <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Jun 2018, Peter Backes wrote:

> On Thu, Jun 07, 2018 at 03:38:49PM -0700, David Lang wrote:
>>> Again: The GDPR certainly allows you to keep a proof of copyright
>>> privately if you have it. However, it does not allow you to keep
>>> publishing it if someone exercises his right to be forgotten.
>> someone is granting the world the right to use the code and you are claiming
>> that the evidence that they have granted this right is illegal to have?
>
> Hell no! Please read what I wrote:
>
> - "allows you to keep a proof ... privately"
> - "However, it does not allow you to keep publishing it"
>
>> And you are incorrect to say that the GDPR lets you keep records privately
>> and only applies to publishing them. The GDPR is specifically targeted at
>> companies like Facebook and Google that want to keep lots of data privately.
>> It does no good to ask Facebook to not publish your info, they don't want to
>> publish it in the first place, they want to keep it internally and use it.
>
> How can you misunderstand so badly what I wrote.
>
> Sure the GDPR does not let you keep records privately at will. You
> ultimately need to have overriding legitimate grounds for doing so.
>
> However, overriding legitimate grounds for keeping private records are
> rarely overriding legitimate grounds for publishing them.

the license is granted to the world, so the world has an interest in it.

Unless you are going to argue that the GDPR outlawed open source development.

> In case of git history metadata, for publishing, you may have consent
> or even legitimate interests, but not overriding legitimate grounds.
> For keeping a private copy of the metadata, your probably have
> overriding legitimate grounds, however.
>
> The GDPR is not an "all or nothing" thing.
>
> Facebook and Google certainly do not have overriding legitimate grounds
> for most of the data they keep privately.
>
> Is it that so hard to understand?

you are the one arguing that the GDPR prohibits Git from storing and revealing 
this license granting data, not me.

David Lang
