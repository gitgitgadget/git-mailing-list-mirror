Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E891F406
	for <e@80x24.org>; Wed, 16 May 2018 14:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeEPO2d (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 10:28:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:43281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeEPO2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 10:28:32 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.106]) by mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MCPhl-1fAT6Y1blp-0095kp; Wed, 16 May 2018 16:28:27 +0200
Date:   Wed, 16 May 2018 16:28:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: What would travis do?
In-Reply-To: <CAGZ79kYvmy9yXY-1N-SbHr5Snc5Zi2q0=9XRMscKkrWhfXkcFw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805161627450.77@tvgsbejvaqbjf.bet>
References: <CAGZ79kYvmy9yXY-1N-SbHr5Snc5Zi2q0=9XRMscKkrWhfXkcFw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eDk/a+TrDmGaZDKcXe5nfDwPJvZZ0xinNFysdtVE85N+ys2h8IG
 02h8HVMsTgQRGu92VAJE8/OGpEx/jqso0oz/OUN353H+wOo1lXMjYm21XFdnJQgTjzDQofv
 6wHCkMNTX2JLshEPvedH+DB8dSydxAfR6vrF/auSj4A5YsQQperQ45Tyq3g0MilZoJJKMVa
 asgk4eE12KejVeCzMlotQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ENbRBh+d6vw=:7uatkCm2iM3SBlQqL7HNEj
 mCCwsdXqtrGmPQaqgYxEjZe+FX0VPmugP/ZsupQ5NbZD+HVBVvwEPY6whm3VHysZUGzubCGEB
 ePUbxoXqM8E5dPhQKJanByrgG0i9I54zF/6BWp7JzYD+oZ4LMMcsfrCcnqTOWXsJVOgRyDtz+
 p0snIuHeFenw7x77gMXZtNUZXG0UnYS3th2xnt5hpHhz0GZk/SHKNwc0kqX42PRS+etef/kIc
 si9GMivG40fioo1HbAAfQif8AKGHIwYG+ZrbvKlAAjYtt0C10f4/dDuRrEyq4OAagqCUMh8jz
 +XY3lkiPFbIMFlqsIqkdjtEw/pevOBQyppPS01E0x70YAm4ej5SLcyoHcexGjpY/gej9gflVl
 ixpI0+f5nLsPXp6y3bvmm6qOw6KusiFwisdXY2YCHn2908mZLJ50+NteRYo2KDQZobOTktejv
 mlnNga+eiDbAYQ4LUvTHtHo1lWfLQMFkyAaq+xvsJAIR/py2jN/TUHGpnYAnK0kaU07oYegys
 1vgQZkSJjHEqsFwaw0AwPZvoohbByje0krxAXXQugoT0lW4E0tBRJ83cFyVxlp4NA8ZBB9PYM
 gnAi8TzOu29S//PjdN2K09N38fZpL70pNieN6LpwKn5Kclmo2dvp3YEarnEsd4qHqElDBuItS
 09EAASoSa7D6j+DIKmEt7PzQh1cUGRQZC7tV6TpoJsYDjaelxdjwHHcoAgB/qR9xMHWpX9vRn
 qYXKPpdXv9FEeFfBl74zpGIeCGwZwVFIdDuk6Nl1xtYqHodV12OZoUy8ky4F5y10PwSEOmwNi
 YovW1X4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 15 May 2018, Stefan Beller wrote:

> in a context unrelated to Git, I found https://github.com/grosser/wwtd
> ("What would travis do?"), which may be interesting for those who
> tweak the travis file.

While that is a nice project, I have to admit that it would not help in
most cases where my builds break, as I have quite different setups from
the VMs used by Travis...

Ciao,
Dscho
