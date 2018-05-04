Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520EB1F42E
	for <e@80x24.org>; Fri,  4 May 2018 06:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEDGmQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 02:42:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:39231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751240AbeEDGmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 02:42:15 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXmpv-1esLNW2XfL-00Wmqe; Fri, 04
 May 2018 08:42:09 +0200
Date:   Fri, 4 May 2018 08:42:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 11/18] branch-diff: add tests
In-Reply-To: <8DBB15A6A2AB48C7A9914B5B419E001F@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1805040841230.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de> <8DBB15A6A2AB48C7A9914B5B419E001F@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2sTNm2bRq/wGzlsA0e30cMfVjxTLQCjru7d5gvT6f7JXMn8htFI
 mLKpdVxV0yQ6r/0mjozVhi12WShj5x+7FojtTS8dpQSRwypbWBSY2SIEmABkVzQ6qBo8yQ/
 HkqPURPCYYzcBiN8KfL9kK160V9LHsaxXWAdxYv16RQNI7lFWyyN0kqzXMgCt+L+SgvCup1
 390bI/GjtQHD21SS8XUdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3lbWA3uFxso=:v6fAYQ2DYb9c/eWG0egNtG
 ekkwLqgr7zx4N61fUKus4GQOztkzb11aPQ2I9YKzuzUcod1yc4TRbl2SoCNoYJY9Dp8DnTcdl
 ATFa8A1MR5CQ3xZegPuS/Z78FqN/4jHCF5BuxA8xeBSMu2XoVfKPeoQR+VBm3YcReu19ospj9
 4AWBDhQ5UuL6Y+c/tNGzZCIo9BWvGuoYNO5QLXz/j5HUcU2hdHYJyTijSzy8HB8BPjcrl6biW
 O6dVvZdlRGEKdb9FmlQEtkqm2bSWcmsMmccaBg5nSoAj8EOOJ/3tE3gdZDeJD9IXC7o1SGUaN
 mu6QV9RtTy9a9uQqFoHs+4lYfDKuu9EG1mE8kotMt9ZnieMy4lB7y8ijkjNoho+QJBTXzLK92
 Jc5boEDV4GWrrHVFY1rKYSHhFk0JUOsRcvfPMEPufomLR+RXlD3sDCQ57Ow4Z27ibeHILNbFf
 JcwdEc/JIciVZKaphMX2uCcho3XUQ0CtDql3PWK67Gbj2kjax4euyJoES10YgfmklI1bPY1D8
 Elet+KV0dKMjsfA79UZOz1vaJPlZ8CEViQq3ZkDA6/qlfJJkMOCZHACbJzThgcRWx0d9slC/8
 QIW/6yrV+CaI2q2IVuYmCURx9z6w2cOwmwJzXEZHAhV98esPqJUaDppgtU+00kMRC2TW/941p
 nsscVr525vIjWznYxpZMmY/scXRY2U6UuwfruTc4K2IRFEP1p5LRNDpl47gDthJFNJsMhw0l6
 cOz5ZfNHH7ZHVX40DpA9gqHnex+FA02SPnqPztKgQzRcWamwXuDVcfxdlUI69v/ef8mUsVSKk
 OBg80hM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 4 May 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > From: Thomas Rast <tr@thomasrast.ch>
> > 
> > These are essentially lifted from https://github.com/trast/tbdiff, with
> > light touch-ups to account for the new command name.
> > 
> > Apart from renaming `tbdiff` to `branch-diff`, only one test case needed
> > to be adjusted: 11 - 'changed message'.
> > 
> > The underlying reason it had to be adjusted is that diff generation is
> > sometimes ambiguous. In this case, a comment line and an empty line are
> > added, but it is ambiguous whether they were added after the existing
> > empty line, or whether an empty line and the comment line are added
> > *before* the existing emtpy line. And apparently xdiff picks a different
> 
> s/emtpy/empty/

Yep, that has been pointed out by others, too... ;-)

It is good that this thing gets a really good review *grins*

Ciao,
Dscho
