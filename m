Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103991F461
	for <e@80x24.org>; Fri, 28 Jun 2019 20:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF1U6w (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 16:58:52 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35595 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF1U6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 16:58:52 -0400
Received: by mail-wr1-f51.google.com with SMTP id f15so7603791wrp.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 13:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBkpdMtjMQJVbwTy3Gu/GbPRNqq3CF23VBDu5Umv2zw=;
        b=OCR3SaCfpIF9licxdra9jv2zS1FEBj9EULyWyC/D6mz624ZhTiSBlBAM3Q1BAVvqs5
         itugtKg+l42bhOnGAQzt0vnT+eDHU/pyWaWg6YwbQGb8I04kpTc+tSuBJfUuxmUnBuI8
         y4lO4b8N1Ka46laLdxSdb3s95mnjKybP4JJxk8P/WBiwyb1thR6bbVga5Ii0s6JTTVqw
         77AajwsuUVRY4Z0pZhDyu4wu8nCymKChKA4L3XhN+d6L7cMb/73DWp9D92FBLU5BJ5WH
         u+dUgjm5IjVkv8je1C1z2k8Q7ZD+QANNfFUdTF/L6ex9fyDIc+bgo77mOmgsVOpL+LRV
         15wQ==
X-Gm-Message-State: APjAAAXgz5QYx/83UUHIi6gRdikmTyNbL8ijHdViCcqgDBThN/CxIFvj
        huqiuNJCN1EqRWRLGERuoaTiJfxUL+SJY4SMyLU=
X-Google-Smtp-Source: APXvYqwijrdXhxzrVh9HTke9nlM82vdNzhm6iYPBMKPwYZRThlZDkm+a+L3/n57hQ7ylpEKuJGWkoeaq+IOtjfMDbDc=
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr7751105wro.278.1561755529319;
 Fri, 28 Jun 2019 13:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <E35719A6-FE2C-4D17-B491-6309D276C037@gmail.com>
In-Reply-To: <E35719A6-FE2C-4D17-B491-6309D276C037@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Jun 2019 16:58:38 -0400
Message-ID: <CAPig+cTU78M7wdxYzoPBe-OKiKbjr0=j1vvgUFzXmCh2Vx8-1w@mail.gmail.com>
Subject: Re: Git installation
To:     garrett dean <gdean229@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 11:03 AM garrett dean <gdean229@gmail.com> wrote:
> I have been trying to install for on my PC for Windows ten and at
> first I was having a hang when it reached the end. Now pop ups are
> appearing saying there are configuration problems.

You'll likely get more helpful responses by contacting the "Git for
Windows" project directly. Try either the mailing list[1] or the bug
tracker[2].  Also, be sure to include as much useful information as
you can in your report, such as the actual error messages, what
package you downloaded, version number, etc.

[1]: https://groups.google.com/forum/#!forum/git-for-windows
[2]: https://github.com/git-for-windows/git/issues
