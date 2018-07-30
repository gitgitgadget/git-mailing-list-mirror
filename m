Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78CA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeG3QXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:23:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:39791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbeG3QXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:23:33 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvE2c-1gAAtW2c1S-010IDF; Mon, 30
 Jul 2018 16:48:08 +0200
Date:   Mon, 30 Jul 2018 16:48:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] vscode: use 8-space tabs, no trailing ws, etc for
 Git's source code
In-Reply-To: <88952ba5-9de4-9b32-2129-1cc83999db78@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1807301646360.10478@tvgsbejvaqbjf.bet>
References: <pull.2.git.gitgitgadget@gmail.com> <2e880b6f1c6d37d0f94598db408511e0e216a51f.1532353966.git.gitgitgadget@gmail.com> <88952ba5-9de4-9b32-2129-1cc83999db78@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2saYFbehVtji6KeNnr5nC2BBwoSx93iK9aRmCTacoT+8D+6Sscv
 4sX7aa2CsAh88DnXluL4ge+BDDGStBjOrXfwxUez/0VqeFq81tcwl95ml3PBynQNvRAwXfp
 a03mvp5lgzc4QEt/BpFGCdUydL16sQ3gj2pPNCT0W56T1Jpz7IAbhn9c6vQxCLB9n/WRuWH
 IDXiikBO1m7nZhAcIfEfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RUgP3VYVBWE=:eY8o3Ht4p8K6AqkXuwiTNF
 0ranZ416nT6zxD3CWs1NAvvuYC6JIATWQwpEua42fBjUoSPV2oWVHbkSGBgtIhX+s3rwVAANG
 JKD8k0NU1SY1EgeS5opuCWlnM2t1lXWsDqsqOIbHuha6GHX09wxxgOu62snb8B5AZL+lr/2AP
 OgfoZbFNsH5OrpSLm/+nIPdfWvG9gnJTfRK/0GVlGRgH30WBTGLDlKR8Wj051ylOyWFzR3yHH
 2BUgqEONKL8OlNc3aDvlM97mDaoTTp9Mv0F+kpKcSyojNQA+sdXKcssdJpjwCQU1VCT5iOfjI
 D/xpOe20/NF/TUs+qdBIMRpMRcDTKF5X2BJvc9wA2H+hTDBLM1kc0A2XIPCBmFUOY01WwO5Oj
 a5F4+SNWiPjsSCbJmpvS81RB0C3vFvS8D6XscRX1XzlP2+bXuS48uZx2ntISZo+bQHkdnI8py
 h2soY4SdTQ4xwbSqfIxPthW809qZ1+/bLsNsdr1CFPOfnnKEk/CQzIoyy9+KfUs5DikDzYuaD
 PaX1w9f0XTQMGnX/uLVw99KQ87baqUxh6CWCe8Yfnx7wZHADyIjadnxywpp+REpEoqUPsRqRC
 s1W+qWlRK5WtzEPJBM6QSXhfqpd0FIFe2Gb4qfKOBAw+IzxkKgrpgOVZbi0YTFyEcdJ6KHymL
 YNmUiz0RNWMhlDo2DE6u7PbEMYDD7LOsxDn7UYiOaxxB6k/r8py+AS+LTXzCuh9NFCmKmIDgd
 DnvCa7OeGXukruEz99RLTkOnBL7uDSgc9DdtvOb6PEZQLnuKoHcRMevDp/LgcokwTpI/RAEid
 oC7b+d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 25 Jul 2018, Johannes Sixt wrote:

> Am 23.07.2018 um 15:52 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > This adds a couple settings for the .c/.h files so that it is easier to
> > conform to Git's conventions while editing the source code.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   contrib/vscode/init.sh | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> > index face115e8..29f2a729d 100755
> > --- a/contrib/vscode/init.sh
> > +++ b/contrib/vscode/init.sh
> > @@ -21,6 +21,14 @@ cat >.vscode/settings.json.new <<\EOF ||
> >           "editor.wordWrap": "wordWrapColumn",
> >           "editor.wordWrapColumn": 72
> >       },
> > +    "[c]": {
> > +        "editor.detectIndentation": false,
> > +        "editor.insertSpaces": false,
> > +        "editor.tabSize": 8,
> > +        "editor.wordWrap": "wordWrapColumn",
> > +        "editor.wordWrapColumn": 80,
> > +        "files.trimTrailingWhitespace": true
> > +    },
> 
> I am a VS Code user, but I haven't used these settings before.
> 
> With these settings, does the editor break lines while I am typing? Or does it
> just insert a visual cue that tells where I should insert a line break? If the
> former, it would basically make the editor unusable for my taste. I want to
> have total control over the code I write. The 80 column limit is just a
> recommendation, not a hard requirement.

Fear not. It is giving you a very clear visual cue, but that's all. It
does show the line wrapped, but the line number column quite clearly shows
that it did not insert a new-line.

Ciao,
Dscho

> 
> >       "files.associations": {
> >           "*.h": "c",
> >           "*.c": "c"
> > 
> 
> -- Hannes
> 
> 
