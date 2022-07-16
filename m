Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA07DC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiGPWt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiGPWt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 18:49:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68610167F1
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 15:49:54 -0700 (PDT)
Received: (qmail 26131 invoked by uid 109); 16 Jul 2022 22:49:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Jul 2022 22:49:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24729 invoked by uid 111); 16 Jul 2022 22:49:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Jul 2022 18:49:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Jul 2022 18:49:47 -0400
From:   Jeff King <peff@peff.net>
To:     Manuel Boni via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Manuel Boni <ziosombrero@gmail.com>
Subject: Re: [PATCH v2] config.txt: document include, includeIf
Message-ID: <YtNAi/MDHGLayGY7@coredump.intra.peff.net>
References: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
 <pull.1285.v2.git.1658002423864.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1285.v2.git.1658002423864.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2022 at 08:13:43PM +0000, Manuel Boni via GitGitGadget wrote:

>     Update 2022-07-16: I addressed the suggestions by Jeff King and Junio C.
>     Hamano by integrating their fixes and by rewording the commit message,
>     so that emphasis is put on the documentation enhancement and mentioning
>     the improved tab completion as a beneficial side effect.

Thanks. This version looks OK to me.

-Peff
