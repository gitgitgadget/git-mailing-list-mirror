Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123781F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633060AbfIXUFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:05:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56887 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfIXUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 16:05:40 -0400
X-Originating-IP: 1.186.12.39
Received: from localhost (unknown [1.186.12.39])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 167C120005;
        Tue, 24 Sep 2019 20:05:35 +0000 (UTC)
Date:   Wed, 25 Sep 2019 01:35:33 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924200533.pfi7zjv73zklaahw@yadavpratyush.com>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/19 10:12AM, Denton Liu wrote:
> On Tue, Sep 24, 2019 at 02:44:54AM -0400, Jeff King wrote:
> > +## Enforcement
> > +
> > +Instances of abusive, harassing, or otherwise unacceptable behavior may be
> > +reported by contacting the project team at git@sfconservancy.org. All
> > +complaints will be reviewed and investigated and will result in a response
> > +that is deemed necessary and appropriate to the circumstances. The project
> > +team is obligated to maintain confidentiality with regard to the reporter of
> > +an incident. Further details of specific enforcement policies may be posted
> > +separately.
> 
> I feel uncomfortable with this being left so wide open. First of all, I
> know that the power *probably* won't be abused but I don't think
> probably is good enough.
> 
> As I said above, I couldn't find a public list of the people who were on
> the project committee. Perhaps that's because my Googling skills are bad
> but I feel uncomfortable knowing that *anyone* will be given judge, jury
> and executioner power, let alone people whom I don't know anything
> about.
 
I agree with this. I would certainly like to know who the people who 
will judge these cases are.

I want to add another question: what will the judgement process be like? 
Will it be an open discussion on this list, or will it be decided behind 
closed doors by the committee, and we just get to hear the results?

While there might be no plans regarding this as of now, I'd _really_ 
like an open discussion regarding these issues that arise in the future, 
rather than it being decided behind closed doors with us regular old
contributors getting no say in it. A closed discussion would be much 
more prone to power abuse, if any.

> I'm okay with leaving it open for now but I think I would be a lot more
> comfortable if we had the interpretations document to close up the
> vagueness later.

-- 
Regards,
Pratyush Yadav
