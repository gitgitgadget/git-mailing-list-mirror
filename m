Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777541F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfJUQ4R (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:56:17 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:35481 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfJUQ4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:56:16 -0400
Received: by mail-ua1-f43.google.com with SMTP id n41so4030120uae.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+koYw5tUGPorxCXvqYsTmsHIVv6SR8KNcG8p3wVYNBA=;
        b=IxDqleKp6mQU19nU5DyqfG7ZMgm5MepVg3g+DqbfapyhaUV6oOmOy5ouqk0eh5jLtt
         /Q7jP7F4VFv/xZIsj2IcsiS2zOvnaNX/ZcB9UZyL2gwqjo4yw1WihZu/p05BAUccfR8A
         fo2mdBYwuzlALSoQWXOlmWq6c8XHENpmPsPT7aGtVEXo9/pV903JhcM13XVxrBProKTn
         n6ZHuolwuGyFOUhpO6b4gk1oWtu4XD0GG0mKsNBmp3iRiFBaxKREnpK0BkcgrBO4nG4f
         Awx3D1f0VgdJckIDdRkWbWNCR9ye+4/VWWmfbUCajL6PGD/P5QKtxtWIed/rrv5LM6KR
         iTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+koYw5tUGPorxCXvqYsTmsHIVv6SR8KNcG8p3wVYNBA=;
        b=Dj6AwetdQLCFSzXzAymHzoFyCG2ZbgkqgL4/dXak7fNXTs934vv/oyf98gS/Hw/lXe
         WbNc+f6gHy64kuma6eC9YhhAhIBQ90wK2wTShZBnm9hV5DnvPUzgf9mNvMPkXLdmQaJ1
         PP5oqoPUxHyX2F3SLldOjCkLKxYk2R/NoyvZrIGh46Kw92KdiFdnEZVZAtmR2N1nrZ44
         ggXojd3Fyk9dxwBsj0YJz6NwPohNy5aA+kV6S2FPp1ahbcqe+bFxtsc2JW4q/HzetS/l
         AG5AGnZTzsQcq7UGiFS4xzPYu6c2rND4jMzfAmwj/1u5vJpZJw/XaqM4TtLHHqH6/iIx
         8mtQ==
X-Gm-Message-State: APjAAAUd95CjYFRtN9q64OknNux9pPKSJ/H0nLScEF24zvVzxsi2r5ol
        P6Zci+kSSqjZ+DYczRcMmsdRoDTd90FIreC89AbVtFVG9L/HeQ==
X-Google-Smtp-Source: APXvYqysQe9gJk2/9kainoySEkIEmhK365v9PDxavaPB3VNTUNp3K3MDnCA8ZzYZe56P6Qttzo1ZNNWKanbkBLrMYhw=
X-Received: by 2002:ab0:393:: with SMTP id 19mr760335uau.58.1571676975851;
 Mon, 21 Oct 2019 09:56:15 -0700 (PDT)
MIME-Version: 1.0
From:   Karina Saucedo <karina.saucedogza@gmail.com>
Date:   Mon, 21 Oct 2019 11:56:05 -0500
Message-ID: <CAJxDvStLi2usG_X7e8FeOSjKCXN4Yb+b_JCpUc8Y0HZ-GuTUgw@mail.gmail.com>
Subject: Outreachy Winter 2019
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, my name is Karina and I'm and Outreachy applicant.
I=C2=B4m interested in applying to the project 'Add did you mean hints=C2=
=B4 and
I was wondering how can I start contributing since there seem to be no
issues on the github page. Thank you!
