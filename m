Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744861F453
	for <e@80x24.org>; Thu, 17 Jan 2019 14:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfAQOFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 09:05:06 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:47056 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQOFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 09:05:06 -0500
Received: by mail-qk1-f169.google.com with SMTP id q1so5999814qkf.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightingnewyork-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=bmUlvb/Y1JXBeg1bPiXkE7ds+hmcJEMpld2iuH/OkVFGbL6+zfhC/NCZzw+pNfUYKD
         Hi32RDRjZsO/G7gzZYo9F+3ucCu9HK+KGXDbHv2wZxDT6PP1GH+vAvrgGdR27wZDBMmr
         57SyZN+UAgmlVmqefMRrmSFTkCYcl3oHzImY3SCiorZ9C7bsE15FRxkwt9UPkAg9b/u6
         2DcTT9LyqBY5ivupECJvo39LWbIsWqNK6NSZo7zSvjNYzQ0E/7ZB+jCASTrmFH9dJzXY
         lXkAzRKyVjCxoUDXm3++S/9dVf2hgRcZqD2sthD36bawli6RaM6XQ9lacdvQ91jQRwMu
         CBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7mbM0yKjbyDpTVlY3SygizTLc7hBBQl5UD9g+obTCb0=;
        b=oqW2lCB2eXTkmjlQ8Ob47gvWL1oo3DQkCF78zfPwl+ptZaJJaRLjRr4QFxAmHb2FR0
         GD9V9e03pu7fVVD8cd+556fpTUUX/IAiP6dhKVk4p6MSR54goRjE1b94LJgNDJ6hVTt+
         ZIeK61XpCpHggsbHmdkCfFQGxTAagh6E4XmGFMTuVKsASksmJa4IizMFauj0TmYJNT0a
         GJdOJ0iMzDje1IlSzAvjO1tuTqgvlOIeOu4zsZoGsmqWVKe+55CTnTNmtf4DqoKje0Q3
         dMYSYhdVrtt8NZ6cHp7IyN9O2k7ru0PWbK+Wyx3NC+yz02YAVqDnbR85aedf7lctr8Ym
         kgMg==
X-Gm-Message-State: AJcUukci5akHBVGZo52Q0dA1z0h7MfSOuyWxEdrbzBz9W6FnDCYL7aOL
        TNngbgk+SsJpznxoluPduS4/q+7hBsVd2VVInx42ehz7/Ho=
X-Google-Smtp-Source: ALg8bN4cB3VgBJAW/P0vL989pKCt8H/Tutz1A3TyhBrocYEoxWzq0xBQULwoGR4OEkn5TQsmO2x8NaNguZyaTuC6+0I=
X-Received: by 2002:a37:2714:: with SMTP id n20mr10811610qkn.349.1547733904850;
 Thu, 17 Jan 2019 06:05:04 -0800 (PST)
MIME-Version: 1.0
From:   Cody Kratzer <cody@lightingnewyork.com>
Date:   Thu, 17 Jan 2019 09:04:54 -0500
Message-ID: <CAJLF3qiacbEQ87ShoMWzuktfZZChzAFhYLiWk_OxCCdg4MBRHw@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe git
