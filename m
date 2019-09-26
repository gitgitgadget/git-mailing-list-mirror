Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9651F463
	for <e@80x24.org>; Thu, 26 Sep 2019 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfIZWl4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 18:41:56 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35833 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIZWl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 18:41:56 -0400
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 98401100005;
        Thu, 26 Sep 2019 22:41:53 +0000 (UTC)
Date:   Fri, 27 Sep 2019 04:11:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui contributions, was Re: What's cooking in git.git (Sep
 2019, #02; Wed, 18)
Message-ID: <20190926224151.xoezhpsjwrgy5jg4@yadavpratyush.com>
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1909232132570.15067@tvgsbejvaqbjf.bet>
 <20190924122306.bcwe37wlahjimve7@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1909262042590.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909262042590.15067@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 08:44PM, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 24 Sep 2019, Pratyush Yadav wrote:
> 
> > On 23/09/19 09:35PM, Johannes Schindelin wrote:
> > > Hi,
> > >
> > > On Wed, 18 Sep 2019, Junio C Hamano wrote:
> > >
> > > > We have a new maintainer for git-gui now.  Thanks Pratyush for
> > > > volunteering.
> > >
> > > Excellent!
> > >
> > > I opened PRs at https://github.com/prati0100/git-gui/pulls. Pratyush, do
> > > you accept contributions in this form, or should I do anything
> > > differently?
> >
> > I prefer email. Also, please Cc this list so other people interested in
> > git-gui can take a look.
> 
> I did so.
> 
> Since mailing list-centric workflow is cumbersome for me, I used
> GitGitGadget (I had to work a bit to allow for that, and you are Cc:ed
> manually, that bit is not automated, I hope that other contributors
> implement that in https://github.com/gitgitgadget/gitgitgadget if they
> want that).

Sorry to hear that you had to go through so much trouble to send these 
patches. I personally have the opposite taste. I don't like GitHub's 
workflow and prefer an email based one.

I don't mind setting aside my differences in preferences, but there is 
another more important reason I asked you to email the patches: most of 
the people involved and interested in git-gui development watch this 
list, and not the "Pull Requests" section on my GitHub.

Either way, thanks for the patches :).

-- 
Regards,
Pratyush Yadav
