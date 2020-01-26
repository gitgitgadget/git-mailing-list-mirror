Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B06C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5EE20708
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 15:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAZP6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 10:58:07 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:38948 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAZP6H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 10:58:07 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jan 2020 10:58:06 EST
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 485HSb6GN2zxRs;
        Sun, 26 Jan 2020 16:52:15 +0100 (CET)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alucst@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 485HSb53djzJpRP;
        Sun, 26 Jan 2020 16:52:15 +0100 (CET)
From:   Christian Stimming <christian@cstimming.de>
To:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-gui: update german translation
Date:   Sun, 26 Jan 2020 16:52:15 +0100
Message-ID: <1910399.tNsU6uBNYh@ckiste>
In-Reply-To: <20200125165629.55hsywaqojsdpqik@yadavpratyush.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com> <85842282221465469872ed1d5be63dfb2399fb43.1579905218.git.gitgitgadget@gmail.com> <20200125165629.55hsywaqojsdpqik@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Pratyush,

thanks for the first evaluation.

Am Samstag, 25. Januar 2020, 17:56:29 CET schrieb Pratyush Yadav:
> > Subject: Re: [PATCH 2/3] git-gui: update german translation
> 
> Nitpick: capitalise "german". So, s/german/German/

Of course I can do that... however, the capitalization of the headline is 
somewhat different every time in the repository. The first word is lower case, 
yes, but e.g. the language adjective is sometimes upper case, sometimes lower 
case. 

> On 24/01/20 10:33PM, Christian Stimming via GitGitGadget wrote:
> > From: Christian Stimming <christian@cstimming.de>
> > 
> > Switch several terms from uncommon translations back to english
> > vocabulary, most prominently commit (noun, verb) and repository. Adapt
> > glossary and translation accordingly.
> 
> Can you also explain _why_ these uncommon translations are changed to
> English vocabulary? 

I've written an explanation in the cover letter email. Do you want to have it 
copied into the commit message?

Regards,
Christian



