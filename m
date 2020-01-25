Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A375BC2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8033F2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAYQ4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:56:35 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:33335 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYQ4f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 11:56:35 -0500
Received: from localhost (unknown [112.133.229.71])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 38F30100008;
        Sat, 25 Jan 2020 16:56:31 +0000 (UTC)
Date:   Sat, 25 Jan 2020 22:26:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Christian Stimming via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Stimming <christian@cstimming.de>
Subject: Re: [PATCH 2/3] git-gui: update german translation
Message-ID: <20200125165629.55hsywaqojsdpqik@yadavpratyush.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
 <85842282221465469872ed1d5be63dfb2399fb43.1579905218.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85842282221465469872ed1d5be63dfb2399fb43.1579905218.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Thanks for the patches. I don't have much to say about this patch other 
than the commit message since I don't speak German.

> Subject: Re: [PATCH 2/3] git-gui: update german translation

Nitpick: capitalise "german". So, s/german/German/

On 24/01/20 10:33PM, Christian Stimming via GitGitGadget wrote:
> From: Christian Stimming <christian@cstimming.de>
> 
> Switch several terms from uncommon translations back to english
> vocabulary, most prominently commit (noun, verb) and repository. Adapt
> glossary and translation accordingly.

Can you also explain _why_ these uncommon translations are changed to 
English vocabulary? My guess is that the translated versions are too 
awkward and don't express the meaning very well, and terms like "commit" 
and "repository" are more suitable even when German is being used. An 
explanation like this would help explain the need for this patch much 
better.

Everything else looks fine.

PS: It would be nice if we can get an ACK from a German speaker.
 
> Signed-off-by: Christian Stimming <christian@cstimming.de>

-- 
Regards,
Pratyush Yadav
