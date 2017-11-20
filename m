Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C40202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 15:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdKTPKk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 10:10:40 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:38152 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdKTPKj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 10:10:39 -0500
Received: by mail-yw0-f169.google.com with SMTP id v195so627444ywg.5
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=JNVQCLIEoXo9ju04XqU+pKcUwm09mmrmzU9yzQX9njQzby6I+KhS/eENjj5u52Q4Mr
         mSvQ8zzlK2Fyn/LS6pZvIl/O/NX/aGvVXNFFPZBUX5wPucUAdk3Nj+tuDS6TmLyT46sw
         m/LRk5nBpA0PBpOD8yTxwVsHnVfCfqtzlmJ3bwBfiTXPayxjSnn/Ckc0QU3+Xq89aZW0
         GUgnVpobe8VPq1Xx/otscNX3IbQ8sOZzqL1LOCuYIRIJmjAr6MxtwAsZzh26LP/aTQ+S
         CFTV/PnoX7gBQsgU/UxF2xqieqv6c/YBmHrMIJMSIj2CZPBr+ViFF8VyTm9Vq3V+ljAL
         ZZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=pqaL2l8tG4tygbJP+uAJ0qUfb+0S2AvjRZBCZSOa3KKVFm1j7DgkxT5Xasoi60NB3u
         bkZiS7A27rlpHLBIybarYLVEnaVEFduN1Amfd3nnRdN3wpfhX/pU4Pt+pZ+Xzq5cNaoM
         MBec8CBMD/bV+FM1FhyBxqFdNxSuId1wMyuP3EEaTfvgibQ5qgQjVca7Ce6kOE8ePr6n
         v7arx+TJ3gYNP3nPNBaensObTyukPnv6m1lwxaHhaG1uegw4oYVU0TyLLdKfEmBfYwcc
         BoJeyN/hqo+dS5FHudurPK3R4OGRzseW8y0ivkuIXaQGTQExqL1jrjPwyxTT4SfiC0+j
         grpQ==
X-Gm-Message-State: AJaThX4o2GDF0TNy4dkEvtn0qThMR2ViqHdhRs+NDKXXg3nW0ULCfetC
        qZo5wObryLd6wmdQcl+Fv6Tj2iISBi387Uh+QnHO1A==
X-Google-Smtp-Source: AGs4zMY1/UCJWhyHeUZ5yBE6IVGCJ6YMya3c5f4b+SYpY0Er3tMfxiwGoqbR5rTsMVwFKtDnbxhwK3byufUD2MMFIDM=
X-Received: by 10.129.161.141 with SMTP id y135mr8583931ywg.281.1511190638334;
 Mon, 20 Nov 2017 07:10:38 -0800 (PST)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Nov 2017 10:10:37 -0500
From:   Viet Nguyen <ntviet18@gmail.com>
X-Mailer: Airmail (457)
MIME-Version: 1.0
Date:   Mon, 20 Nov 2017 10:10:37 -0500
Message-ID: <CANb5NdLE3edJW4nRDqrPFuC4680J_K-Nt8VyW5tgjRBgf_ZU1w@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe git
