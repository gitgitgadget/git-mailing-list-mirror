Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06159C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 22:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiGLW31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiGLW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 18:29:25 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6818FB851C
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 15:29:24 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oBONe-0007Ft-Cu;
        Tue, 12 Jul 2022 23:29:22 +0100
Message-ID: <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email>
Date:   Tue, 12 Jul 2022 23:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: What's cooking in git.git (Jul 2022, #03; Mon, 11)
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo7xufee7.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqo7xufee7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2022 18:07, Junio C Hamano wrote:
> [New Topics]
>
> * po/doc-add-renormalize (2022-07-09) 1 commit
>  - doc add: renormalize is not idempotent for CRCRLF
>
>  Documentation for "git add --renormalize" has been improved.
>
>  Will merge to 'next'?
>  source: <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
>
>
> * po/glossary-around-traversal (2022-07-09) 3 commits
>  - glossary: add reachability bitmap description
>  - glossary: add commit graph description
>  - glossary: add Object DataBase (ODB) abbreviation
>
>  The glossary entries for "commit-graph file" and "reachability
>  bitmap" have been added.
>
>  Will merge to 'next'?
>  source: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
I'm expecting to do a re-roll for both these, though I'm just recovering
from an infection.
If you could hold off for a few days that would be great.
--
Philip
