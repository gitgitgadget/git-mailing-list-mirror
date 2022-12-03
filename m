Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F49BC4332F
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 12:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiLCMCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 07:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLCMCr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 07:02:47 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44C63DD
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 04:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670068961; bh=H36KaFex5BZ7UlNqSMMLxZarfHZaYBKbahXBTyfYcyg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HgSXJFP1oS2EDApLTOhf8VCt8+NQCIckkroSC27WyhlXNgdwOHgDg00v9Zl7T0YZs
         4RHCWad1orrkOEVf9W+nCcVRHw56jDqopbcHxef8b580mmYlegdwRPgI88yYrWwMfm
         vyD8YrzdCwfJeqtA1hd2Lcr74xGvZ6aTiOOJx0ReItyIbTZ8+7WwYgOiyUXJ/tYNp4
         GxE1YuJS6N3hmVjUMzNbcBe7tv/vAwkRYTi9mxxBicaRq5VMwMHTQuUbbzUFDi+Yc2
         faSx+hh5fobWNciFoflvwrDyTfDd8TzgmLz/xxZ2l0Xwk+UtDTw4cGgihCvt8bPJ0A
         2i1gQY5qSsRMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j5k-1p33nP1jlC-007IWN; Sat, 03
 Dec 2022 13:02:41 +0100
Message-ID: <d9253ae3-9fc4-f426-a737-792bf158bd4e@web.de>
Date:   Sat, 3 Dec 2022 13:02:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: Pro Git book URL on https://git-scm.com/
Content-Language: en-US
To:     Aonodensetsu <remok99999@gmail.com>, git@vger.kernel.org
References: <CA+vVMe_pUgGSGjapf16QP=DjLC+a1MBt=YBq_SkOM6NUoh2U2A@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CA+vVMe_pUgGSGjapf16QP=DjLC+a1MBt=YBq_SkOM6NUoh2U2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+b5mZqDsJZOp1Qzj7EylgQ2FJ4dVF+qWSYzZv2EUvcWJMf0yCJO
 7QU08t4z2hn/5lLGxaj7sgh4F9IuMKASjGJpn72RieCVSS8XZe/JeA9obs9AQJYirnd59SC
 hNH/MrbTDD8wgna+3PoPmK+mOYlLkkJtsQG5O8RdnWpB7xcs0dlEYm5PE8+OR2Dh6xVSNKz
 CNRjE8q/sRSqET/gMf3Tw==
UI-OutboundReport: notjunk:1;M01:P0:qMZ2Pd7tsd8=;SWC44JqxXgp+0gv7f3Ib66IrgcA
 PjRoqgMHBMupdJi6FP7wzKpaQz+K1J8cDSCxGqdIgaMzgFBVnOXdlw6UDXdqx+fV3NHIpZeDr
 AHaBumLp2OLUfbf7UEF+EyKEE2x0U/LGhBYC1rbNzVsecWsngwPfQMGikZSW4E9g6ttBkoLv7
 J2qntODtbnTy+WAZaShzTGpXLhnocI7dPhgF2IlQluV/xHGsBgGRgINtjBSgfy/2bVOccXAuS
 7SSi1cm4kj0AVG9vb5CJvNK6GEIKAgz+293blo2MeH9WaVauYmiykJAC/Tqq2B6OgYJKriW8/
 0ZyF8skN+dBFIAN9xlA6mXSuHBt2Qun/T4n3OBGm32Ukfi+CMUPQvn3eSGRJh4Z7Uhl0V7/Gr
 7m5jT82LpPvFkOUqivMDlcebZ6lhpAviqd8kJbrL9xX6ESZgn2NREbThf1ALjvNl4K8nWw44c
 5+WmHFnLr3DFg7eO48u5UEnlZid0UHDw4+ihOQnx+ZJioyNDjmYzmv0kTqVPlfVkZdZPE6JCp
 0ai2KDMA8M0nRtr2vgNMEbsV35bmHZWDG+PUePe4Czmoxkes4k0nQgO2cce8ch//nibcnQCPl
 V36QuYVuH/Wve0aZB88fw1swmfgFgnGdRSoLylUXo0ah4udZakP7fQfIram4CfQjZ+kM1haea
 p33fUGkdYrFHNTKCwVRco1zbO2ysIZ824wv+lAlEPouvpnC5moaX5Txvlc9dS3/d7kkIEGGzl
 lbNI5/THlQcZU1oHRQXVtpTlHAGste2S0ly6yL+wsWu6Ev7b6DL7sYYgrJS6sK9B5AsQD5hI3
 9xYGTvrtjbVP7iQvlz0UqRNVWl6DkgvIm/4dRGREWAXjaRzEWn/aeXEsL6ic2FF5PElgGycY0
 6LKzAqBC+WvbPADRbpdyZcmGKiSlNMfgDpArUliyoaGxyRD97rX2ce6iZaIXTHUtGOSDwM+cJ
 UN7evnJxFokS1EpsRNeLwWtEgsA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.22 um 12:23 schrieb Aonodensetsu:
> The Git documentation has been moved (probably by accident) to
> https://git-scm.com/book/pl/v1%20z (notice the %20z at the end). This
> is a bug and makes all redirections fail with a 500 error, since they
> try to redirect to the correct address.

I can't find "v1 z" or "v1%20z" neither in the repository for the
website (https://github.com/git/git-scm.com) nor in the one for the book
(https://github.com/progit/progit2).  So I'm not sure what's going on
here, but reporting it as an issue via the website repository should get
the right people to take a look, I assume.

https://git-scm.com/book/pl/v2 works fine, by the way, including other
language versions.

Ren=C3=A9

