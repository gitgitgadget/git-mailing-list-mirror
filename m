Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575E2C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjEPHUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 03:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEPHTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 03:19:33 -0400
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49BD11A
        for <git@vger.kernel.org>; Tue, 16 May 2023 00:19:29 -0700 (PDT)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1684221567;
        bh=6PsbKEvjtLGHctwxKqwxlhxr6hrZO38P7XroyrIe4rs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=Le6kZILB9C3evu7bpzJdH5rYwmftewfxbbT/mjYGuxJ4p8bPSuHglX4B3wKV7CYDG
         CpZfDNwkY5cZhjGDXoF1VlAfaNQhhRHAbjjgJQutmmzcRPTLqBq6/U2/6OPkXhE32g
         ILQ5yMYc9CeZ6g/x2QH1sAwhmBY46t9rz7j2TLdwrp32lIvAKXh9LyOEwcErHmhk68
         ZuJjla/YEptUTSqn4OAbcCOX32jgFrPvB2YOpBD+dgnUKC4whdLPnatYSg9IlH7FPp
         im0FhSpJnRJrQLrybTqmmoR1339m9n7hNV9g8U3vnkcyFe0rtmPmErkTNdoLNcwZUk
         uv3pdsRDuU47A==
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [POLL] Git Merge 2023 dates
Date:   Tue, 16 May 2023 09:20:07 +0200
Message-Id: <20230516072007.338103-1-toon@iotcl.com>
In-Reply-To: <ZEyDcBcGmLznqKzD@nand.local>
References: <ZEyDcBcGmLznqKzD@nand.local>
Mime-Version: 1.0
Fcc:    /home/toon/Maildir/startmail/Sent Messages/cur/1684221409.0329b9b7eba60251.canyonero:2,S
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

I quickly wanted to share my personal preference regarding Git Merge
2023.

>  - The third week of September in Bilbao, Spain, or

I would love to see Git Merge happen in Europe this yeas. But I was
looking at the Open Source Summit Europe schedule and it's a bit
unfortunate the conf is from Tuesday till Thursday. Usually we have two
days for Git Merge, so are you planning to have one day before and one
day after that conf? Anyhow, personally I'm stuck from the 22th
September. So I'd prefer Git Merge to happen before OSSE.

>  - Mid-October in Raleigh, North Carolina, USA

On my agenda this would fit in better, although it's harder for me to
get there.

I'm not sure this provides you a lot of constructive feedback, but I
wanted to let you know anyway.

One other note, are you planning a full day for the Contributor Summit
again? Because I felt the half day last time was too short.

Also if GitHub is interested in any help/support from GitLab to set up
Git Merge, I'm happy to hook you up with the correct people.

--
Toon
