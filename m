Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0084B2021E
	for <e@80x24.org>; Sat,  5 Nov 2016 07:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbcKEH2J (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 03:28:09 -0400
Received: from mout.web.de ([212.227.15.14]:55378 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752733AbcKEH2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 03:28:08 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LbwKy-1cjiwG0pr2-00jKKO; Sat, 05 Nov 2016 08:28:00
 +0100
Date:   Sat, 5 Nov 2016 07:27:58 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin-Louis Bright <mlbright@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Message-ID: <20161105072758.GA15760@tb-raspi>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
 <20161102170415.GA6420@tb-raspi>
 <64EFD774-BA23-4FAB-8942-03185F447EF2@gmail.com>
 <CAG2PGspq34wn2bAGyhR6B-XmmayadmL-v3_65y5LJWTWNHXkOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG2PGspq34wn2bAGyhR6B-XmmayadmL-v3_65y5LJWTWNHXkOQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:4Qzu4FU9/dsntn+iNN01kSiuht8x7PjDGYsGXUZC+3QASNFQpMO
 vbrwxCjb7ucTHvBW+Tp0U2ho/CwbG+N7/NGLigZZbDqCftjuEgyEgv3RrrJYcIjILKXs9ik
 MULMEZvroGIe44aOxRuJlwyLAL6nsunr6l9Rsapnwat6ig2TqEZhaJcPd02990/4XR7AoKI
 ZJeh45mz1V5FWQuQw/pJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zJJEjwrvfCw=:jZK/ckuNanD9+bk2TRQg6i
 OeQ0O9daLyeNttTehnOzPXM6i0pMJICHTtzJw3P/bDEupxftiY4INY5L7Vp5fbBMc8Th5W/Fr
 FafJxEPSKY5I0dxx4cvMoA2LnAmSa0xyp5V40y3AYLYITdZ9OkLeowFyvwlwt7zFs2uoAiHDV
 LO8fhYGrmEM4k6cVG/a2PTdGTLZYTa6jx80pnffsmnKPpJoYVpb0O3XNNahNZlPgEGY7/G9uK
 z04XWj6RBR3X99Hve7/Yv4liLtW5FPnFZnrlqoO3Garo7SkUPyE9gFRM6wS3F4qdUh/slOqon
 jgvp3Am/fnlqQpwlLOFRcrYpIGZaYaz9hdZKA15KQXx+vwY5axerQVYZtO4ROT7u3mAYJ1Pcg
 WtM4HorYnhoBzORLag4CG/tTjWzpJcozCWeREl8M0RUj9Wdmeh6mbWAFm5+qiGcnu78bl9+Yb
 pwfjun9QGPl333Af7ZChuKtKpel6qEDxUKgYGJqJ0L7qg8YRbTXu4eH8+Iwo0o6JhKWslHr2B
 c61zE0ybZ/FGyKL890hZm5fwhrNG0gz8U03BgiBzZ2l0VyhIPb71iZIjcywE9NMpmTU+tBkgv
 AsSQ9a6Lke3P3DgIYvtRFRMlH4VeGrEExwkd7Io9Ql27odr/SZ2FhcyGwj/FMZ1s7TweWrPGJ
 MZF14md3iIxhcBR9rpduo6xBKQR+HTaus1HdEQHU37XqNeWzIMr9b8MuMYHILp3HJq8OAI5ZZ
 U6L7tjYLkITdMAxpHyHJGWa0Ul+j2tUrCOM1rPvVEWvGHQUuAfROttOMEGQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 09:30:44AM -0400, Martin-Louis Bright wrote:
> I will see if I can find a OSX 10.6 system to test with, and I'll try with
> perl 5.10.
> 
> --Martin

No need to worry too much:

I have tested Peffs patch applied on next OK- 
And the integration into pu that came the 2nd Novevember is tested OK as well.

(And please everybody: avoid top-posting here)
