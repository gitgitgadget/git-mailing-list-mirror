Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1601F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 18:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfJCSDG (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 14:03:06 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33563 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJCSDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 14:03:05 -0400
Received: by mail-lj1-f173.google.com with SMTP id a22so3814277ljd.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=q1U/cKuHfi84FPnRCwW8SXRJAOW5EYCLCjdgP37EmOE=;
        b=Bsv9k45t2ZRBV8kdYxIO62cNOc9ao5DK5LuQVt9HP2mwDPIq5aBTrgfI+OK9dMkFMj
         +TYjc/dejqc+Z+x2iOA8hUqi6USTlBPhMNLT4w5EnWJvKuaHrU07r4Q2qDlum/wfwQ/D
         ueO9svxrxW352npSvhpsb34H7E9Epfo3Nk3tVxdAdwxKBpgPBbLDRlmLdsFkol9wKjdo
         0Z17/sgKfTi1BrrAsmHUSBUa3OhI851G5To4FDdPDLn7NB8vnLTbHUmwGQnCVM2JLDvu
         veqDn8hRHFJQsnHmkNJomkfYfuxUcYFDD4WTiTiEEZ6eKjzoswuidTMPYuKiAo9vwGo7
         vqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q1U/cKuHfi84FPnRCwW8SXRJAOW5EYCLCjdgP37EmOE=;
        b=Cr9DfCKFleJ5FzlX/xRIgrzzt6kZGOMZCtoKmHCK5UB0GgkOi9EjGT7wOqrKUR0qTv
         gbGr51AuZpHVgpN2Pz3LZn/fUcGz1SmQDzzsWp9MItQ66Dex9dpvlv1VvjV2PJeRkmTd
         FB/2ZascppIG+m9l1m91U6gvoqOr6KR8PRnSWA/AqphwmZPbjqOUCYa91ObJn1UEhvee
         T4yCUa17kmtxCpevfTS7sE+5RkdAcLHYrZe8NWbImbsPPCOZjUj2/4rTmzWznrDK5lsR
         qTFItE87y0cQU6GPPeKCeTlvxC2fpubDq3P6RLoGN+36rGjxucQu09eFkH647sJ9CcTl
         UXKg==
X-Gm-Message-State: APjAAAU8c5vxa382XnDXsxg9fUGc3Qo3YmpCUry//tgH/CDqvPefPJnY
        k6AkonvEj9fU4gtJaQEqLtQXH40JitB+/gbWyW/nC/H4
X-Google-Smtp-Source: APXvYqznRVP8Kreye1i9Tr2+/gwF26lXkir18FCKUp/womvw+mt2Mzanh9w/wjq24fhi2RVrx7Elw/Z5KR7/7mJ0dqE=
X-Received: by 2002:a2e:442:: with SMTP id 63mr6995075lje.66.1570125783365;
 Thu, 03 Oct 2019 11:03:03 -0700 (PDT)
MIME-Version: 1.0
From:   Rohit Sanjay <sanjay.rohit2@gmail.com>
Date:   Thu, 3 Oct 2019 23:32:52 +0530
Message-ID: <CAAr56DBBbwBj5ajdhVWYnOkZPt3K26YYk6R2u825UAKdMRM7oQ@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

subscribe me
