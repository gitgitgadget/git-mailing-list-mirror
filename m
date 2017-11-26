Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_SINGLE_WORD,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134C920954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdKZDwL (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:52:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751902AbdKZDwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:52:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08963AE573;
        Sat, 25 Nov 2017 22:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=KpSfxM
        Wy1SNT/1P4nc0Rl77cQdeVouuk9bn1IwjAyb5EfDviGlAkm8+TnJbbpSKJpTBCEV
        9nHO8nGwMNSQ/jY/NbpIgncW5fztPIDXeB8/2KebtTIw5O1F7tKwlPT/rKLvekez
        hZtrOMnFyIPjuuzvfuXqt6jg8GB1ln2i+bqeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UQvwPDiHCn1pEv52m8cJvFchQH2pEgLa
        Gs9JmopxByciR1THy5jYcPo8SDsvfBC24xhWWZxwJYnER4M5t3n3LJ3StalOrC6c
        m5NaqL3U9F74q/LLgbCIp3Sut0CBEnjQEOFEQis8CBPX6Y8yccMKix/4fngZ0eTz
        xp/2929l+bE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00332AE572;
        Sat, 25 Nov 2017 22:52:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75A0CAE571;
        Sat, 25 Nov 2017 22:52:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper.c: i18n: add a missing space in message
References: <20171125195524.29162-1-jn.avila@free.fr>
Date:   Sun, 26 Nov 2017 12:52:08 +0900
In-Reply-To: <20171125195524.29162-1-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Sat, 25 Nov 2017 20:55:24 +0100")
Message-ID: <xmqqfu91itnb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D7BE6B6-D25D-11E7-91F3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
