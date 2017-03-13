Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F84E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbdCMVbv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:31:51 -0400
Received: from mout.web.de ([212.227.15.3]:55214 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754110AbdCMVbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:31:45 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1Wxd-1byrgN31ej-00tPX5; Mon, 13
 Mar 2017 22:31:26 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de>
Date:   Mon, 13 Mar 2017 22:31:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <ogwsaxvtiqlsiwojzxul@owpk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:QaSOlIiunRS/RHqKTFdya08dXM6kZpPPDyShv5q3dTEcDCrXYJk
 TxJd2t5e4uAkJ/e+ddTTPmxWOZ5vZRpDbbIazISn3iZhZ+fncSP3zZw6/pvGtWy76m5v3hF
 yy3zNE80ABvx2G1HjrOTnGOHE2ckKvgaaXpT9DLsvao1hr5LsESBumbQ57HxBY99cUqbNTx
 cOtio/QjX54ZnnGnGkbIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mpzHe+NHGTc=:Pj3a8eWNQ91t6rW88BIHjh
 nCiCXa2HdwgmrAy4oTIOZwznH7n6i9TD68KuEaxjMwCociqVU96/BxbcpWXTuyDQfSR9JKHZe
 YRPf8h4S2APN2LQsWQXZ3mwhRVGPYd9XJ7EnZJ92REPTSMoxj62VXDtB/hGhiOH7zMZPBvcO9
 R5u1hU4nza/kJWq/etl9ZckxOf+Th6olbos2F1waWJ+nwF1SajyKy0G4qbsB0c3IidbEZ5VDk
 O6Kf4PkrQrq3BoHTDkONC28mw3WGGFRWL4K1TczzuUJxJdAUCTUnPdaMM7mqyjf9xyQrunzDf
 Sx/THKrwA8k+hw6gfuJCBgPUfJ5oENELmhCsYzCl/3bwwtThuHf4wEVyTAorFLUXmf7jFkWUp
 MD4I6gklJun4w/Uzl9ojUfbZMLUxpwOMd0Q1CC7bQx0PGjGXW6lDWNEXACQTJ7YVMAgncM7SH
 uP/EZEuWvRnV+aTSwhg/8qOMMuPAatssCcFIZRYJY82f2ezsE0VL45Z3opBD6vrl6A53wXWM3
 b3O5/9904m8yElzpoLUwpbnLSrQhvZx67rc0cUf597Bw7NYMgA2fH5JycIkSE/azNh0WG26J/
 b4z69Kn0U5GZ+jLlYjOXzySa1HTcEsZPtyqmsExtqVxZsHYmxQ20vm1tjIC0GPTB1xFBCCSL/
 dEuo+ErcemB5DSAH+lidmiu9LQN7jKCkp9BmM4nTdnFozzbT2aGnP4bUsAaDKBtrDDxKrcGph
 /7pSE6O5cMNADuDJSayt/fUpuQSHtFC/AjG6ipY7lTwfHVbdIpWE3sLIZXUVmqmj8z8GfX/D6
 C/NpLC4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.03.2017 um 14:23 schrieb Zenobiusz Kunegunda:
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [a26bc613a64ac2c7ee69a50675e61b004a26382d] pretty.c: make git_pretty_formats_config return -1 on git_config_string failure
>
> This is what I found with git bisect

Strange, I don't think git_pretty_formats_config() is even called by git 
status.

René
