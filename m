Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C728C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhL1RJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:09:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:56659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236046AbhL1RJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 12:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640711358;
        bh=Kra+6rFnQS9GHk3HQBpSApBIi3AcX0R5Ojqa14/8pQ4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject;
        b=JzCJgtgNZOtdSkl+cJPbB+SlAlwGajV1O8kih1ruztTdOOqZ8oJud3N3xEiXhzMLY
         PNP2A8bNwQ6PgmZl+xXnWRIsDdph1z57g6X7EW3dYQWfF9w7zu+bsBmW2CMaun3RSw
         0MYO4Wv+hAL+QQYROysiJDBvvJgCEHOrW2tw+3qQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1mhZn43Uj5-00Kgg0; Tue, 28
 Dec 2021 18:09:18 +0100
Date:   Tue, 28 Dec 2021 18:09:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Congratulations, Junio, for maintaining Git for 6,000 days!
Message-ID: <nycvar.QRO.7.76.6.2112281806440.347@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NC0UAgOpor94SP6cKXxOvc4pCiLiYkuenA5zqQ9bo5j3+YHWkvi
 0cMPVWOhzyYiiSQIRSYyanD6aQvjEv1/YgL2bUpXsVulq7DFEpartdDL7TFyt75s8mfQalY
 K0/y/BeBUIz9MlZAwWfo38YW775+fdwBFFmQmIGhWxtGTbxd+1QRc0EsYhzm1z3VCkmchjf
 e4h86iu0ZE4k6WGna6vsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4qLR5LNb64o=:rKgV/OMjTkn+SjHyf1F0Ul
 6SxcGPKx8ZdhX8Fx54byjjkhWCMzN8WOimUHUHnUXYkJRhiMBvQ9A2/ekngrs5U6TK+73fmnH
 WX+pi6rvu8ho+agcAHVoMOEWnT8yi+mHggzh0C7PZrBoCVrvrL9i6cVVgsR609hu4/n93kuPU
 ATg7zDvp2AFrJwOCVH8ozxNGYwsSL19RXdwsKR3BtBWdYdEMqpB8OuXh/ndv76EoSdoVH1CGM
 d1x8vUF1pU5/M3Xjmffyezqabnfhhtob35yXz6cHk7T9Mmb7JS3hNNKduvVozrlRF281mclPa
 pSG9zUardXc02xAWXthuTgwiuApMxzLDX33qKhTG+++vpYwGUpab0+RLmcmJPkmkvdBCkD32c
 ZWwqvLy0U1SPya0AJqEqKrna+WNL5HzBo0E1mptPTgicmiaWgHfaKmJNVUKpJFUJquRD2bC+y
 1fDqrsIROiuwMUeIOhdSSBl7EyVDriwn2UEZwHbhVOO0fFMsqC3V3vRsUJtbQIePLjEKMGMrB
 IxGeuYlgjS4gWqN6UrEEBhT5TReAXLZuxJB4Vbn1sJNEEp+HwcFxdQl9zBJYBAc6rjv8D3YCN
 lVCtr3ckuPSt+Il0Pqj7ZSu/+/f8F2Ar9aZxmVvJ5aLoXBiDqy8gTwSeR86lNiEnZt3zwzbqW
 mqycIDjmhLwNfKgPvOnx3W6wG50yY0BLAZt1mLaZSCRPejBGtNBDwzw9VBfmo2KXx5EwSeNEi
 ssKl4YsCN8pXldw5zcBTYPkvE5fPDbs+E8YHcZulze996V8VuM+epuPOie+9sLek36vrLdjSg
 umNfQ9TEeLptohrs8z19SY/As94te71QlEh0oDwU6bxSNRSgBSfJ+6CdcSRpyzs6/PqLc33F8
 rX1l9OCnrqvBm3VCKr/P1Zlj49IhkURyFW/NLTgXVjMcVgWkFNrzqwKsmVSOdigh2dt4sBvij
 tur7ChljsiNQWRi1rz9WM5HACC1XxmDp07FRdWi7eIY0n5Vqz5h756maNk+uIyMwXY/8TlRuj
 I8pwnV9pGo12PyzvT+FnRJAkLyl6tV8Gy8JBtPvqVzehshLr1gMAPRZcPqvN0Bc575JxAI0CV
 Cb38ILmwv6qUxs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

if I hold my date calculator right, today marks the 6,000th day of you
maintaining Git. What an achievement! Congratulations for your patience,
resilience and tenacity.

Ciao,
Dscho

