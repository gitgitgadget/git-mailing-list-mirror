Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93ECF1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 14:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbeKOAHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:07:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:43099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeKOAHb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:07:31 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkwpt-1fn37h1Lwj-00aoUM; Wed, 14
 Nov 2018 15:04:04 +0100
Date:   Wed, 14 Nov 2018 15:04:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Tanushree Tumane <tanushreetumane@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
In-Reply-To: <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811141456590.39@tvgsbejvaqbjf.bet>
References: <87d0rm7zeo.fsf@evledraar.gmail.com> <20181113155656.22975-1-tanushreetumane@gmail.com> <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet> <87zhuc1xcx.fsf@evledraar.gmail.com> <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1089416645-1542204244=:39"
X-Provags-ID: V03:K1:kKZYCu0b1OIEuxut/NKk2gtS6HeMcJjrmWoW6hwrzZOJlFKP9W7
 alaHdmLhOLD0RrEPCkj3KHhcATIiX6Rf+zUV56dZkCzHAU9EYr6AA7UX7TNQF8zJ755l3mq
 3Fj7aN0vkTPLNLIi2ON6+Hvfvs1/ejAEbw7vt4UBMZmw1r9V+LIbpOQ9UqW/3cTiGiYs1TW
 aPTFVX14WJZq8+7DuEU4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KHV87DrUUos=:P/Yey4Yn5EmMiKakYmvolZ
 gN+mrDGCFZoyZ95xmzI4Oq8bqgbtMW77BHKhOSGf2QX9bS0aL/pr0d6qiO34op2fUOPM2uoOS
 HwbFWh1uOsJGvVAOthVcxP/2yHDKjk5iEE/T6qGODNKA1u8aa9oHrlZbyJsx0q+oTBr5XRsPa
 9/69e/pKumgyKkWPI1SfrufmIv1vSPuq6TQg1xrdVZUBJDIBSPaUzX3eNKC0VVyuC4PEusP7w
 wBJAfReEKKwgEbIRYNu/8zfj1QuBgrD5FFGbrzovMX7KISS37H6tXnZiVGhIhTF8S3y2aTaXt
 qb94GYLh9bBrTHu1bK8wkol6zlkGoRosxHFx+HZkglZxqCXpSy2pRVsherWe9b/A/apZt5oyF
 f2FttyfUS/1Emmbw9SXpzSZlc1ZhzWmuuV9wSp6ZCft14sK2lq+cqXcaeqIkGMYrRLB1irdNt
 CH13rLZMGGUFUSTU3+4zI6V1tG9iTp/Oo/R/248fDC+6HslojZ5CnAFH3jX4dxH1RWemi59Zk
 QuPRHs1k4izhoz6zoRexiASCnVffU5UmjGRQE1FS6F/ycUuQ8psGOG+mSvrxKhfBRYapuVrZx
 2UM0WWyg64UwoV15Yy+0Ayo70j2uqAAny4vvttPjCPUpbA66/+ALck+fYWKo2jcS2STX1jtOA
 nNR/89/uR7STNVaPk4eyfsN6moQysfic3w2Y8YsZTMyjqi9IcgsYLessYN9iMOU+0sqCGREho
 +cC8OpmzpbwOM2cBPpCGrwdfgJCZtZoCaWhHldMdVirpCB03Skz6w2XXzBYkNLujZYH9zql9p
 3ACsd51eMpQp/jAWsjOd3MV7wTJlKmRZ3UiRRzW6/wd069S+zXwMPOUgSwiqsxYJ8N5nk6CF0
 U1i5sVHk6DWJnbNeq+AEzXRr9LcUHaKD4fIaSSZVUe7emt+AxTT+w0qNI32Cb3C22CTMQPzY7
 n/bwH8W9U/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1089416645-1542204244=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Nov 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Agreed. I'm happy to see the test for-loop gone as I noted in
> > https://public-inbox.org/git/87d0rm7zeo.fsf@evledraar.gmail.com/ but as
> > noted in that v3 feedback the whole "why would anyone want this?"
> > explanation is still missing, and this still smells like a workaround
> > for a bug we should be fixing elsewhere in the sequencing code.
> 
> Thanks.  I share the same impression that this is sweeping a bug
> under a wrong rug.

I agree that the scenario is under-explained. Of course, I have to say
that this is not Tanushree's problem; They only copied what is in
https://github.com/git-for-windows/git/issues/1854 and @chucklu did not
grace us with an explanation, either.

Based on historical context, I would wager a bet that the scenario is
that some commits that may or may not have been in a different SCM
originally and that may or may not have been empty and/or squashed in
`master` need to be cherry-picked.

But I agree that this should be clarified. I prodded the original
wish-haver.

Ciao,
Dscho
--8323328-1089416645-1542204244=:39--
