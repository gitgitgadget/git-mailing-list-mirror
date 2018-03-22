Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522E41F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCVRcP (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:32:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:34505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCVRcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:32:14 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZxch-1fJ4KJ1IKt-00Lp9o; Thu, 22
 Mar 2018 18:32:12 +0100
Date:   Thu, 22 Mar 2018 18:32:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GSoC] Regarding "Convert scripts to builtins"
In-Reply-To: <CAKk8isrOMMm0zyJ1JtH3aDm=tF5hwokZ0Wzn=D1BQ1R-qEPicw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803221831120.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CADzBBBb0KDVJiX2WSNW=vC6b6paWoK=5XrnZNAY+pwpcu-t9JA@mail.gmail.com> <nycvar.QRO.7.76.6.1803211242190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAKk8isrOMMm0zyJ1JtH3aDm=tF5hwokZ0Wzn=D1BQ1R-qEPicw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vtb2NebGIX4wDbTtea9fUwn7aV9a3DfsqEUbpIqATFPzfmN0Rly
 xKph6XtaiPGIGLGytTxMUUyTu95wLrDj5i4ZBbdLzyadA1kFnhZz0zB5++FHagVQ9Jq8ViK
 PEx7zVSl/ypDJDlpD4uA0P9V2L2gPwvgdkS1ZxwVdt6Hg91E0JJq2D9iwLJvjfS4oKeaVLg
 +xxAJ2IHLdN7N2MpzywYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m4f/YVEDoF8=:YZHyybXLfTdYobfPAgDE4S
 dsj5Qpj77u0HwIs/3N1K5T/6c+D2ASk//7kPvPwv1VXOHXPO0hZWpxLF5GI4qkX01Brbw0EPL
 rMzisWTZotP/dCEcfFeSc/JLK0B5IAGgQj+w/28VQ6q5j9A5yemasETL5FnqpHTeGIP//Sltm
 6a21uv4UPGySvH8unrv/DGU9VsJ0x0FM2Sz6KuNO5vaKvmO6Kc8N+ClpM8waSkbFFHO31S6hc
 eX+SQrKnKLzDBKuwg8mLurrknLSrts4G8EYh1EJheaRjjxyFIHac/qACoH4Z1sVF5EPK4NBCB
 0BuLHQER+UpzQSgA9OJN9UZWWOiwDo+5/TAtS9gLMmIVlqrpg3LWJp65UEbJH5wejoIoa63l0
 e7HvG3E2d5qmurelkSTTJUtfeI1gFV7KdnZ8Uhz9E/on5Bexdpq/Gu6SPsgspDBsT7Ie/Bac+
 LYDZaL+3sWgqEpDU/knmiNP5fxf4x1HOjvvKQV1boOGL64wQiMBUnKY/yoABnsLloKZGBwLWh
 +FrBWQ0oeOa56k1oevX49DBjTgKSS4dZmRLnRDT0zNAa52mpO6vuMyWpSldCLmDc0/kAA3j3B
 gmwq1/ZFc4jeUAQUYaQ6Gy+THOw5OKr3NORzqWuHWGPManVyV7iZP3IdQ8/jInH8kQxBTRXgY
 7potc3q7KbODi1ICm4HFMjFS3mN1alCoarg7xcEWNy9/o6hbF/iQuFfBHysBPZhdZyNvTDQOo
 kJPZhpjNBejiM1JC6CmFe7GnefMNRPmCD2RxRJG5gW36hCObBsnrx8AM1jlZjbuvh2jJDmLK2
 mu2cvD7k3J8csMANyy3hhs0xtArKb4y32TqEbyxd4U3DHGgcGg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Wed, 21 Mar 2018, Wink Saville wrote:

> I plead guilty to being the preson refactoring --preserve-merges. But
> after reading this and seeing that --recreate-merges is coming and
> possibly git-rebase--* moving to C I'm worried I'd be messing things up.

Don't worry. We will just work together to avoid messing anything up.

> Also, Eric Sunshine felt my v1 changes causes the blame information to
> be obscured. So I created a v2 change which keeps everything in the
> git-rebase--interactive.sh.

Great!

> Please see "[RFC PATCH 0/3] rebase-interactive" and
> "[RFC PATCH v2 0/1] rebase-interactive: ...". I'm looking for
> advice on how to proceed.

Sadly, I had almost no time to spend on the Git mailing list today, but I
will have a look tomorrow, okay?

Ciao,
Johannes
