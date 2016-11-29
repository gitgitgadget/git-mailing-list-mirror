Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C8D1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755993AbcK2Thx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:37:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751726AbcK2Thw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:37:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88CA35378D;
        Tue, 29 Nov 2016 14:36:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m+Ex9M6S3nVlYv8JjgF1E57RyaU=; b=uVeTvA
        9bGYBG67rH5amLO036SHdG8PlkqUXiQmcuWSGUjdBqqrxG9sjgVYX9lHXKf79e6e
        UuNpOy5Lh+jcXAezLeNu4L0u1BthFtdiLRWcwtyDJ86KakuOnVhFALuchZigjuxQ
        YoqrzQyeH2hmCI4GdfsGW7xBQOaZCk5HAn8aM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VVIs41LNTa5PaMtBGQJ1w2bbIrWzkVtF
        qJTIgRIq8lfRim9EeGZ+UbR6DydOvCZ7OK1bUH+7lxIVhJJ102Gnd0qZyt9VH2z3
        fG9W8n+tjgNvi+iIqkXpQ0VfaWHLbb1jrXOdpuoiaMvU0ntiTJjvpW3YzWQRjQC+
        rzWG+lpQqxw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 816E15378B;
        Tue, 29 Nov 2016 14:36:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 008ED5378A;
        Tue, 29 Nov 2016 14:36:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.11.0 round 3 with ru and ca translations
References: <CANYiYbHYaOUwJo_8Vc4vAYatC+Xu09fWLw5q+T7W_7_xwuD7Nw@mail.gmail.com>
Date:   Tue, 29 Nov 2016 11:36:48 -0800
In-Reply-To: <CANYiYbHYaOUwJo_8Vc4vAYatC+Xu09fWLw5q+T7W_7_xwuD7Nw@mail.gmail.com>
        (Jiang Xin's message of "Tue, 29 Nov 2016 21:30:33 +0800")
Message-ID: <xmqqbmwyf57z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C2B8F96-B66B-11E6-9936-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Final l10n updates for this release cycle, please pull.

Thanks!
