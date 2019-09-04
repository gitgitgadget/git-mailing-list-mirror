Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005C41F461
	for <e@80x24.org>; Wed,  4 Sep 2019 19:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfIDTlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 15:41:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:39508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729740AbfIDTlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 15:41:16 -0400
Received: (qmail 16988 invoked by uid 109); 4 Sep 2019 19:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 19:41:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18106 invoked by uid 111); 4 Sep 2019 19:42:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Sep 2019 15:42:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Sep 2019 15:41:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190904194114.GA31398@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827051756.GA12795@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 01:17:57AM -0400, Jeff King wrote:

> Do we have interested mentors for the next round of Outreachy?
> 
> The deadline for Git to apply to the program is September 5th. The
> deadline for mentors to have submitted project descriptions is September
> 24th. Intern applications would start on October 1st.
> 
> If there are mentors who want to participate, I can handle the project
> application and can start asking around for funding.

Funding is still up in the air, but in the meantime I've tentatively
signed us up (we have until the 24th to have the funding committed).
Next we need mentors to submit projects, as well as first-time
contribution micro-projects.

Project proposals can be made here:

  https://www.outreachy.org/communities/cfp/git/

If you want to know more about the program, there's a mentor FAQ here:

  https://www.outreachy.org/mentor/mentor-faq/

or just ask in this thread.

The project page has a section to point people in the right direction
for first-time contributions. I've left it blank for now, but I think it
makes sense to point one (or both) of:

  - https://git-scm.com/docs/MyFirstContribution

  - https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git

as well as a list of micro-projects (or at least instructions on how to
find #leftoverbits, though we'd definitely have to step up our labeling,
as I do not recall having seen one for a while).

-Peff
