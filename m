Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF202095F
	for <e@80x24.org>; Wed, 22 Mar 2017 22:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdCVWeZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:34:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59621 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752567AbdCVWeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:34:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EACF7D2E9;
        Wed, 22 Mar 2017 18:34:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=mezzJx
        U6YAoxvGdwv8jwguBGKFe/1jE6hkSWK9eE5rBq6zVLN15O7Qg110NFjhxDgmJgMa
        qA8/28tsgbk8tmHAEJ6/ch8Ooh+h48BLOIeeWRw+O03JTzzEfsBA4fDfN1xnYEaX
        3zN4mzbfSUKYdrqhM9URGVFUm06QBAEbRPT6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MdqsJbJmPPPOUOjS+BKnqba3o4zGYl4z
        knj9byS3ZA64RDhuDkFHW7j3A1CCIvAq47dCL/Oz3Rg3ao9Ybbu2NY9F91gV5bfd
        ifZDF+ySWaF1pNX3Bzp+G0Wscp2/BBGMfZVFFLOgi4yNu/FtOzyXzyPPoKnXdR6U
        ya6k6udHexU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 985437D2E8;
        Wed, 22 Mar 2017 18:34:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0867A7D2E7;
        Wed, 22 Mar 2017 18:34:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] t/README: link to metacpan.org, not search.cpan.org
References: <20170322221854.10791-1-avarab@gmail.com>
Date:   Wed, 22 Mar 2017 15:34:20 -0700
In-Reply-To: <20170322221854.10791-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 22 Mar 2017 22:18:52 +0000")
Message-ID: <xmqqpoh9gcur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1F46CFA-0F4F-11E7-BC08-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
