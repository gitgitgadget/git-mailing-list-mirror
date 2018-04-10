Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A285A1F424
	for <e@80x24.org>; Tue, 10 Apr 2018 06:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDJGar (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 02:30:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:53897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbeDJGar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 02:30:47 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGFz9-1fIjMx2VNv-00FBSO; Tue, 10
 Apr 2018 08:30:44 +0200
Date:   Tue, 10 Apr 2018 08:30:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Hari Lubovac <hlubovac@gmail.com>
cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Windows > git.exe > the result of "git branch" does not always
 highlight the current branch
In-Reply-To: <CAFLu24kTRrAq3cOH5H1=nBT94p7uFSsaYJsUC-wN1brPFHk3mQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804100825280.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com> <CAGZ79kZ6xWijnZZpcogVm_JCX3nGMzN8ebKyh1vYygNc_dqGFw@mail.gmail.com> <CAFLu24kTRrAq3cOH5H1=nBT94p7uFSsaYJsUC-wN1brPFHk3mQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G/11mn76/YMOAmJ//u1VYl1YaMB2BL6/T207SdUxEETx3H9uOb1
 JH3sfUhjoKnoMqTXw2sgR4bgqU1y/jUHhgWVPJVjfJYs6ayqNUN6ewA1GNKxavr6EBOjnCR
 hYlrY1IJgkR292+d9i2JYK9kY/jfmH8g6qL3zuYYAQIqQIFUWj1ddXvWZsY0mmWXfGZkUYv
 E+FOlnyfcFR16R/vJn0bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yn195BJJ6K0=:gw2n31h7EwVVs4/YTchp3e
 ncYwkEUApdLwv91FPxYZsS44F2nL5gWYdRSQzEYQH9x25ffaNley7rVn8WQyiYlKhEI1F+XBs
 fd2qAh/frm9cAlU8p9UoDTebey52+Mb+9sWXQGc5cUlAlJhDW+nxMvdPVFmeAf8HpPl7kDfKL
 BbzJjvP8+f1gNBfbrgLcZoX0fY1HHWBg8DTHKLXKcR5Uxc7j/1U4BvplRoitf0jHX9HAwyV4K
 GIGeyExfHicyk1Eadz0Mihjshltt3v8MDLY1sPfWhzs6jzVR+guNnijtbinaiKZzVchVZY8CK
 Vh72UwiVl0IvklzlYo1HRiauzsmpsutO8m673QbTSlFUxlCnr5sQCQ08i9PP80TPbNRSo0Gz7
 /dB+rjFq6g3eSphjnUVIknU+Jm0KVQ0JdL79t5kTUnxzo8HrE3/3EGqolW0B4uOSpSRkD/Gzk
 5umlzV1bFQoTE+VBM7KjBzsx30MMS3V4Ii/WOrTm0dk8WS947iBBk9cy9bKcwn18GpTm5Hnbe
 Od+VCO2zuH8DBKpAs6zEOMbETkIBXEV2oZn/Q93Avk0dvVvDWyFSUe3GjMzZBXG8MJVCSC2PG
 zsRrbHB3kuPdzP6srRCEpIXabI/31NEENZQvgtnts24kGoX2K92EWyr3ECzsTPKzFiIwcVf+M
 h337aos4f7StxSzFyEPXP4lsSf1reEZOudG7HssxwW2h9oUbtNVRu2AOo5ex8Stt9o+76K2Vt
 oxV4Wti3647ijantUjFpEyZ2YvrbSTYev64wcs/VsGGRtYpK76puf5FXXcj4wMKs9oP5No8nR
 94TSMOTEI3Qvkt4V9v1jkV4IMNBPkj8kTZx7IJ2XYBcP2xLcu0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hari,

On Mon, 9 Apr 2018, Hari Lubovac wrote:

> I don't know which party compiled it. I'm pretty sure I downloaded the
> installer from https://git-scm.com/downloads, although it might have
> come shipped with Microsoft Visual Studio, which I use.

In both cases, this would be Git for Windows.

> I forgot this detail earlier:
> 
> git --version
> git version 2.16.1.windows.2
> 
> I'm a little behind; maybe I should upgrade.

It is not quite *necessary* to upgrade, but you will get a couple nice new
features and nice bug fixes.

But the bug you reported is still there ;-)

> I just reported the same here:
> https://github.com/git-for-windows/git/issues/1623

Thank you for opening this bug report. There are other bug reports
describing related issues; they might even be covered by the same fixes.

Assuming that you are eager enough to see this fixed, I started describing
how to go about building Git for Windows, where the code is located that
need to be fixed, and how to go about fixing it.

Thanks,
Johannes
