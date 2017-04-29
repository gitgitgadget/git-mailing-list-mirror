Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE849207D6
	for <e@80x24.org>; Sat, 29 Apr 2017 09:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166520AbdD2JZW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 29 Apr 2017 05:25:22 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:35886 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166511AbdD2JZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 05:25:21 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id DC4152003DF;
        Sat, 29 Apr 2017 11:25:08 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.13.0 round 1
Date:   Sat, 29 Apr 2017 11:25:09 +0200
Message-ID: <3236444.6iDnrtGAq4@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <CANYiYbFPjHqjn-wdPUghLNZ2nsKggUWe3j=JwKXaYdbJqSy9PQ@mail.gmail.com>
References: <CANYiYbFPjHqjn-wdPUghLNZ2nsKggUWe3j=JwKXaYdbJqSy9PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le dimanche 23 avril 2017, 10:49:27 CEST Jiang Xin a écrit :
> Hi,
> 
> Git v2.13.0-rc0 has been released, and it's time to start new round of git
> l10n. This time there are 96 updated messages need to be translated since
> last update:
> 
>     l10n: git.pot: v2.13.0 round 1 (96 new, 37 removed)
> 
>     Generate po/git.pot from v2.13.0-rc0 for git v2.13.0 l10n round 1.
> 
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> 
> You can get it from the usual place:
> 
>     https://github.com/git-l10n/git-po/
> 
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in “po/README" file.
> 
> --
> Jiang Xin


In builtin/tag.c, the newly added function 'create_reflog_msg' is a sentence 
lego that is not fitted for internationalization.

Thanks

