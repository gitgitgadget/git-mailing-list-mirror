Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E14C1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbfISVka (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:40:30 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:43030 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390087AbfISVka (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:40:30 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92.1)
        (envelope-from <mh@glandium.org>)
        id 1iB4A3-0003RA-Qy; Fri, 20 Sep 2019 06:40:23 +0900
Date:   Fri, 20 Sep 2019 06:40:23 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190919214023.hu3oznjcrzrsmpso@glandium.org>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 12:30:13PM -0400, Derrick Stolee wrote:
> During the Virtual Git Contributors' Summit, Dscho brought up the topic of
> "Inclusion & Diversity". We discussed ideas for how to make the community
> more welcoming to new contributors of all kinds. Let's discuss some of
> the ideas we talked about, and some that have been growing since.
> 
> Feel free to pick apart all of the claims I make below. This is based
> on my own experience and opinions. It should be a good baseline
> for us to all arrive with valuable action items.
> 
> I have CC'd some of the people who were part of that discussion. Sorry
> if I accidentally left someone out.
> 
> I. Goals and Perceived Problems
> 
> As a community, our number one goal is for Git to continue to be the best
> distributed version control system. At minimum, it should continue to be
> the most widely-used DVCS. Towards that goal, we need to make sure Git is
> the best solution for every kind of developer in every industry. The
> community cannot do this without including developers of all kinds. This
> means having a diverse community, for all senses of the word: Diverse in
> physical location, gender, professional status, age, and others.
> 
> In addition, the community must continue to grow, but members leave the
> community on a regular basis for multiple reasons. New contributors must
> join and mature within the community or the community will dwindle. Without
> dedicating effort and attention to this, natural forces may result in the
> community being represented only by contributors working at large tech
> companies focused on the engineering systems of very large groups.
> 
> It is worth noting that this community growth must never be at the cost
> of code quality. We must continue to hold all contributors to a high
> standard so Git stays a stable product.
> 
> Here are some problems that may exist within the Git community and may
> form a barrier to new contributors entering:
> 
> 1. Discovering how to contribute to Git is non-obvious.
> 
> 2. Submitting to a mailing list is a new experience for most developers.
>    This includes the full review and discussion process.
> 
> 3. The high standards for patch quality are intimidating to new contributors.
> 
> 4. Some people do not feel comfortable engaging in a community without
>    a clear Code of Conduct. This discomfort is significant and based on real
>    experiences throughout society.
> 
> 5. Since Git development happens in a different place than where users
>     acquire the end product, some are not aware that they can contribute.

6. Newcomers don't really have any idea /what/ they could contribute.
They either have to come with their own itch to scratch, or read the
code to figure out if there's something to fix.

Mike
