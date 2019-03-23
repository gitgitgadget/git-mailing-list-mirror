Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C4F20248
	for <e@80x24.org>; Sat, 23 Mar 2019 06:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfCWGDm (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 02:03:42 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46395 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfCWGDl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 02:03:41 -0400
Received: by mail-lj1-f182.google.com with SMTP id z26so3691079lja.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluecoppertech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=XSAjvC7fiRZIIb60MurgMaUYvLd7lPASUqafFCYbc2karuH9dD0sFZiLBO8HNXhmge
         nQPDuGPYttmLBI1/8ILghT8EXeOpmrYY3wj3Mniu3It1v4fxjZm4D4wUzTolgvvG08Go
         w8/DQMPdMdPSghAPDl8awZyAovmXVoCbUFA5PGaV7EWN1jF7Q++xtQ3l3Jj8VI76IzYq
         Fqpg4qaxTM9Xt1Da+vl/1pJHw0cT+oVwPlq7pR2n77hqme6nFGbwwrDuRcRuGL4ooYbq
         v9eZPCCRyHQ4YEi7CHHfmqiuFsFmosbvuujQfkH0/fRRjMwAd4iSY1iQVtHgtG0e3t0X
         EXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=bux4PtH3efpApMl99MsHDmqOJN7LsLkL5QOkl8TzY9Sq8LNwt7ugr1oWPeXESLeTfT
         khLFmRHEja3hweVxbFysK6TDkAXuiyGVsphKUT/S1mXi8p6vr/AqNBod4epGJCN01oy1
         D4zk8QQF/tkBqGQT0jLxtTXOY3Wj0RHHz3766K4yyCy6jh7a6OdX6gc+hHe9MbiwJR2w
         ZirIuiGvGIsQSNuiLS350IKJ9XwYGaJ5NXAe7tRPQ5CCx/19xeNNXWnB7pVHhNGN/n6S
         JOvDKjbXtvNWH80X4tkb1l234xCG3lxJLHAa6p1EWMgbE366xDHgoCh95KTXaNujTsys
         49ig==
X-Gm-Message-State: APjAAAV8G48xlZvAfPyJmoAT+ywXT0/wqz45/XDShw6Cr7TfADt6Np4S
        76xKiw28mwdwCUNzWx3Dl+nupGuS0xAdaYQ6Y+yNiCfh
X-Google-Smtp-Source: APXvYqwjjDnBpjK8DJPayK+igtJpelP1KmE4UPZipMcqAhtE2leB3+r8wgiKA3Ff5rFjSplUzMFxPJ9ZXORBCsXDngk=
X-Received: by 2002:a2e:3311:: with SMTP id d17mr7037988ljc.165.1553321019656;
 Fri, 22 Mar 2019 23:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190323041332.9743-1-alexhenrie24@gmail.com>
In-Reply-To: <20190323041332.9743-1-alexhenrie24@gmail.com>
From:   Abhisek Ghosh <abg@bluecoppertech.com>
Date:   Sat, 23 Mar 2019 11:33:03 +0530
Message-ID: <CAC-Lx1sPihYin0rEF=Z3Aa0_S-wWnVQ8=qiNcw-ErNwqDN5tSA@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe git
