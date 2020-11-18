Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8098C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 12:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710D0238E6
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgKRM2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 07:28:20 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45825 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKRM2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 07:28:20 -0500
X-Originating-IP: 103.82.80.28
Received: from localhost (unknown [103.82.80.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1BA43FF806;
        Wed, 18 Nov 2020 12:28:17 +0000 (UTC)
Date:   Wed, 18 Nov 2020 17:58:14 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Dimitriy <dimitriy.ryazantcev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: update Russian translation
Message-ID: <20201118122814.kvt2zjt4kp4rudgh@yadavpratyush.com>
References: <20201106184904.7196-1-dimitriy.ryazantcev@gmail.com>
 <CAPUT4mR75M6138MVUdb_=ag0aG9MdrLbj-PgwP7y7J+2fv4zLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUT4mR75M6138MVUdb_=ag0aG9MdrLbj-PgwP7y7J+2fv4zLw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dimitry,

On 18/11/20 01:02PM, Dimitriy wrote:
> Any news on this?

It must have slipped through the cracks because I don't remember seeing 
this at all.
 
> пт, 6 нояб. 2020 г. в 20:49, Dimitriy Ryazantcev
> <dimitriy.ryazantcev@gmail.com>:
> >
> > Translation is done on Transifex: https://www.transifex.com/djm00n/git-po-ru/git-gui/
> > If you have any corrections please report them there.

Can you please explain in more detail what you "updated". I don't know 
Russian, and I don't know any Russian speakers willing to review this 
patch. So a brief description of what you change will make me a little 
more comfortable merging this patch.

Also, please don't redirect people to this website. If you _are_ 
interested in maintaining the Russian translation long term, let's do it 
here on this list :-)

> >
> > Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> > ---
> >  po/ru.po | 3287 +++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 1778 insertions(+), 1509 deletions(-)
> >

-- 
Regards,
Pratyush Yadav
