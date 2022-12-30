Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB3CC4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 11:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiL3L7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 06:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiL3L7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 06:59:31 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06A18B11
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 03:59:30 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Nk3hf2ZnGzDqW4;
        Fri, 30 Dec 2022 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1672401570; bh=MOm3RczYQGjgzxQTPW529IDjlL/llAGSmUqxgESbd9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cr1UqbvZxe606041LFvBgMRm048IqVdcV2xU6GE+2xo+HkZOgrBMykYb7hXuL9Fjm
         Qyqnlo0yqpwFKYmpIXc9nNIpS+Btiny28u9YQ4vzAA8bHTaeTqE+C8zIQ/lM5N+W9N
         1K7bywCof4WvvZOZWbtkiA+3krAqhgdeHxzOraEE=
X-Riseup-User-ID: B6E1126FEE4A328F90C7C979051F0764A9D921E922004673AB2D246E5A8C4EAB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Nk3hd1pJvz1yRB;
        Fri, 30 Dec 2022 11:59:28 +0000 (UTC)
Date:   Fri, 30 Dec 2022 11:59:23 +0000
From:   Samanta Navarro <ferivoz@riseup.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] maintenance: fix typos
Message-ID: <20221230115923.ajutetdwpg6idnc6@localhost>
References: <20221229125012.cp5tjdlnvxbln44l@localhost>
 <xmqqmt75lh2r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmt75lh2r.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio,

thank you for you feedback. I will adjust the patch the way that you
have suggested. I'm sorry for the inconvenience because I did not know
how to group these typos.

With kind regards,
Samanta
