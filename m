Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A892B1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDTTkq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:40:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:41171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbeDTTkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:40:45 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ME33j-1fChLr2m6R-00HKvg; Fri, 20
 Apr 2018 21:40:40 +0200
Date:   Fri, 20 Apr 2018 21:40:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org
Subject: Re: commit -> public-inbox link helper
In-Reply-To: <20180420083934.GA696@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1804202137310.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180420083934.GA696@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HQVWPEhnMj7EVNojeLwsBS7p4X1JNUz3HyxpaAz8lR0D+J0CJwl
 tlDD5OJ07Ss7iwXOIXxx8j9sxzlBYf/K7G6i2/WqF9i9rIQ1fYzDcR8Wj5J1k7xG1LHQVmp
 M/u681EWyuZA+gUgzQo+8o5fkWGRrczTTUENAYkCD+aFQWB7ehZBYxVB+2zBdEpyERtbFIY
 Zmtl3ZtqwNUq43B0nwmtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1siHZBqnptU=:w9zRXylLqUXAJWyTovst0b
 0+L2sECJ0YblmLTHG08a5FalRmRz+33nDQjiNS1H0z3bph6/6/LpAVaic/B7C3M+6Snj/yw1Y
 S3tK3iOOcZOz6PxwA6qKh23SxdmCzm4MsHl5VO0S+ekqgvfPCnuPWMxM3S2sGzo9PEJA7FiwY
 Gk1jstp/+M+4TtEDab1C0r5N3HO2+h2VL6ydYcdd34GvMYKrb3kntW9En9emMvp0FWnHIaGTw
 2hRC0ip9CohgNTmpLxriXg34Q+JiNBhPGROJzeagWmpr9Nq/h1B8qi5eny8VJfKk13jBMmVjF
 cobfwmZZOmXEWEac+J/Nc78rYm7/6iqckwgRsqhOZyDQeIvEE4NImkY2ThysIky6ke96JvbB0
 h4mszWL8gyXKcMzc+N2Sz0a89w8+cLEHaVBMVvRClJoQPGPrQVOqGG/4hZ786/DX+f3OsOf0r
 qx07ibH9txxWxulAZOt1R6nHdBY0oUJp0AHdu54VxotvjbTTkxw1vTL3cVyR4uJAUJ0FDh8qc
 KslWkNxMy0EK7QnbXE2WSEtRh5jU34razhFhF7Ndl2/3l46DUmUPf6IUak3hnMGqkBGKDqCJz
 4yrmkQnt6bU6a7jwx38v72jW6OEqtJFw9XeWvaDMuY9R98jpjAKwoL986xhSGKgmtSIBlnQG0
 OLYkt91wAHpRCDjFrI+JIS1/egXgZTi5mZQkx4hANlfZAu9CI5xSdE0//lttiOwjZDfnwGkgY
 ACF2valkPsmnDdrbUQV2a2+h64BJbW1bR/gBkMSEf7lSE99KoDccP1QZKp4mv8XaJdV9hUfKm
 9tpjVkW7ZfUSq0EBZFZbxMG93AokLRNqeo4mV6UDzPf8UcqCvo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 20 Apr 2018, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > I found myself in dear need to quickly look up mails in the
> > public-inbox mail archive corresponding to any given commit in
> > git.git. Some time ago, I wrote a shell script to help me with that,
> > and I found myself using it a couple of times, so I think it might be
> > useful for others, too.
> 
> Hello, I think you can dump all the info you need more quickly
> without cloning 1G of data by dumping NNTP OVER(view)
> information instead.

That might be true for the current state of affairs.

However, there *are* cases (I think I even linked to my original mail with
my post-GitMerge 2017 analysis) where the triplet Date/Author/Email is not
enough, where even some patch series have the identical triplet for every
single patch.

Even if I did not hit those cases yet, and therefore did not implement
that part, I needed to keep the door open for that. So I need a clone.

Ciao,
Dscho
