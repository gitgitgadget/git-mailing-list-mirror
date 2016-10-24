Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95DBB1FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 14:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756655AbcJXO2p (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 10:28:45 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34757 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbcJXO2o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 10:28:44 -0400
Received: by mail-lf0-f50.google.com with SMTP id b81so189741901lfe.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=GkGvSnkaTRxDR9j9xo3YCw9XHqG7bHvG3cQ0s24umIY=;
        b=nko+fd1iDI0RESKPYzSYO9HHWPatHTGToJiG1b9VwJIEL3VRRgrqj56BwuskinZ9vb
         PmGBQFaW296UlvK4A6GATSw/RlKTnNdTimAw0FnUYPkbsuftUT7PIsGIz1E8kze9Ojd4
         Mt5OBDBsXmplO9Cc0hatUHzqUfZAec9FDBI+Lck/gvMmccc3hy56xdbYpNe68sa5fhW4
         hh+/XtS24boA4gRrgCTarr+rAE+/A9x9pBOJmBuULc2Jx9Te8nBlrtHUpt9kXfj0xUmU
         RA1Le9yX7pAzWf4QJi5+Y9qAwzjfVdoRyTHiiA17N4mJElTeNKA5Xb8WdpUtJgAz0RpA
         R2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GkGvSnkaTRxDR9j9xo3YCw9XHqG7bHvG3cQ0s24umIY=;
        b=MW8OxG9VA+yafVySvdncAoUNI3GWAJEZ5PFE8YLwU8BIcJ4QUQ8/td83+0rd44Idgu
         M+GaS0cTtvo2OO5luF1TEN7eojdbg5g+maPOD8+WRxsH1tf9izzXALdobGRwKVdIg9KM
         GidnRyDByR5mVWNuAQeL1xxCyU4uiJ44H8G/M+cjqBcTx5woGsM8PXsjFaIpNGpxFHzx
         6XkrezhK51OtPPTnRpP4mV/PqtlIk8n8+GaM4jsGhVDgCBv8i3mEKPv5E86IbNFnKHjL
         PiZFAlJ8h+FdfHfWSAGBZ//67y1nK+PdNrxaStrJMm/JvN0PgnuV4yvVDzxN2OTmEKI1
         pVPg==
X-Gm-Message-State: ABUngvfOsgGlDHQ+DOT2R2EWDD7+iiXwbKW5TsWLk7OvB9UXkhbbjzgWNNykpl6zWuJ7o9j3A35DjHNmOxkFnQ==
X-Received: by 10.25.24.154 with SMTP id 26mr5811699lfy.3.1477319322668; Mon,
 24 Oct 2016 07:28:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.209.144 with HTTP; Mon, 24 Oct 2016 07:28:42 -0700 (PDT)
From:   Yash Jain <yashjain.lnm@gmail.com>
Date:   Mon, 24 Oct 2016 19:58:42 +0530
Message-ID: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
Subject: Reporting Bug in Git Version Control System
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I have two accounts on github("yj291197" and "yaki29").
Both the accounts have different gmail IDs("yj291197@gmail.com" and
"yashjain.lnm@gmail.com" respectively) but same passwords.
I used to use git for "yj291197" account and a few days earlier I made
this new account and used git commit to commit on "yaki29" but it
appeared as "yj291197" committed on "yaki29's" repo.
Then I pulled a request of that commit then it appeared "yaki29"
pulled a request with a commit of "yj291197".



And during this whole session I was signed in as "yaki29" on github.com .


Please reply ....
