Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDD220248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCCOrK (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:47:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:34871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCCOrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:47:09 -0500
Received: from [10.49.202.116] ([95.208.58.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTeVY-1gZxHK2heK-00QRHt; Sun, 03
 Mar 2019 15:47:02 +0100
Date:   Sun, 3 Mar 2019 15:47:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] tests: introduce --stress-jobs=<N>
In-Reply-To: <20190303141946.GA28939@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1903031544310.45@tvgsbejvaqbjf.bet>
References: <pull.155.git.gitgitgadget@gmail.com> <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com> <20190303141946.GA28939@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1138886583-1551624423=:45"
X-Provags-ID: V03:K1:0sYz/MHNr4kxdiYy8U+dyYcPEZJtNYe4lS2FoaT/Rx3aO44OU8p
 axfdN2ofnuFso8TsSIURm0iO2s/6ldiPzv17HQTgvTp9GbcKnaauFQbgUK2PJgloaKe0NK4
 EaEcK1IiI+dJpZ4V8YV+jXwxDeRkbi4NRRsuT+N+e23SkJvYl4mAXyGwpXGGJ6nfASsYuNP
 Ff7b0TJkSj3SXBWD2vttA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HxKuC1bxftU=:/rMo2kDzVuVsqcccMGWQ/3
 EQR+6uWsfxmtpcBHZR2AzrE45GhTIWYKRjrtCGvj5yWfEDbRnKeQ2vajuJPRZagHD0kU0pyGh
 36noS2zQgpJy84hphKYRPYJHMPUx0LwYRf/vKWFXhV1wMM7l4n7NJcdLRzl4J1HP4pSnvO7HC
 KM02UTEgn+oqY4j3qyGLli3aCsv/xQ///Yh73cb6hpexpXBoEuyCncJ/iTC3OhKeXljkYs91k
 yP0SrcGUU5yhv865vJFJLxjOdZM39waVGZVXhH67pVFE/JzMuyrhFi6wW7PC254gg2fPuTFUm
 iyQ0N1PJ9qMX5QIRPm26VSfeiKswqdWaUaciOUKoslLWJ2tP90o4Bce+jnVQS1UvN5G9GU6Sy
 +X0rOz5eiPP5PwrDj394AF97kA5RGWNfdmBjcIweqSkvk+sY4wuH1Cd5uuNihHdLdQjlECzI7
 QRoshVFv6fjs2UygQGfklCvTVKGuWuMyQJl6/n/S43tR+Kut4Ob89XIaE8q9FrWvkI6PWdJ3z
 BlZvTTGfDIr3AJauCTcE+YD7m5enQBG2X6AB08G5cWTUOeozoo8mk/M8wEFkjnFoWY3xscr7Z
 3cBDe3Xe1FBsDRUjl7DbIdTykOdv+LHQC1040OFUHH6wsAXBOxBbusyuzvCFex2uRP9aA7BQv
 2c06xl0bAPfq84Ijr55mCM0LfX/epjUEP7jk44w9YvECaC0JQtFH3095knZvBIuY+UpARefcO
 wlyKlG7Dhaq6cGpyPEpPc43EdMbMiBjMaPCWaZK19RaIcaZGUHfNPD5MFlDAhV1nPVAxhxOh1
 XtbKQimbKxFx+OqanbGKEZMUEVsSVrZDUBAJsq1u2WaDBGLJY5U6rlsic6/dQ5xiGjUoskUGb
 P92KygZTXmFahiOMJmNi6T5c7SbNjT/MH/D8CuhzdQHRt4nvEFog0Ro2HC9CJg2jZJNVXBDOD
 A/9EHLv+rxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1138886583-1551624423=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 3 Mar 2019, SZEDER Gábor wrote:

> On Sat, Mar 02, 2019 at 01:19:44PM -0800, Johannes Schindelin via GitGitGadget wrote:
> > The --stress option currently accepts an argument, but it is confusing
> > to at least this user that the argument does not define the maximal
> > number of stress iterations, but instead the number of jobs to run in
> > parallel per stress iteration.
> 
> Well, these options' description in 't/README' is quite clear on what
> they do.  If the lack of updates to 't/README' in these patches is any
> indication, then you haven't read that :) but doing so might very well
> have avoided your confusion in the first place.

Yep, hadn't read it, assumed that it was obvious that `--stress=<N>`
meant: try for at most <N> times to replicate the issue.

Which to me is a good indicator that the UI could be improved...

> According to my Bash history, I used '--stress=<even-more-cpu-cores>'
> about 20x more often than '--stress-limit=<N>'.  That's not surprising
> at all, since the main point is to try to trigger rare, hard to
> reproduce failures, no matter how many repetitions it takes.  And even
> if there is an upper bound, it is usually not the number of repetitions
> I know in advance, but rather the time I'm willing to sacrifice on it,
> e.g. how long I'm on lunch break or doing groceries, or when I need my
> CPUs for more important things, or simply when I give up, and hit
> ctrl-C.

I don't doubt that *you* need `--stress-jobs=<N>` more often than
`--stress-limit=<N>`, but I really think that common users will need the
latter a lot more often (if they need the former at all).

> And with --stress-jobs=<N> I will have to type more :)

Sorry ;-)

Ciao,
Dscho
--8323328-1138886583-1551624423=:45--
