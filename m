Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203D81F404
	for <e@80x24.org>; Tue, 10 Apr 2018 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDJGQC (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 02:16:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:35867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeDJGQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 02:16:01 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHX0m-1f2UFP0KJY-003Mld; Tue, 10
 Apr 2018 08:15:59 +0200
Date:   Tue, 10 Apr 2018 08:15:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     Hari Lubovac <hlubovac@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Windows > git.exe > the result of "git branch" does not always
 highlight the current branch
In-Reply-To: <CAGZ79kZ6xWijnZZpcogVm_JCX3nGMzN8ebKyh1vYygNc_dqGFw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804100813590.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com> <CAGZ79kZ6xWijnZZpcogVm_JCX3nGMzN8ebKyh1vYygNc_dqGFw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/ScHrlQL/tTJkcEFPDGNtScpY6XHDX/hWtHCw2dLAKVuMZoj30P
 QeC1oSwgmqhijPfGlMREP35Oc6z/heQF6uv0fNbZ39JqP5Hzzfh5XQnQp/RQZJaoZj5wMNO
 YRT1xi8UJG8WepSLR1KO7mZTY1bmXQcIIIwIYP8ApaJYmh5O1Ca1PoiBPtcv15EQUNetgCy
 Xo2GayZhg0BgdTl1IsGbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FVAw6BNvdXU=:D4o14P14KYNrEepc1STUY0
 7tFuJplCWLi+1DQpq2ukFrbZx6+zx9EikNQSxm7TMqh3av3Q40exROKOfEfIOOshURTo6LMJ9
 p6Uej8bmcihX+rfhN+wmWOIsd8VGL45sVjtvK9uJ1sqzhlitrm5ZG9yYkQvZY9M2Yh7vaQGvF
 e0lBe4eeWHD/IqflvbGHQRdOWIcz+WHHSis2oRd2VzfZZRKhRd1hjsr2s8p70b62F0TM7Lkq5
 7YapQs+nR8l6RyFHuvNzUgOXQ4NDDDOZSCpmondS02epQaHEQQuehaVuTtwEWxGMryG4lyzH+
 XRNU0GAVYGABDN/NOFp+bO+erfGeYgFyVNBzKhDU2+3L0h+5d7eYajFh9oBUnsTg0iT/VlThD
 st+0C50SWwd+Q9664OSvZJC99MD/K+kRvzEzmD4Be0oY1ZY6W7tKCz3PnhCuV4TvVQzih657y
 UAZqZTkENT50tgOV9v1L44e9t0jbG+C0GtCBGeC2byNBqDrTSzYWgSvZt4HUiN4UE+8IMq4Qi
 OMA5Susbw86mcqnUvGfAUlHhAZQF1/6cVz0H5nJR0ZxT6Kv8+kGOLCd1/ukRUkR2nv05eu07Q
 re1qIHyait43KJPFR6abHVs4rYZ/37nJ1HJwHqpp5oVdFeINZ98Wet5OZWZRSUfR4PEtdCvHi
 ijFXb/rOgeLD/rms8LzI4yPXtzZgf6zdubVehBo1omHd/qrE4da374hLhb6YbglQjR+MGtCLO
 f7G1lwrbPb7ve2avGHvEMY1vXicWmdgJ1I+N9W0/FUD+onGcFqQ46rqt93NaGx3uAdEKRhxOs
 +yn8XjZHdtMB99DNYRN3KdDIGGMuqGhyc/3GF5ct2VzHtgwQ/w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 9 Apr 2018, Stefan Beller wrote:

> AFAICT Git-for-Windows prefers to have a bug on github
> https://github.com/git-for-windows/git/issues/new

I try to follow Postel's Law for contributions and bug reports. If there
is enough detail in the bug report on this here mailing list, that's good
enough for me.

If details are missing, I frequently suggest to follow that link because
some excellent contributors spent quality time on the issue reporting
template, helping bug reporters to avoid incomplete reports.

Thanks,
Johannes
