Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3FC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041C207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1Skc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:40:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54697 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1Skc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:40:32 -0500
X-Originating-IP: 112.133.229.67
Received: from localhost (unknown [112.133.229.67])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2115BE000E;
        Tue, 28 Jan 2020 18:40:29 +0000 (UTC)
Date:   Wed, 29 Jan 2020 00:10:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Christian Stimming <christian@cstimming.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-gui: update german translation
Message-ID: <20200128183949.7xt7d7yhkpx5cu4l@yadavpratyush.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
 <85842282221465469872ed1d5be63dfb2399fb43.1579905218.git.gitgitgadget@gmail.com>
 <20200125165629.55hsywaqojsdpqik@yadavpratyush.com>
 <1910399.tNsU6uBNYh@ckiste>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1910399.tNsU6uBNYh@ckiste>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/20 04:52PM, Christian Stimming wrote:
> Dear Pratyush,
> 
> thanks for the first evaluation.
> 
> Am Samstag, 25. Januar 2020, 17:56:29 CET schrieb Pratyush Yadav:
> > > Subject: Re: [PATCH 2/3] git-gui: update german translation
> > 
> > Nitpick: capitalise "german". So, s/german/German/
> 
> Of course I can do that... however, the capitalization of the headline is 
> somewhat different every time in the repository. The first word is lower case, 
> yes, but e.g. the language adjective is sometimes upper case, sometimes lower 
> case. 

Well, that's why I marked the comment as a nitpick. I'm fine with 
either, so go with whatever you feel is fine. But FWIW I do have a 
slight preference for capitalizing it.
 
> > On 24/01/20 10:33PM, Christian Stimming via GitGitGadget wrote:
> > > From: Christian Stimming <christian@cstimming.de>
> > > 
> > > Switch several terms from uncommon translations back to english
> > > vocabulary, most prominently commit (noun, verb) and repository. Adapt
> > > glossary and translation accordingly.
> > 
> > Can you also explain _why_ these uncommon translations are changed to
> > English vocabulary? 
> 
> I've written an explanation in the cover letter email. Do you want to have it 
> copied into the commit message?

Ah, I was in a hurry and didn't read the cover letter. Yes, that 
explanation would be great in the commit message.

-- 
Regards,
Pratyush Yadav
