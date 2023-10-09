Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF36CD6127
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377444AbjJISyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJISyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:54:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C206B9C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:54:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 444F91A0955;
        Mon,  9 Oct 2023 14:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=g3UjgEDq8B5JYFbjPq5PCqq5Y+gBLj1RybTQjz
        Pnpd4=; b=E7cnlMmrXvst1dcB2vVm6dIwb1tMkQu1Reep9qtRlJXW7/gDamE8yH
        6tzyryR8SPL239V3WSAaLbp2ADDsPwvSc2TRiRHmLlhXCuD+7PIr6BU0aNKDcuLs
        jtF9DxmbZ5QgFlVaW+CoizIU6V4axiEVJnmV5nsTSjXjJ3NT40o9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C6A91A0954;
        Mon,  9 Oct 2023 14:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 681211A0953;
        Mon,  9 Oct 2023 14:54:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doreen Wanyama <doreenwanyama20@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Outreachy Introduction and Interest in Contributing to the Git
 Community
In-Reply-To: <CANhBNnu6jbhNqAowBzyfcKDamXtcqCtZpY=QniTGTEJoCrwWOA@mail.gmail.com>
        (Doreen Wanyama's message of "Mon, 9 Oct 2023 20:38:27 +0300")
References: <CANhBNnu6jbhNqAowBzyfcKDamXtcqCtZpY=QniTGTEJoCrwWOA@mail.gmail.com>
Date:   Mon, 09 Oct 2023 11:54:50 -0700
Message-ID: <xmqqfs2jzkw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53C32222-66D5-11EE-8918-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doreen Wanyama <doreenwanyama20@gmail.com> writes:

> Dear Git community,
>
> I hope you are all doing well. I am writing to show my interest in
> working in the project titled move existing tests to a unit testing
> framework. This is because I have always been intrigued by the work
> the git community does and hence I am interested in being part of
> this. I have gone through the links provided about getting started on
> this. I spent yesterday evening and a better part of today trying to
> understand the resources. As of now I would like to start working on a
> microproject since I understand this is the first step. I am finding
> it difficult though to start. Someone to please help me understand how
> I should go about this or how I should go about finding my first
> microproject. Just a brief explanation will help.
> Thank you in advance.
>
>
> Best regards,
>
> Doreen Wanyama

Do you have access to the mailing list archive?

Visit

    https://lore.kernel.org/git/?q=Outreachy+d%3A20230920..

with your browser to see how other applicants are starting their
journey and being helped in finding their microprojects.  All the
suggestions they are given equally applies to you.

Welcome to the Git development community.

Have fun.
