Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4E1C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 17:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjEBRn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEBRn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 13:43:56 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F3C3
        for <git@vger.kernel.org>; Tue,  2 May 2023 10:43:55 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Q9nWC67r1z5tlD;
        Tue,  2 May 2023 19:43:50 +0200 (CEST)
Message-ID: <985ff655-51a5-2a0d-db09-5a53563fcc8b@kdbg.org>
Date:   Tue, 2 May 2023 19:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] credential/wincred: store password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>,
        M Hickford <mirth.hickford@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        =?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
 <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de>
 <CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com>
 <xmqqa5yn3d0k.fsf@gitster.g>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqa5yn3d0k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.05.23 um 00:25 schrieb Junio C Hamano:
> I am wondering if the lack
> of comments is a good news or no interest.

So far, I have totally negated the existence of credential helpers. I
can't offer any help in this regard, I am afraid.

-- Hannes

