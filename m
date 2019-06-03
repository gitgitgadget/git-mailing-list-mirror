Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937F31F462
	for <e@80x24.org>; Mon,  3 Jun 2019 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfFCNno (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 09:43:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:41855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfFCNno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 09:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559569418;
        bh=LxICViho6oI1kOVnQFHyElLfvYqjbTq94sKkebuDOX0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aj3h1Nd94m7zzKPPa8nEva4Fc1P1VSD2v/8rrytrT7qHnJXeeBkWQJi1vbvXZaBD6
         2+0Y4jva4mFqmaL17KzHaqrq5ByoF4e+5xo+maOrvQWppdymlcwE0tOsW7ZBAP7+51
         9udTsO6nqC/qH90NgR80yDx6njAdxrupKMFW4YyY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNw0t-1hVthp0F3b-007XcR; Mon, 03
 Jun 2019 15:43:38 +0200
Date:   Mon, 3 Jun 2019 15:43:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: fix typos found during l10n for git 2.22.0
In-Reply-To: <20190602151122.7512-1-worldhello.net@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906031543190.48@tvgsbejvaqbjf.bet>
References: <20190602151122.7512-1-worldhello.net@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HaY+0b3TO1wIQeZFdlpHlrZB9hWfgVvHCJ5bJY2O+WqRLm2gSI7
 PW2yTtHxil+K+K73oVHp3jtmVLJbEaikkl4cCwBbgUhqI2dV7NazRs74RcmLL613i8HPHb3
 YFkaCrV+NkeBUnkZ1wBibxuNrZ9Xqdbbz1lT34495WSGhUciTDZ75kabxXD5yGauY8tzP62
 Tt5XUOeQKFy+EQuvGEMLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aC9pykDkr+U=:7BOgsia+SSQqGw7QmYdEPm
 U+dw7VSRmtKSPb1OQSs36u6qhs/cq5sBHePzy+yRp6vVq8heqrl17flaKcmjKl6l9LxMTbD7T
 j1yrV8hCCWk5s3Xm2Sd99BDol0N44r53h1RqzQyOlvvS2Vkha8D21ohd3AF/xOcbNEiBxSx1J
 CRMiFzisuDutxSF7YEf/biTH8bdF4g8f8xkywbR+vS8HuDDIHP52jNTvW6idwa4XvLZPFba2T
 3z9ZtwaY0NL5gZgcSvcH1AHbSKamJh+5NdTH68YCSlIgc9IkA6TY/rwNQ8s9rTkXT1TvGADa4
 V3Ng65jFA2iahgMscOv2R7vArGh4I0J0/z/3B2eScn5bP9YY39m+pVXU0qMu2Axl13MK207/y
 KzgKzuZbR+wlcqGCMc3pBLlzL4efnsVx8VtbM3RmcbE2nYQFMRLHlmIvmkdfIl03ii2YDvXlb
 y/xPV5HVaoAknX8KXsHsp/m7T4ZLT7Vb9zGZD8nMvZh1pQrdbOJ+MNzBMelWPBQlNPFd6K30z
 fzwAa5GlZFxuNbmDXKe3xK2zDaSRG5/W7ZM2Rr0mJVoIGqZNtr21cjdORkfm20jjkbOugmLc7
 SCVk5ilBld7BP16PdPlYq8A+BQ4mzyYgiBYXIAR3ht1P/J7qjuugHGs9ZTnEqKB/KirwqEWHW
 kcIKXBnsWjhyibv8p7s8tdG4ogZ4DuyEYJV0d28Io3iVzrYBw+NpfOereLNL1g0hU/jH6hFrl
 K/RqvNjrd/3W0bYMB4FdJ1abhykECDJN257ebWeofob7ayvtTUirLOrGA4mBnmRLgdZZgSN4E
 M1xsfzUcBz9098xIABCijmY/WiFfYrIjCjp4TxbP23Va3TEzemUWH0ohyUMECyV2mX0wv9bYY
 eJlWj1t3dMFR5uNZPDklb7J9YKaLxUV9cNAVaBRcXk7RCTEYUBw2uTXeaZOLnpByrqwkbGvzU
 9cTonTLq5MHi1LkW5sd9s1nlTWrOo80BkQugeDYc2ho3HF/iAormd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jian Xin,

On Sun, 2 Jun 2019, Jiang Xin wrote:

> + ed8b4132c8 (remote-curl: mark all error messages for translation,
>   2019-03-05)

Urgh. Sorry for that, and thank you for cleaning up my mess...

Ciao,
Dscho
