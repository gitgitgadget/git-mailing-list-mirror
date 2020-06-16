Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBDFC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1013520734
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFPHnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:43:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFPHnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 03:43:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0CCD9AF8F;
        Tue, 16 Jun 2020 07:43:21 +0000 (UTC)
Date:   Tue, 16 Jun 2020 09:43:16 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     demerphq <demerphq@gmail.com>
Cc:     =?iso-8859-1?Q?S=E9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        don@goodman-wilson.com, Git <git@vger.kernel.org>,
        newren@gmail.com, philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616074316.GA21462@kitsune.suse.cz>
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
 <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 09:36:59AM +0200, demerphq wrote:
> On Sun, 14 Jun 2020 at 20:24, Sérgio Augusto Vianna
> <sergio.a.vianna@gmail.com> wrote:
> >
> > Ok, can you show me a single instance where "master" was confusing or
> > not descriptive enough?
> 
> A: "No you need to fetch master from the remote, then you need to
> merge it to your local master and then push it to the master master".
> B: "remote master, local master and master master. wtf kind of master is that?"
Which falls on the wording of the FAQ, not the terminology itself. If
you were confused I am sure there are ways to bring this up and even
submit changes.

Thanks

Michal
