Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8095C1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 14:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeCMOAm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 10:00:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:44045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752598AbeCMOAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 10:00:42 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpbfG-1eP9UN1aT8-00fQHr; Tue, 13
 Mar 2018 15:00:33 +0100
Date:   Tue, 13 Mar 2018 15:00:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     sig-scan-admin@synopsys.com
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Will Coverity for FOSS be in scheduled maintenance mode forever?
Message-ID: <nycvar.QRO.7.76.6.1803131457310.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:35xSkiMqriagWqavqTk8wwW4xrKC/wQrIbKXbBs1L+9ggfA42UE
 iAZIOsmUtONz9uG2r18RBBWbMBsfRXCwIulMIJ9ohyfJcAOerHoiDtTtr2Uiwpd7wISN4nL
 7s7mCSS2/Ej5oKA29rq9D1MYdcfOKTmZkpG047AD2NUJv/Pst22DInHYvKaWYfR2Ks5RGnR
 YJfh9kDDYZ57P4zt+j+IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pucNag6AALQ=:tParUlnmkVsjQhVivS+2qh
 J75CC9I6v7z1K2eOEAvWUi19mGWlfdrEz3b6DVE0E1vVFTYAnRddRTNsOq/zzvP4F002VtA+H
 s/YeGqOxEip9O6J8N1m+hob7Y33EUpVIinhrsdZ2r+Ttwe8gsesv74vgTRBRCcM0alYL8noWS
 9mgXyMEpQTXKNyTYvymLotA162ILqtFYDy+ZbCcKKyuiHMCeGlYTRh2R2Abrs28nX1+MZfyzB
 XI6Tqtwh1U5kpNoXu83vjEfpjN3sCzI2CN3WcS+4Qe+aVSCVgZshcJARn7mpI7xSsB/3Lvuf5
 YB5TWH8Aihi+/+Jqd1lIXM4fFLkPg8OpKtqhmEZd0A0pRFjrr/fCX7C2tuWe+sECPfFGkyu0+
 r5Ck9LRqNSR/4eicRmSXIz8xtF6CxYl11a5hFDi5cwjuRipkl+72F3QxTrCvPUtFeFRvRqRzx
 TeAU/tUch4D0oKi2YCgpEPYQqgfq8UmkFkqayGYfsg/Qsb6zY9g4MYMxBw7xyoInSX17jsGyB
 oMkBHl/yT4O0cpkZ7HWJxP+v/TApnBmN8C+A/DOKITjyf1OOoXR04i9SLEn854VdnjRHo2rCv
 cmaPFpAHSkRFPtrLbEfzu6xEtvWoee12uOmWV65PhM2ZOJlrygmV+5H3QGYW1pdoIKkf6DjKW
 kOXKOYfTtEXCnuhi64TdQmOAUyodZIHy3qFo69AvkgZ/rVwUCi3/vBVn4ZFHLH9t/Gb9NqBZv
 0eEK0enf6x25+CGaUUoxOVJ+oZbA1vcX9YYT6jmIG71BpvkcGHeL8078pT/LK55SC+Ypr3RjS
 CjZQsc8Tz3sCyPe2Fm766Ab7hplovPd03G1mUSnjakb3Y7ZEvXScuMZgY6rXhVu6fLjzu5+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Coverity (now Synopsys) team,

I probably managed to miss important mails such as announcing that the
Coverity service for FOSS projects would be unavailable for some time.

Since February 20th, this seems to be the case (all attempts at even
looking at past results redirects to https://brb.synopsys.com/ without any
helpful further information), at least for the Git for Windows project.

Is the deal off? Or will Coverity for FOSS come back? If the latter, when?

Thanks,
Johannes
