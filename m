Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8028A1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 22:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeFGWjU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 18:39:20 -0400
Received: from lang.hm ([66.167.227.134]:49380 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbeFGWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 18:39:19 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w57Mcn5J024934;
        Thu, 7 Jun 2018 15:38:49 -0700
Date:   Thu, 7 Jun 2018 15:38:49 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
In-Reply-To: <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
Message-ID: <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
References: <20180603092736.GA5510@helen.PLASMA.Xg8.DE> <87vab087y2.fsf@evledraar.gmail.com> <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> <20180607063225.GA28343@helen.PLASMA.Xg8.DE> <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Jun 2018, Peter Backes wrote:

> On Thu, Jun 07, 2018 at 10:28:47PM +0100, Philip Oakley wrote:
>> Some of Peter's fine distinctions may be technically valid, but that does
>> not stop there being legal grounds. The proof of copyright is a legal
>> grounds.
>
> Again: The GDPR certainly allows you to keep a proof of copyright
> privately if you have it. However, it does not allow you to keep
> publishing it if someone exercises his right to be forgotten.

someone is granting the world the right to use the code and you are claiming 
that the evidence that they have granted this right is illegal to have?

the GDPR recognizes that there are legal reasons why records need to be kept and 
does not insist that they be deleted.

you can't sign a deal to buy something, then insist that the GDPR allows your 
name to be removed from the contract.

And you are incorrect to say that the GDPR lets you keep records privately and 
only applies to publishing them. The GDPR is specifically targeted at companies 
like Facebook and Google that want to keep lots of data privately. It does no 
good to ask Facebook to not publish your info, they don't want to publish it in 
the first place, they want to keep it internally and use it.

David Lang


> There is simply no justification for publishing against the explicit
> will of the subject, except for the rare circumstances where there are
> overriding legitimate grounds for doing so. I hardly see those for the
> average author entry in your everyday git repo. Such a justification is
> extremely fragile.
>
>> Unfortunately once one gets into legal nitpicking the wording becomes
>> tortuous and helps no-one.
>
> That's not nitpicking. If what you say were true, the GDPR would be
> without any practical validity at all.
>
>> If one starts from an absolute "right to be forgotten" perspective one can
>> demand all evidence of wrong doing , or authority to do something, be
>> forgotten. The GDPR has the right to retain such evidence.
>
> Yes, but not to keep it published.
>
>> I'll try and comment where I see the distinctions to be.
>
> You're essentially repeating what you already said there.
>
>> Publishing (the meta data) is *distinct* from having it.
>
> Absolutely right. That is my point.
>
>> You either start off public and stay public, or you start off private and
>> stay there.
>
> Nope. The GDPR says you have to go from public to private if the
> subject wishes so and there are no overriding legitimate grounds.
>
> That is the entire purpose of the GDPR's right to be forgotten.
>
> Best wishes
> Peter
>
>
