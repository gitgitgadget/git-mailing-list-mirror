Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD9F2042F
	for <e@80x24.org>; Tue, 15 Nov 2016 12:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbcKOMaJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 07:30:09 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34680 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbcKOMaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 07:30:08 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so132862720qke.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=xJuAOf1V2rXPUeoxpmYLSmH46iijOn0cS/bFyQjz59Y=;
        b=xo0KGzq5dt6rKWJ0pkWrhLpF2tJO0fUp3tXWOM7ZMtqqAEq/faMhHWOTboFtIHEFCM
         auijBnuGBudx984U6dZ+Qv0g6nDCaToxf20EMMgxFTcgqYuWUyvwp9wdwGjSxhv6KfpZ
         7HKB0MhDz09Y8amF1Ki2HQBlJNavNhbH1gjy8MT/4FZbflucWRMzcyddldQOA1YwhmXg
         aZASvIN9vPR8zjzu3tW4hrh+V9qo/I0mQwkDaEcjYhyLBSj/fIrg15mQ3pEygXZ9nYMA
         +xi60yQ8tB6RHvQnv72ghWgf2pgj7dPTK2AnydVBVhuLgzqhGO4RUEOudLAbFxcSHhOA
         zV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xJuAOf1V2rXPUeoxpmYLSmH46iijOn0cS/bFyQjz59Y=;
        b=W8gIln+td0W2UVfKx82fE9wZiEiM160ZRwcsP85kVAoaDX58V3Ceg7aG08BbhrSKpO
         yScuPgvfdOr7lBHbQPMam/9FsQXyf9E27qjQlAEbDswep96O3+HgqjY/xahyR0OXmUIK
         1dxaGAzXMNZVJzNFpFOq6sYUFJ95F2mJa2FiK09RU3p1wcPqZc3e/iWvvRsBosiBFN65
         J+DSmpFCn0WnvspdqDgTq4k5F/cPc+VI4xIWbxv6f+ftxUSdhtvRJVI0Tt/XG2tWPG+C
         d/RBZm1Ber8xdLpPtVhcdPQ82fB2auuK1Uu/GMVu4kEcQowWVwfdzc5y9jXwcQuc4zr4
         sF4A==
X-Gm-Message-State: ABUngvchdKnNw7RTr3xRi+U3sK94gIlEc2gDMtmP2c5Z79f/IliA39+gr9zwwiGjIZK4xEIwq0+Hesclh3j8Mw==
X-Received: by 10.55.136.134 with SMTP id k128mr3241177qkd.196.1479213006523;
 Tue, 15 Nov 2016 04:30:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.37.237 with HTTP; Tue, 15 Nov 2016 04:30:06 -0800 (PST)
From:   Mayank Gupta <mayankgupta18198@gmail.com>
Date:   Tue, 15 Nov 2016 18:00:06 +0530
Message-ID: <CAJNRPQRhyrALj0zdaTxKgwo8j8r8_7ixgX21+C=ue+CGKYgaCg@mail.gmail.com>
Subject: New to git, need help!
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I'm new to open source and have recently joined this mailing list.
Since I'm new at this, I think I can initially contribute to the
community by fixing some small bugs or errors but as the documentation
is too large, I don't know where to start.
So if anybody could guide me on how to go about it, it would be really
appreciated.

Thanks,
Mayank
