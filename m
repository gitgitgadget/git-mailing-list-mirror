Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB8B1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfBSO6k (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:58:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:58199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSO6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:58:39 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbPza-1hL1Tn1pvO-00l0Br; Tue, 19
 Feb 2019 15:58:17 +0100
Date:   Tue, 19 Feb 2019 15:58:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
In-Reply-To: <20190219100136.GO1622@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com> <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com> <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com> <20190219100136.GO1622@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-708649904-1550588297=:41"
X-Provags-ID: V03:K1:91yoKT34SsLaBg86r07IiWf4J0uAqcXIvHDakDgZIu9J7bj4Iij
 VhmA0qk1WipapBlQUTwnjnrw8EgVTGszDh2+pLlLcM+gDxvTuT1b2iWXK+6GFXuGL5/UUYH
 rUxVF1dNGPnnHKE4f2+86Kl0l2Tb7FJZHb5qq3qy5qAhDp+HEhcwbC4HKurjVAaJcX+N0cd
 yIGVH+sPqR21H89rvtGNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BTh9HMYnzyQ=:35ESIC1AKyelAPihOoTI7T
 hozpSkr+dNcZzDKJ0312FwAUePlxhLC2nRKVOy/T84YCzlKKWR0HgH0LGFtvGiWfFjzy2K2P8
 PHzJH4dJ6OudbE+r9hiENzeI7GVfdnspglqpk4EgvuGSesJtWgp1NVl+z/849a81GdDevifW8
 SnCshdVjudbZxpo4kgycPKSBu5JQj2P990bsMSyBL7//HW4t54RneI3ax1cpwNmkkOFu3lGnM
 bjShNWn+aY06nlYvehwdfjTTkpNH/tXRwUJ+CZSRJYrb/RedIJVpQUdbXE9q4e/4Z4TgHA+3c
 XfVXm13fT7r1soSMG/pcrd6sfJG5rwfWgqM/HIGI5xmOGMgodGKXtQqnqcwUwtgPuuG7JqJlh
 /Bgv9MTZsL22Kr5Ov4eCzegiNR3joxBiZP1nBnIyzMqPXuWc4rzqTM0D+gKWZZbzTXHUyJLKA
 Ye05FT50Dp9S3AHgpCtL1bkSo3+CgWenk5qWm4uPZWqoOchpKn9WSLyLcYFVlMca3zLEftIDX
 +VjLHKZy0+Ov0LVXT2Gcdug79UhFb7YHkxB1abdsEgDSW/O+P1/3l+nUA1hu0qtYyfdWfVbHE
 u43SU+Brnpp3B3Yh2Ho+zC1n5Wo1VgV9MBmhRdZD/39QxqlxHL53JsGjEWpjS31Ds2Jtpt34j
 a5K4GqiA2RXB7lqvyWYD1SGbAlmR7zAj6adEno7V4zXCuNpxWqMHQYSIMOMAGpXUMUuhm4t2N
 DmxZ6XQl+xPYfBiSgc+NdemEsfcIKsrkKuExEbbvEVo1BOI/8kM1ADhlGWT3/MQp+6d5Ujm2a
 PfQ75wDQCAqVhBPOtwbNM8NrYz4TlU53jSdLo29ecQNQiC0Mfw8C62ZF+5BJpjq4fV+tVRoJ9
 51hFJk78etIwxvaR1JpMFL4SsVg3CMwq4gXCc3966X9dAPOrb2RcizDwahe/aB/4x6eT//fOq
 S2JQzSYm/Xg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-708649904-1550588297=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Tue, 19 Feb 2019, SZEDER Gábor wrote:

> On Tue, Feb 19, 2019 at 09:02:43AM +0100, Senol Yazici wrote:
> > 1. Dictator
> > Concern: "Bad" connotation.
> 
> "Benevolent dictator" is a well-established term in open source
> projects, and it has an inherently good connotation.

It is a well-established term, alright. Does it have an inherently good
connotation? No, absolutely not. Every time anybody calls me the BDFL of
Git for Windows, it annoys me, to say the least.

And yes, when I pull out my generous self, I can give you that the
*intention* was funny. But to some, it is not funny at all.

Besides, in our field we had pretty established terminology for a long
time. It was the *architect* who had the final say over what goes in and
what stays out. And the respective team leaders were responsible for
respective areas of the code, trusted by the architect.

> > Further, "googling" dictator does not give Linus as a result in (at
> > least my) search (bubble).
> 
> https://en.wikipedia.org/wiki/Benevolent_dictator_for_life
> 
> > Suggestion for substitution: Principal or principal integrator.
> 
> These are poor substitutions.

I agree that those are poor substitutions, but shooting down without
giving better alternatives is a poor way to reply ;-)

Ciao,
Dscho
--8323328-708649904-1550588297=:41--
