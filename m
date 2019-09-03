Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33661F461
	for <e@80x24.org>; Tue,  3 Sep 2019 09:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfICJD0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 3 Sep 2019 05:03:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:33504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfICJD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 05:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62B12B0B7;
        Tue,  3 Sep 2019 09:03:25 +0000 (UTC)
Date:   Tue, 3 Sep 2019 11:03:23 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Giuseppe =?UTF-8?B?Q3JpbsOy?= <giuscri@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190903110323.6e500ca8@naga>
In-Reply-To: <20190903075154.GA18496@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
References: <20190902215048.31a69442@naga>
        <20190903075154.GA18496@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Sep 2019 07:51:54 +0000
Giuseppe Crinò <giuscri@gmail.com> wrote:

> On Mon, Sep 02, 2019 at 12:25:37PM -0700, Junio C Hamano wrote:
> > I'd rather leave the sleeping dog lie, if we need to encourage
> > people to live in 21st century and step outside US-ASCII to do so,
> > then do that instead.  
> 
> +1 to let the sleeping dog lie. When you say we should encourage people
> to step outside US-ASCII what do you mean by that?
> 
> On Mon, Sep 02, 2019 at 09:50:48PM +0200, Michal Suchánek wrote:
> > As much as I would love to agree Windows is dragging us down here. I
> > don't think there is any other major (or even just not completely
> > obscure) platform that does not support UTF-8 in the terminal.  
> 
> Well, I don't know how much Windows is related to that. On my Linux
> machine my user.name ends with a single quote: I have a US keyboard but
> my name ends with an "o grave" and I can't type it.

Have you ever heard about XCompose?

Thanks

Michal
