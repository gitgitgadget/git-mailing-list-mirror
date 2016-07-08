Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F852023C
	for <e@80x24.org>; Fri,  8 Jul 2016 07:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbcGHHIa (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 03:08:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:64057 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbcGHHI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 03:08:28 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfTC1-1bf6SP0uvB-00p185; Fri, 08 Jul 2016 09:08:08
 +0200
Date:	Fri, 8 Jul 2016 09:08:06 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: [PATCH] am: counteract gender bias
In-Reply-To: <xmqq37nlqvse.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607080845360.6426@virtualbox>
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de> <20160707124943.GA22668@glandium.org> <577E580B.5090000@gmail.com> <xmqq37nlqvse.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nEJApASt0CHupqqB7oVOCU6Fao79UtM16A7F14UhuuJZGt08UxK
 zOAypVKgV/JauVWmTSUTLTcD0inTz1yT4CY619R/IcYoMwbTUx3QC7MTYcVEY49e7FlXA1h
 NdF0Z/7zOWyVbdRYfgNYNXsT3UB94un+lusQiNDZhbBf3wjGKULD5d8aOV02DLlAOdrlRxD
 qShNZbf3TI79URc7BOdmw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:IEBKP9hfbpA=:nCDPtclBgDqaSZNDSbvSX7
 +WcQTGEHWzWMbm9lpHEKMFSU0Sx+MRv1xgsxHcm9rblQPyfTg0WSSuLuRV97RO/lZpGKmLbKV
 q1lMSLYggxF1bq40E7HoATpcnO4O1sR1K1rdU9ZgaahRKJvSN6z72v5TlyeRByV6TzFhztOCT
 TKsFOd7D+wBwz2cCw3Wb0TsFNbj6gmSaGXSGENRVnzlE+wi5PhxmnB8eWjiPJnRD+aC/WCQHs
 1csmSCvcRwVCWspBjAy1VEF/OPC3tIByeNv3MVdaBEb7vd7j3lZ01Le0HXc9CNF8W/iapSMJz
 KVbxYw9NZu1qwCI2uCuvAqhn38NOQ9PMBMoWmVd7chuX6pPZJFZntWO2NM5ClrvhyeYUBCOVU
 Jhvm/iEq9cdum75R5OKcMc6treVqj3XrM/HundtArYW3IiPIQZiV7iuNRv8VLnBoZX+QMIGcI
 en+QvRgb0DwNKmsT9iWMbTXeTgXIz1tRrK/oYRh8DoKxD89U4aAOHIi0ut1Ofje2T1GEk3kw4
 EwjDyph5ETykid0CLlAYB5DxNsMjyuUyX5Cz0qCnBg5qM9e6yd2OxD/6QkxyMrFut7u46uHlF
 48FuL13GS963KCCuMko5COB8bnSaEvIyrGNdE1mHkZCGO1U6ATBiGH2oYqzXqzBUMIqbwreWO
 lxEQspGUo3T/uK4Ddd6YTSK+KemddVpiklXdX3DQWm0oyyY1rTF8Ssld1DngQJQEKyWQnueF8
 Higrg7a3KpV+s/JVdRJCw4wBYVKOTGeCKkR1jlCgIsE4ZUIC0txnjq0FCxL2oM5QSPaEv5j0z
 e9CnzYE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 7 Jul 2016, Junio C Hamano wrote:

> We should just use "theirs" to be consistent from the beginning, as
> you suggested.  There is no need to churn the codebase for political
> correctness to first use "hers" that everybody knows will *not* be
> the final form.

I will change the patch to say "theirs" (BTW "they" is nowadays considered
not necessarily plural only, but can be used as a gender-neutral singular:
https://en.wikipedia.org/wiki/They).

However.

I strongly disagree that this is the correct course of action. In my view,
this has nothing to do with political correctness. It has all to do with
respect instead. And I find it disrespectful to quietly paper over the
issue instead of making a bold statement (which my patch constitutes).

There seems to be no support for my position.

Therefore, with sadness, I set this aside as yet another concession to
those men who are really comfortable to equate "programmer" with "he" in
their minds and at the same time feel utterly offended when addressed as
"How are you ladies doing today?".

I absolutely despise having to change this patch, yet I do not currently
have the time nor the nerve to insist on my version of the patch.

Regards,
Johannes

P.S.: Having said that, I do notice that the communication on this mailing
list has become much more civil in the past few years. I am pleased by
that, and I am hoping for much more, to the point where we are truly
inclusive. It will be more productive, and also much more fun.
