Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FDE81F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfIXUuw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:50:52 -0400
Received: from mail.maxeymade.com ([108.252.2.93]:59995 "EHLO
        mail.maxeymade.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbfIXUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 16:50:51 -0400
X-Greylist: delayed 2393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 16:50:51 EDT
Received: from [10.41.86.232] (eric.riw.enoyolf.org [10.41.86.232])
        (authenticated bits=0)
        by mail.maxeymade.com (8.15.2/8.15.2) with ESMTPSA id x8OKAjDl017300
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 24 Sep 2019 15:10:45 -0500
Subject: Re: [PATCH] add a Code of Conduct document
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
 <20190924200533.pfi7zjv73zklaahw@yadavpratyush.com>
From:   Doug Maxey <doug@maxeymade.com>
Message-ID: <939c10b4-d018-82cb-395b-e1d85bfa253b@maxeymade.com>
Date:   Tue, 24 Sep 2019 15:10:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924200533.pfi7zjv73zklaahw@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/24/19 3:05 PM, Pratyush Yadav wrote:
> On 24/09/19 10:12AM, Denton Liu wrote:
>> On Tue, Sep 24, 2019 at 02:44:54AM -0400, Jeff King wrote:
>>> +## Enforcement
>>> +
>>> +Instances of abusive, harassing, or otherwise unacceptable behavior may be
>>> +reported by contacting the project team at git@sfconservancy.org. All
>>> +complaints will be reviewed and investigated and will result in a response
>>> +that is deemed necessary and appropriate to the circumstances. The project
>>> +team is obligated to maintain confidentiality with regard to the reporter of
>>> +an incident. Further details of specific enforcement policies may be posted
>>> +separately.
>> I feel uncomfortable with this being left so wide open. First of all, I
>> know that the power *probably* won't be abused but I don't think
>> probably is good enough.


I can put it more succinctly:

Has anyone ever heard the pebble dropped in this well hit bottom?


>>
>> As I said above, I couldn't find a public list of the people who were on
>> the project committee. Perhaps that's because my Googling skills are bad
>> but I feel uncomfortable knowing that *anyone* will be given judge, jury
>> and executioner power, let alone people whom I don't know anything
>> about.
>   
> I agree with this. I would certainly like to know who the people who
> will judge these cases are.
>
> I want to add another question: what will the judgement process be like?
> Will it be an open discussion on this list, or will it be decided behind
> closed doors by the committee, and we just get to hear the results?
>
> While there might be no plans regarding this as of now, I'd _really_
> like an open discussion regarding these issues that arise in the future,
> rather than it being decided behind closed doors with us regular old
> contributors getting no say in it. A closed discussion would be much
> more prone to power abuse, if any.
>
>> I'm okay with leaving it open for now but I think I would be a lot more
>> comfortable if we had the interpretations document to close up the
>> vagueness later.
