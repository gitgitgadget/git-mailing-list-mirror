Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133111F744
	for <e@80x24.org>; Thu,  7 Jul 2016 11:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcGGLXn (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 07:23:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:64058 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbcGGLXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 07:23:42 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MGSgq-1b7rqt2oAC-00DEr2; Thu, 07 Jul 2016 13:23:23
 +0200
Date:	Thu, 7 Jul 2016 13:23:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 02/17] Report bugs consistently
In-Reply-To: <CACsJy8DY=wRfMBZn75fqjM7i4JzRbr70OCykHU_KdjSXnLY6Pg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607071319070.6426@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de> <fdb0efbeb0b41c0d9976b2d66df90d2366f81ca1.1467717729.git.johannes.schindelin@gmx.de>
 <CACsJy8DY=wRfMBZn75fqjM7i4JzRbr70OCykHU_KdjSXnLY6Pg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ns8zSVrxldxEd0fbJxOxvwfyIyIVqC5R/v2t7iAM/bE/XCQWZ7m
 8Gl3JZcjbDIsbqyXDfFQRzD73NrRKOtz4S3y7W7/L4+bjcKzwCYaMdBW/jADzDvGbB53SSv
 vtpFd5gL+TnVk1ZBsDsrvGKubPoQ8kyJazW47Ic3w7pXMkpPd8ojwimQRaEC4szHD/sXzdj
 Y3RY7hRonh5WNnYa+uMNQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Q8zZCH7xkrY=:bobilThLOTOhiqc9RyxJJe
 P5WGQKDp/qzUpZmgoEbuIgEsUz8/t0ZfsYB30JB7jNBXC+4MNgLupXhz+J5236PMoM/oeJKog
 xX97hh9jM5Au9QLAaBxu4MCt9jWtLLgrUVZt7vNDFEjU1x26WVArkshkM7SgwPFx59MR/VXKD
 +JWd0DCFxHipKrAdC6gzaGkbeFkANS6tsKm2STWeqJnn6pxW4BrRLbebQiFqTF+2tHsrkXQge
 u53DZd3vaSoIHZwgXqRoz8U2Xk4YcMSHQoZ7jVwvwttUErKiJgZTGBTvZfjpONdLNBj5sr34x
 YBMNfP7MPeqvziGopbk7b+wPgT0OYUqyONL4uCZYbaemBQM0Car/Qv127yGjizcNjK9kZg9ig
 hInWSHccEAcCfE1IyvvTzaXuMOj0gYO6a2mrIr1qQflKgNkw4MqfLGXaRnXczCzK6j3hcup93
 ssf3ZWUIAR+Ujha7Pi9RVfng0HtnlzdkRfBpSlzYhLdFp4SSMhBh7kZEDFdjVC0jxxp9FSuU+
 +S0T937dxf9LqMHe0DgeN6X+WUzpJcuMLbfCDtK4eEP9XCiwdDHzIm7p0x2bRKnXjRpkW4g/1
 gnnvNt580on7+vn2hPGLRGI62eAkMsV8uAaetrNWCqyhNVQ68lw5t73xRwwbpm/1YgwR7yJhV
 8gSBP79JiduHgonwmXOo7TxA/H/mNKvU4yzQxf0lEXAV1I54HqL5VslphFmqzo9hZhSXpZYNW
 YzsiaL4i3A/ZSpA7PukOBy8fWfPIFXnGYaPA1UngBa/nTMJpenZrTfBKuUcpQ4Bhy22T3G9tA
 SirBT/b
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Wed, 6 Jul 2016, Duy Nguyen wrote:

> On Tue, Jul 5, 2016 at 1:23 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The vast majority of error messages in Git's source code which report a
> > bug use the convention to prefix the message with "BUG:".
> >
> > As part of cleaning up merge-recursive to stop die()ing except in case of
> > detected bugs, let's just make the remainder of the bug reports consistent
> > with the de facto rule.
> 
> If you search 'die(_("bug:' in this patch,  you'll find 5 instances
> where _() should be gone too.

I should have known better. Vasco's i18n work already conflicts seriously
with what I have in this patch series.

This proves once again, beyond any doubt, that one should refrain from
introducing patches that have little to do with the purpose of the patch
series.

So as far as this here patch series goes, let's re-focus on the recursive
merge code again, okay?

Ciao,
Dscho
