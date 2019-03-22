Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B783120248
	for <e@80x24.org>; Fri, 22 Mar 2019 12:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfCVMrM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 08:47:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:45371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbfCVMrL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 08:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553258829;
        bh=EZXS7uvV4aiXihWe/Cn5u4S7kXquIgIlLgYxRNGhniU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lVogY6ibLanNhFKLxsgTSPQefCxAWQgxujrS2z6CAGKm+ckz0NkWqK/neaR+4jPvP
         1TGqRhLOceMmNhhW1J5PC2F+MFdH5nujZOstRbUeN8Gzs/OuAqQZBONF/5H4yGnJmq
         84y1tvT8qCfzb3I2+tYP0fEvSYRImbHPvZjGV30o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7kwW-1gl5pd1eTo-00vQWr; Fri, 22
 Mar 2019 13:47:09 +0100
Date:   Fri, 22 Mar 2019 13:46:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     balaji marisetti <balajimarisetti@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git command history
In-Reply-To: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903221343090.41@tvgsbejvaqbjf.bet>
References: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FIgycDNB8FNUUvKraOxnJZsk0c1Mz28qvCSRSqml0Nr7QSGmkvd
 073ahP32HT3OBlg29Y9fJ0e1HgsmMQ4W3t4NVDzAMkkpinkUySKzB93JDanF+12df0uSnM3
 CWLhOeQEQH6zsVFOCjQTCvr2Zwl2qHvvHNk7emcA7Kk/k0iWJRs31Ujxaim8EeNx4T+uf03
 fZXODfws0uV3NDFD9mzkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iOeAJ/i+/CU=:frC/erlzQfBkyor3L3IYH1
 wiQF3scNW2K772EKvp6hCGk7DL2PwYJbNcOlWGoB2w+bjBcrMqRDzEecelLcGThfuuyVvMXCl
 WEQE2okjg5Vo4RaDyDKETQ1vs/ip9dSzbY7G5lFqYDNfQfMTBZxY6dw562P0jXguCvOIL4jFU
 0b5tHnMlz6qu8fmlC5k032yo8AqshsKnYXirx223wWqFj4hTebLgXbLAv8Qt191/lJeU4ofkU
 N3ICXeDDTaK+n/WK7aPMdGY3Z4pZ+XwX/zfarZSzClXNTArTVyJ9NH9l16xccjadTBxtJ74y3
 LUL6PUrnYXpdrbWwo8Cict5edSGjiGuapcBp2O0BNG+wSiWDO6oySqO2NtecYxX+0FitxTvzH
 bV118C9nUNjbY9b/6ZJkGxoOl5pYRYDchWZmwkxeCJvr2RhChdwsr2OfJL+LnFJDbjFNqxkFY
 jbZ77iac4T6Ysr0iy/Zt6VzHZuOEy7eAyj29lAe9fSc0adW3Ir9HTZQ7LtSqdMxL1sPAW+Brg
 5FrF5p0ESqdA0fibEtyHaLdvz5n/PDb/vdW23XWA1uXt9Ql17BW3VEccfUxOa72PALxZh27Vf
 Yl2YsArubK6sL6ogrgo0t60XJ3AbFqIB9MzJ573qmbPtiVH76ShFuSh1frppUF45IP+78Xc+s
 zlHNUVDJu/oW/W3ZrkrqncfNvPcXmU6uwiCUXEXAvl2pH7fKwU/F0sGr93puKOnKBg6jzC66/
 LfU7GkX+E99pHiWj5Aqs7PrTbfU2P7b0SK8uZ9Gr3hj5eKVTk99VMlf57JWr4kaBUUZ/HoOgA
 k2gXwAUUFtVdvqJ3rQSZ9Y7Mt6NAY+mE7nWSklY3gPMtH5/va15IJM0zIHt4SGmLX0np9EMB6
 MGT/8DbJux8tqe68K+5GbHl2GT3VL87xDqNoDAIbRc+lfgAwjVRfHVl7AdQrLmKazbwOcYUA7
 S3Qs4Qsq2TA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Balaji,

On Tue, 19 Mar 2019, balaji marisetti wrote:

> Can anyone please tell me if there is way to see the command history
> of a local git repo?

If you really are only interested in the *Git* commands, you will be able
to implement something on top of the Trace2 feature (which just made it
into `master` but not into any official Git version yet, so it will most
likely be available when Git v2.22.0 comes out).

If you are instead interested in all shell commands in a local Git
worktree (you probably meant the worktree, not the repository, I assume),
then you might need to play some games with Bash aliases to override `cd`
and reroute the history by re-setting `HISTFILE` and then calling `history
-cr` or something similar.

> If there isn't a way, why hasn't the command-history feature been
> implemented?

Because Git is an open source project. This means that nobody is
responsible for fulfilling your wishes, except for you. And you can do it,
too, this project welcomes all high-quality contributions.

Ciao,
Johannes
