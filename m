Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0706E1F461
	for <e@80x24.org>; Mon, 13 May 2019 14:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfEMOUj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 10:20:39 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46100 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfEMOUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 10:20:38 -0400
Received: by mail-wr1-f46.google.com with SMTP id r7so14868416wrr.13
        for <git@vger.kernel.org>; Mon, 13 May 2019 07:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZerJzNmik/b6q2RENyb2Fu9q9UZ6CuHOOXAv1N72vA=;
        b=UPNqun+0TagG4k7n94OViKbIH5o2+twnTN9kerXDsCgC5Hd4OaxuXSg8CMp/9tPkt+
         h3gwYioDBdYG3U8hv2e4/HgnIg3VKvXmoOlD+C9b8y/5D3R/A13f1VxIlEgH7QEa2Hnz
         gCd7DU1FbGSkLiIDPQJ5Y0CgTgWlbBgHl7F8guRewAcKAVtWm/b9IQHCx+UL8bV+H0vx
         gaBh/Urz/+lcGGNjn04SGpaaMDdzHhnXNlmbRLy3YevNaScfZQ4PSILlWMMY5hNC4YdX
         4/hK/T6UiWKzxHK9hQHcaq4TlHZs27RnLg3+dmW5ycmrPQEgDN5A5xND2cb5rCdPKU/q
         YV2g==
X-Gm-Message-State: APjAAAWonAGR8CMrCNL1g6bOK/fsONVKYebYYjz8TxGJ/udFt+SFU6Ha
        CVtSn2pv94iuDQlNS0ROnNzo1/NKI/iGROz+Cb4=
X-Google-Smtp-Source: APXvYqyyB3goPHLfLEmrJd7OEBK46Lmnh9VDM9oLV2Is+nCiOQaeaYVztswFOtWKuHP2R7wgpowMqpsTaBdFXcC4QB0=
X-Received: by 2002:adf:c149:: with SMTP id w9mr6797631wre.40.1557757236606;
 Mon, 13 May 2019 07:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092251200.44@tvgsbejvaqbjf.bet>
 <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1905131605280.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905131605280.44@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 May 2019 10:20:25 -0400
Message-ID: <CAPig+cQghcdgN-qAF=b3NEgzBOXY2Ce9GWi95Q=JdPuTEnMPfQ@mail.gmail.com>
Subject: Re: nd/merge-quit, was Re: What's cooking in git.git (May 2019, #01;
 Thu, 9)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 10:06 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I should have posted the link, as it may not be totally obvious where you
> can download artifacts:
>
> https://dev.azure.com/mseng/AzureDevOps/_build/results?buildId=9464474&view=artifacts

This link leads to a Login page requiring some sort of Microsoft ID.
