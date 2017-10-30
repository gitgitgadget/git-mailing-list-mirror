Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE2520562
	for <e@80x24.org>; Mon, 30 Oct 2017 12:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbdJ3Mor (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:44:47 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:55736 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdJ3Moo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:44:44 -0400
Received: by mail-qt0-f174.google.com with SMTP id v41so16082337qtv.12
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XtXr3oiwHMIQBDWKqwormFW22w0oEyne6cwuvb2MFTI=;
        b=qF233s0Q1ovCfxEy8PxjKzjgFlwqmtMjkhf7mc8BJpK/C9Y99gwMBloo6ic1cfFX5n
         27WsUrlpnLFK76rGrw/aNS0GKvWcQTq87WbFKvgG8D5Ck8hh/tzACljHAzfWc//yWsRk
         Hioz2blzpM/TtYFma10hLm3hOG0guqH6M1nllPSJMh/gUKh4ehFJFLbrmL8+jAlhGEAu
         +LD4j1LE7pNIZw2aqmkRLhxe8WV6Ttfj6kHkhYJTCPBJff3MgfR0QYEyEuds6IZ+v6jE
         VylB8NGD4MatAf79y0rGlNiNjOFpun3aM61dyGvo1lwwObFqjqLu85CVgY5BTTIwE8KP
         T4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XtXr3oiwHMIQBDWKqwormFW22w0oEyne6cwuvb2MFTI=;
        b=pGxJFAFycGB6QxiuJyU0Y4SjtsCX9Yx2OiaUmXOUcEU4vj8dax5UQcwafvQK+qUqtc
         DpY+yT1q+aEduXoFk0ay+BYN+6v5mq4JM33OpDvwmpIn7XnZOzBB+A/vwlSa3Wn2M1Sq
         8jMWHBJDP9PMbFvn22ePoFCN0j3ieTEOpKACs28seKrZxxd9rOwQTJiHr9JGKkzCHGEb
         8gjBtrMFXg6FGBrb9LIoU9ISYReQ5Mepzo383u25XAIPVGFr8wcjabYQHEDi7MImsdK+
         YaguAJbf2jTvJus8lDxl5j3PHWMFRULscv61mttw44CZgHmWkvDLSlWdF+xgnFN4c40O
         5mCQ==
X-Gm-Message-State: AMCzsaWefbuqZsdFJXPdend6P2YypsRvUgfvcI4gkMI71v7h33CbcI1R
        bbl31rPgXiiP4DbAap43Racdr81fzxvLo3PWqLw=
X-Google-Smtp-Source: ABhQp+Q33uh7YwsYZTuNYrAhhxLbt2IzbaHCFVcGmgX7VC7NjCYevYzC0W0UOsbYBtT/DOfcHQEcnhwO5j9iX6QsSZY=
X-Received: by 10.237.62.53 with SMTP id l50mr11778810qtf.270.1509367484084;
 Mon, 30 Oct 2017 05:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.20.18 with HTTP; Mon, 30 Oct 2017 05:44:43 -0700 (PDT)
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Mon, 30 Oct 2017 21:44:43 +0900
Message-ID: <CAC2JkrLWrCKRJjzXRzWWtJKCnaXtEJxUPd2rtZfkoXtgsPNokg@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe *
