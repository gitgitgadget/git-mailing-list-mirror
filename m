Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8E320288
	for <e@80x24.org>; Fri, 21 Jul 2017 12:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbdGUM75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 08:59:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:55232 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdGUM74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 08:59:56 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MGzwE-1dLpxw1cF0-00Doq5 for <git@vger.kernel.org>; Fri, 21 Jul 2017 14:59:54
 +0200
Received: by mail-oi0-f46.google.com with SMTP id q4so51149458oif.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 05:59:54 -0700 (PDT)
X-Gm-Message-State: AIVw111lVfkKMXjW//QXsRsHy3PvQm6lBO2lfOHq8FJArAr6ee89Of7/
        XDQSVqu1GqHDQPCBx28uPeJ97hws/A==
X-Received: by 10.202.62.4 with SMTP id l4mr1173935oia.109.1500641993216; Fri,
 21 Jul 2017 05:59:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.20.238 with HTTP; Fri, 21 Jul 2017 05:59:52 -0700 (PDT)
From:   Uwe Hausbrand <uwe.hausbrand@gmx.de>
Date:   Fri, 21 Jul 2017 14:59:52 +0200
X-Gmail-Original-Message-ID: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
Message-ID: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
Subject: fatal: bad numeric config value '60 days' for 'gc.rerereresolved':
 invalid unit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K0:5XU+Ryy3Tg1e3zfUoa+os6cwYtR7GYPQ4CnN0Enk9ibZ5z5wXmR
 BOZt296q5O66XkCP2LOo8n69etvkyZ/UV0wzNiHqTNF02JKdyqTxh9fT3pcHDCymsAytovp
 edFSQ9MBZr7sz2MwHALgw2xwwPNgT1VHYRE8ifsrFciDIwIm6BnInkakOfm/29BnzW0ZwRT
 aNHjtU5K27oeBXPP4K4rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+2iKv35ktTI=:lO1oZcnlJtkfpIuInzyNDh
 2TNoGYJCQVdfgO5pHM5FbpMQnCEcLwy22BXmpSONtGcNBQLDq8wiK/hiLI7NIMvewJwQ5N4vt
 B80HnxChoWr338m5bYROwYdbyd8hrsn26Px+SqDeCRmUxpqbO8kSyf3R8nTO33RuAwybuiXGk
 G6vtlh/p+huZMkEFFB81XHtxu9xmGNHW2xSuFO9jfmYpfHLVSby9xzuZkSe0XRcVO+LoTD+4C
 fZT56dmS4VuAlbCLP63YMKrZP3xyHnwP87D27dyqhZmoc9CWK7Qh0eDZHtgHFyfEnjH13aqSZ
 kFNY5hRD+IN/R+3+aHK6G5uwTbi5LqA4kGo9DB9vUBdKKcLG7BHwbQ1Pf9PWdgu0ZeVg2eexP
 FNj0AkoGJDlvtxgj7+EOft2ba5chgHGzxwYCZOWq10pnxTDDoVl4o8k6infh7jpq56u1rFCod
 SGbOn0bQgi42ysF3X/FFApqecbnmiCYX7CGB2OI5ZMlmkbly/lrDJcmPIWlQiE5X+u3k1XssL
 GEbuDQrn/BRByq/JPBXg8SWQLr4uM+oQ7gAjG0M/Tl8PfnPewRHD1wJjZzXNXJ/+rtCmQ45ja
 PCxz7L7+6GfAa7GPnC/8Hf1MlPjmFNSRa8RtCfd/U32m6fXMiE0T6DmtYMidQvxUw8gmts15j
 kiQxgWZdxNMGNzo2b2hFmAiyMjqh3z99XDq6Jm5+pc47QzYBBXSy9NRm5SczrtRXBYI1/1FYR
 d4j4pz1O3I2ex8F1wavsFtYz/Fdb5rftya+fr6C+9hLR5dI96fkY0z2432capY3xzj0PJohDq
 QdQMqZrNPj3wid5DzjUKEU/ZaH9XJD5t14U9fIdF6brnipFTKM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

seems like there is a bug with "git rerere gc" not understanding grace
periods like "60 days" defined in the config.

What I did:

git config gc.rerereresolved "60 days"
git gc

results in:

Counting objects: 158790, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (26849/26849), done.
Writing objects: 100% (158790/158790), done.
Total 158790 (delta 116114), reused 158790 (delta 116114)
fatal: bad numeric config value '60 days' for 'gc.rerereresolved': invalid unit
error: failed to run rerere

git --version = git version 2.13.0

Best regards,

Uwe
