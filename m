Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19FE1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfIWT1G (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:27:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726033AbfIWT1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:27:05 -0400
Received: (qmail 29521 invoked by uid 109); 23 Sep 2019 19:27:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 19:27:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3888 invoked by uid 111); 23 Sep 2019 19:29:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 15:29:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 15:27:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923192704.GD21344@sigill.intra.peff.net>
References: <CAP8UFD3NPYJr5PXLDyRD=qbEPft8E-HwtGUo_FxoG=q5jfY5Ng@mail.gmail.com>
 <20190923175805.58457-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923175805.58457-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 10:58:05AM -0700, Jonathan Tan wrote:

> > I think this is really great, both the idea and the description! No
> > need for more details.
> 
> Thanks! I've just submitted the project proposal - hopefully it will be
> approved soon. In any case, it seems that project information can be
> edited after submission.

I approved this. I did leave some comments elsewhere in the thread, but
I think we can continue to iterate on the idea.

> There was a "How can applicants make a contribution to your project?"
> question and a few questions about communication channels. I answered
> them as best I could but if anyone has already answered them, it would
> be great to just use the same answer everywhere. (I can't see all
> project information of other projects since I haven't filled out a
> "short initial application", but I don't think that applies to me.)

What you wrote there looks pretty good to me. Copying it here for
purposes of discussion:

> Please introduce yourself on the public project chat:
>
> IRC - Follow this link to join this project's public chat. If you are
> asked for username, pick any username! You will not need a password to
> join this chat.
>
> Git mailing list - Follow this link to join this project's public
> chat.

where the IRC link goes to Freenode's webchat, and the mailing list link
goes to https://git-scm.com/community.

The other proposal is from Christian, who wrote:

> Please introduce yourself on the public project chat:
>
>     a mailing list - Once you join the project's communication
>     channel, the mentors have some additional instructions for you to
>     follow:
> 
>     Start the subject of your emails to the mailing list with "[Outreachy]" so that mentors and people interested in Outreachy can easily notice your emails.
>     Follow this link to join this project's public chat.
> 
>     Send an email to majordomo@vger.kernel.org with "subscribe git" in
>     the body of the email.

I think the "[Outreachy]" advice is good, and worth adding to yours. I
think linking to the "community" page is a good idea for Christian's, as
it has more tips on using the mailing list.

I'd leave it up to individual mentors whether they want to mention IRC
(based on whether or not they actually use IRC themselves).

-Peff
