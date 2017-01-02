Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537771FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 10:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbdABK6Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 05:58:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:50012 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755155AbdABK6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 05:58:23 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8MyE-1cjdk61EyQ-00vxMf; Mon, 02
 Jan 2017 11:58:20 +0100
Date:   Mon, 2 Jan 2017 11:58:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "M. Abuhena Sobuj" <abuhenasobuj@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Error: could not fork child process: Resource temporarily
 unavailable (-1)
In-Reply-To: <CACkJq_gQQURdyUf5HvSqvw0Ee_yjCnFZ0DXJxZt42JOwEOd2tg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701021155350.3469@virtualbox>
References: <CACkJq_gQQURdyUf5HvSqvw0Ee_yjCnFZ0DXJxZt42JOwEOd2tg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vb62DEPi/BXs+a+k+JDDSSg8Yz6k7TXB6kI+4B9tlMgZPJqWcoS
 3LB+0hqTDMuXNNMuWvalXdHdAVvgwbbXXrgywadnxvJQGJ4IumFWRVC0CoTKvJgmPfamoza
 eddGNCuwyfVJLU4YeLJgcf3vRq7KmqVqA0yVgD0/bxdy3RT8ThFctzOZA1EkyxVxXuhqiHv
 iLgmlMDdj8b7JElMu1MHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5lEUVoVqUjA=:T+KQUJEPcBQx/ROWhcFRrv
 O7LS5vP40AtSsV2eeFSWE5MbKvsmlVS5yvGMxAkgaUfFy61we5ulCWlCdCnMKcaH+L1vU9W6L
 86+UhGyVQVBRvX2l3dUkOS55Xexg2jH8BTllu9xBIBv3ICuHhBfUuX3WpSnEtLUOyEDlpxiOw
 8vizGiP27IQNcZJqJYx9JvsKfqXMC8cqWak1W0MF+3uMSZHT4Ldzrv7mmhplPxNLGeMS41QTb
 rPB9FzqRDBG7bMonky3uwfCjkKmzAPWSgdggYNkOWkAW1L/CDFP8GOw5o2D/QL25EFV/FItC+
 o6HNI64SmuICh2zRAeygkaxe/zgWhGZAIj0ZCEvEWkTuUUYO04XNHsSpVUuCStzaoJya5wvru
 OpbeNAlcUAz3ywaxuhqmDK63CSBd8IXaVIP+tNuODqb/hGPhYYurtUUmzYk+CKN7EOC6uXfVM
 CQ/XRDAsyjHdQfIMgvyEvKH4UYWnVuoTTmH9FkfRrK/Ehe4kcmnPxL3P+sYmXwN/FZUjJIvPE
 20kA2BeNvipdTh36Hk8jAZBWVOcsdltef3MMKgsp+O7pOx9cXL0GIlDCdTg4FoT29n9K7CI2T
 gOFg/TsKToF6ORpOQUF5xk6j9CPXmxaA0ysO4NBXq/j9LgjXCSVKpQyGGmq0PweXQFTxsWdkl
 zGQQWhALx4rjERRhoXEAY3R36cA88M4Sl0MW9Dlb0+PL6pxIEIaFQVBfZNrZK2fgtQkiRJ3CD
 qRkBW3SoXJO/OfHvyXuvOXa7HDg7v1zMf4mrDxsQsOoY+JaZqipdTO90Q1kC2w/+PSJr6vfhW
 tdQhymL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 2 Jan 2017, M. Abuhena Sobuj wrote:

> My Git Bash was perfect but suddenly It stooped work for me.
> 
> I just got message
> "Error: could not fork child process: Resource temporarily unavailable (-1).
> DLL rebasing may be required. See 'rebaseall / rebase --help'."

Is this a 32-bit system? If so, simply try to reinstall Git for Windows,
that should make it work again [*1*].

If that does not solve the problem, you will want to open a ticket at
https://github.com/git-for-windows/git/issues/new

Ciao,
Johannes

Footnote *1*: https://github.com/git-for-windows/git/wiki/32-bit-issues
