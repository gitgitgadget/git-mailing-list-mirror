Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CA521848
	for <e@80x24.org>; Wed,  2 May 2018 07:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeEBHNB (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 03:13:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:56847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeEBHNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 03:13:00 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.116]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LkOaJ-1ecnZ314Id-00cPuP; Wed, 02 May 2018 09:12:58 +0200
Date:   Wed, 2 May 2018 09:12:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [GSoC] Info: new blog series of my work on Git GSoC '18
In-Reply-To: <20180502033925.6744-1-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805020912210.73@tvgsbejvaqbjf.bet>
References: <20180502033925.6744-1-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bkW36FOA4hCbX0mjTKniE4NVFcwszdFFjsUrQaE2YcSPnpEX2C4
 kwZxjnlXt277OvmK7QN9lZZHO1xdhQjHYyw1uzqdEaaJXGcf8TT9eHU59tUt6rO8tiNQCsm
 jGe9G1Y5CPJREtW3ymrqrTRElvHqysjeUzfH6tynpG0+ETKv1rWNcPLsZcJXEO5wp/iHOPG
 e3m8QnLX+adnCcxg5UwPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UO9hbrdZ3Uc=:TSWdh8S8PdaBpOsXsIWICw
 QZrxHq9bDWQ+BPhPijvB4yhRQZnGoJkz4QC7odg1TSV88+9kuVJvkasuQavlYtR842+8v17O9
 mnfVV+wuwS+JBDnM5lzDwaROvKk38rRxYuE6ItbptgnQUydOjhzHUpng2LUdTeXQO1rCKNv9E
 FB7nMFhga1Aj+BmdODNUNqiCVtk7lno26w7Rr6T3GY/cwJVVC2ohItyEP2NBmUaJeGJPw/aaj
 nQYDRCUu4ALH9plYFu65IcnE53avn/gbSeyVaEyKj/2MSwW1LD7jzdJovoc9GvGxa3E0VAHI+
 3ehVLE1Zj6xDSXZM1wJvn2nrS0/TvPEhSq/TI6PsVudz8yJN0xf+dny/h3Pnw7c8tCRKYP93f
 GZ3HDXeNarmMjXeWlpi+nO2b0demUJMWDZfFxvAaBNLpX/X2/zLsyz3cINcCxU+hqCbtfC/HA
 zPBsTEoqs286rxGOafzPtA/dfylJCCkFezsPz4kwwx05f26jrBwupYI/Sv5/K89t2UMNAoL9+
 Q6aPrY5+xc8nHqQZ8meHhyBWvH9lRyNqqwhD/7GFs789XguW1zpw6dOe1rLjo2jUele79/+jC
 yXgLIh7erjo3iod8DFURSMLD9h1JDDxbPywFBVd7WKNre4MgfHngNy9zvJHQNWNCNRzC1OzwR
 Plint9pC9eD1r/drXbinmKn5m/2XYO2IHjy7M22JgLRLUvE78bkbUUl2ynlK0UlGKQIKbHUSv
 Cd5D1emY1sY/7aNm122OgIAFYyuTddyLGJNX8p0dtDKMkuxGYzKf5FxusZj0bBRO5DdMqwZQ0
 vaWz7+3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Wed, 2 May 2018, Pratik Karki wrote:

> As promised in my proposal, I've started
> to write a blog series of GSoC '18 with Git. The initial blog is up.
> You can find it here[1]. The initial one is just to get started and
> from next iterations, I'll start detailing of my work towards converting
> rebase to builtin.
> 
> [1]: https://prertik.github.io/categories/git/

This is awesome! Thanks for doing this,
Dscho
