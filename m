Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C391C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 05:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiJZFSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 01:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiJZFSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 01:18:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBF8996B
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 22:18:43 -0700 (PDT)
Received: (qmail 10209 invoked by uid 109); 26 Oct 2022 05:18:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Oct 2022 05:18:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1298 invoked by uid 111); 26 Oct 2022 05:18:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Oct 2022 01:18:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Oct 2022 01:18:41 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     bagasdotme@gmail.com, git@vger.kernel.org
Subject: Re: Thanks
Message-ID: <Y1jDMW4ST5UEjKbC@coredump.intra.peff.net>
References: <84143b0c-139b-63c5-519f-8d4a44254976@gmail.com>
 <20221026043905.1654-1-mirth.hickford@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221026043905.1654-1-mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 05:39:05AM +0100, M Hickford wrote:

> > > (first message using git send-email, hopefully I followed the instructions correctly)
> >
> > You messed up the thread (you broke it).
> 
> Curious. The thread overview "5+ messages" at
> https://lore.kernel.org/git/20221025015116.4730-1-mirth.hickford@gmail.com/#related
> looks okay to me. I followed the git send-email instructions setting
> the In-Reply-To header. I changed the subject -- maybe that confused
> some clients?

Your reply looked fine to me. The in-reply-to you used is correct. It's
OK to change the subject (though usually only done when the conversation
drifts to a different topic).

-Peff
