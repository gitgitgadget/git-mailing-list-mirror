Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E691F42D
	for <e@80x24.org>; Thu, 17 May 2018 09:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeEQJJ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 05:09:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:38137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeEQJJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 05:09:25 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.106]) by mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LzoSt-1eFdZo1y8R-0153c3; Thu, 17 May 2018 11:09:23 +0200
Date:   Thu, 17 May 2018 11:09:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] A blog about 'git stash' project
In-Reply-To: <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com> <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com> <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com> <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com> <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h94sCnb6nVDVy8Zuy3qFkX16EVhnZKT0w9s1S5kPTUfvDlxBHHc
 /28pRA3Xo9ZKj3n5+z8xQJofDOYfB2Hja7az4cwKHwj3EI9S1Xw7LEIPwaXTWTRd279xiks
 AXh/XTupICZtNNsXkJgFpj3JcM0Pua/y/YbFErWh2ptItGUHsrfE3ofKL7+b0UaJ8M0jODc
 yKEhWL+CA8fzKnyk8R9ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7eMx8berjhI=:JespG7I5v6U0t6KwONP6N2
 WARye5D5GGn0L0QtMsfVV1uOvFgqMPb1y9P7xFZVOIpUB8VL2fB1MejlXl5+VrsUvrP7wnUas
 v4B2vkyBtbfb9sfnh1VyOseCuBtPmNUa3MROz7UMBbHc5KBGhNfopLpKbte93CSx9ityhZa1D
 TIgDHdy7RPbJBGhnURuIqvVCojpqRXOtgn/2KTatQJNDx4WojiviHlw2nVLVUVi2wre6KoO5O
 wDO95NBnOIXi3Z5ujofbIbbMtwuesoUvYhoYcl/haCSGHwV0NP7xPlBlCQlHLH795DfkuWvnM
 2CpagP9PcUeVihbw3Wyz5kcUUnWksY/RkDy293RzzQqp9Y1ckhWlN1nWi1mwHvaHYtCQSnPfg
 uXICCZ6vS92o+k6OoRw45OOfhzy+wO9CT10QCIOyqNw/WiKb4uKP7/7nLx4ea6bzwSWE9gi4H
 +zuFQUA3K72jITSSfC0gG8jPNvfdkPszLFqSmaU8f6n36na2kfKnPcyl+FeXlYStp6ixPu3kM
 FpLdOuTfmYWQacqqrI4PfYCtvvmCp5PB4EI3P1ubwlkQx0++EPyqsegl51CtckOz66koFLa+X
 kTrBgVQrRzwvsSXTWTYUuMimij65XNkPbNe4aaGKOopbb57SJhUR/t4iE2Jq0bAnPFKyC5PDw
 RLUiuG8y+D8TQGNm1rHIKf159QGDkowi0/HzdmS/vC+41xygQH+0kL6OPnb8bCRUISuzCT5ng
 Cerq4gFWo6Ozww5OYDeVbl5MqWa7Ml6Z8HtB3VkBzKK9bYPzabm5XXoi7/2Nh9OYAdQCyNYJV
 VyZObnP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

> On Thursday 17 May 2018 12:28 PM, Kaartic Sivaraam wrote:
> 
> > I thought of pointing you to one of the issues with the current
> > implementation of 'git stash' which you could probably fix while
> > porting it to C.
> >
> > ...
> > 
> 
> Forgot to mention about another issue, which I consider to be a bug. I
> have elaborated about it in the following mailing list email.
> 
> 	https://public-inbox.org/git/aa43f1ff-9095-fb4d-43bc-bf8283b7dabb@gmail.com/
> 
> Unfortunately, it didn't receive any replies. See, if you could do
> something about it.

I have great empathy for the desire to see these bugs fixed. The
conversion must come first, though, and in the interest of making it
easier on me and other reviewers, I must insist on keeping the conversion
free of any changes, much in the way as we try to avoid evil merges (i.e.
merge commits that introduce changes that were not present in any of their
parents).

Depending how the conversion goes, I could imagine that there might be
plenty of time to do fun stuff on top, such as fixes for the bugs you
mentioned.

Ciao,
Johannes
