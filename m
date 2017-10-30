Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9730D1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdJ3Mfe (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:35:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:65243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbdJ3Mfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:35:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFi1J-1duaZY0LOH-00Eg3T; Mon, 30
 Oct 2017 13:35:21 +0100
Date:   Mon, 30 Oct 2017 13:35:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to
 AsciiDoc
In-Reply-To: <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710301333420.6482@virtualbox>
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>        <20171029211308.272673-3-sandals@crustytoothpaste.net> <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DrEqLnmBzTp5qqUJlDXyM4vyBXXk12JckFjIpyJOKoYDAEsWsex
 CEJGgIhwOZFXtk+9J0Qx2sTc3h27dB/mzJMmHZFDzWGmnQ7mbjLquaOjIG1bNeCq/hpj23y
 a8Qj8htXEEtxzWgoIO27opQf0MQI5UJWxb40n/jaNxL63dtnZhNEhiqOB5l8ePPXHaqprR0
 KoTsI+fMp9XrTvsSySRoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LB8qalaWx5U=:aCP+MqlXcLACWZjdTWF/rW
 kN9NKePylp2FoPmG97CgxpooNu+gjZkz4VZc2Pa5p+fcfnINRH3aMTEm4/oPu0gTKT5w5bO0Q
 Qs/HHtRTPw2mI5tC1ZB0ww74ocrpq4gJeYykGFf5B0kuSnU6Ow1aKj4z1FgMB34iz/Nxal1QY
 X0qmqBWx/z/R79oqq74SoqrT98BhmhERHkgf5GHY6CgUO8oH8u5i/2pjsmvkM7so2Hv3nNNrB
 sy1fR1A9ok/WiMC/DiZLsKIiaQg2u1GWEo3CThnEurAhON0sxZ7GPHo20ZadajnjD4dnONqeb
 5rpdfgS3U3sEoRuAG16u5XkFUKQq8pa33jAsyG95jKQKDBcZB8E8tizF62UYQPnD+gui4cYw8
 MTf8Gqf/D/wFWKqPj6xzlSF/D1/9LuigSJdcFvsUDi4KsZ9MGJOEafW4+Iz9c/JBrLdzNqZYN
 m1j9oqyL5MANP6MXJ6oPe4R2db7sVfiWP1yyrLCnkXbv9nFngKkGMlO1qNHsLcRALfndtkFPt
 ven2jh04aQD6Mz9XiBC7D0nFMvmEiqWtX5FySMFZIzP0nl9wwIsmUmoKJFY1zcIT09ZtyY5Jd
 86atozJHfhovuWPqFqSQszsGuWjjgnzLhoecR7hxYqXavcus9AiRmktnhDA8PRDWxzIpDpwT3
 AixVe3WFn72cncU9ezQXNwwM1vrpypOCQsdVDM/MTUM77foCgPX7fXXlcxh3ia5sg9a5maF3A
 EsPCq6TE4ym/fo5WTWI1ttoICtEH+bXAfvdvL02qIisFht2sKczQnWMdJ6DE+4Ss98DLUMySW
 Rtly6xm/mKgvDGXCNmDGeeWbian84nzLwxyxc7Ndq57uh/dRJMKEuiSiiL46AxBotWUs8/X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 30 Oct 2017, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> Thanks.  I personally prefer the plain-text original, but I do
> understand the need to have a version with ids that you can tell
> others to visit in their browsers.  Assuming that this goes in the
> right direction, here are a few comments.

If you want to go into the direction of the web, AsciiDoc is actually the
wrong choice IMO, and Markdown would be the right choice. Basically
everybody on the web is either supporting Markdown or being asked by users
to do so.

Assuming that *that* is something we want to pursue, I would also suggest
to move the man pages away from AsciiDoc to Markdown (using e.g.
[ronn](https://rtomayko.github.io/ronn/ronn.1.html)).

Ciao,
Dscho
