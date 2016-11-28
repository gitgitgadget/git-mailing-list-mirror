Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4901FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbcK1OVv (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 09:21:51 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32894 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbcK1OVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 09:21:49 -0500
Received: by mail-qt0-f194.google.com with SMTP id n6so11674659qtd.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gfr4CJRnMV+2wr5wEYCDc7k9TJ2GhMinab9UC3omk/w=;
        b=0cfCOA0kJVfPSRyZxFbt1I8naXw9hSX+92J1ai9zm2YAS1I5hDpuN6JFU70ZLb0PdB
         iSzaD3FZ7YxArTQykPOfJouewKeoT0vIJOEr5vTiwFVry+RvxxbaZxdDLQwEuekQZS50
         ahu5Yz105uKHSqyJYiA1d044jK955Y2E3EtRmtHI5Jxb20F1APnHflZL3JUoKv9oPOap
         8DWkI3PhXZ8yS9jMR2L7zAVw6I34Rr5cdX4qix9Sp+6yPH4mOjcXleAiXTM9IN6FUFo0
         wyqBGmGcmAo+MMZD0rLV/diA++bEOrE8jImnmAyj5Y7H3+4mG/xIqVUGkL+BuMxEQNxz
         mQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gfr4CJRnMV+2wr5wEYCDc7k9TJ2GhMinab9UC3omk/w=;
        b=CK1YejaoNFxiMaNxmdQYqlFV+loa4EnfZ98ONq6Okb+w24n+P4wFx1hN6nLcOUfASo
         0q0bnfuHHViWDIWOOFKUweudAalN/QINVr6T50cxnrqbVbPnKZWwbkgJb7qMCtDQKbMX
         OuIglf9ST+hJvr9bNx7Jypfyx0EaV1SKZAbHPM9M78OhshdhEZb6BGAo/t5Zm35nd8sH
         bh1GvcKTSs3M7GvhmZg8kdbpTFUY4FolCG9SOdeoFnis9v5WRCzvHgL4tFc5PamPd/54
         JkARqu+VnCeSz063yJqtXrbkbP8F9wV1EyRazUR4tZ36zXl0+V0k+f5dr9oum08tQ9s6
         zzwA==
X-Gm-Message-State: AKaTC03yA99NOjkhy6z7N7N3IyaXm/LRq0HK5pzP0KIIf7FdqDhImdwaL7PVzpgOvjvC/cd0Db9g5trozl4UjA==
X-Received: by 10.237.61.176 with SMTP id i45mr18804601qtf.285.1480342908301;
 Mon, 28 Nov 2016 06:21:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.129.65 with HTTP; Mon, 28 Nov 2016 06:21:47 -0800 (PST)
In-Reply-To: <20161124182500.6875-1-ralf.thielow@gmail.com>
References: <20161124182500.6875-1-ralf.thielow@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2016 22:21:47 +0800
Message-ID: <CANYiYbEzoN8S0o7_1N4hpO6OHZqq5Y4cMPxPPLEMA4TJ2n-d1g@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 210 new message
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Sz <phillip.szelat@gmail.com>,
        matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-11-25 2:25 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>  #: sequencer.c:251
> -#, fuzzy, c-format
> +#, c-format
>  msgid "could not write eol to '%s"

Unmatched single quote has been fixed in l10n round 3.
You can rebase and update de.po file.

BTW, Git 2.11.0 will be released tomorrow, please send PR in time.

> -msgstr "Konnte nicht nach '%s' schreiben."
> +msgstr "Konnte EOL nicht nach '%s' schreiben."

-- 
Jiang Xin
