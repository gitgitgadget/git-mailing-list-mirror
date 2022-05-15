Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4EC433F5
	for <git@archiver.kernel.org>; Sun, 15 May 2022 11:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiEOLiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiEOLiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 07:38:06 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5BE3B02A
        for <git@vger.kernel.org>; Sun, 15 May 2022 04:38:04 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nqCZW-0000xd-BC;
        Sun, 15 May 2022 12:38:02 +0100
Message-ID: <7515c5df-a547-c4dc-5221-0f5089f2a2c3@iee.email>
Date:   Sun, 15 May 2022 12:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: sudo: git describe during GIT_VERSION_GEN not as expected..
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <7bb71920-b840-5133-ceac-664c09942772@iee.email>
 <CAPUEspjGiyUOhEZpe1bZ3EQqAruyT-WoC8xorxNfp=ktOw__uw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAPUEspjGiyUOhEZpe1bZ3EQqAruyT-WoC8xorxNfp=ktOw__uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 15/05/2022 12:05, Carlo Arenas wrote:
> On Sun, May 15, 2022 at 3:12 AM Philip Oakley <philipoakley@iee.email> wrote:
>> Is this a temporary position, as the sudo safe.directory problem is
>> still to be added to next?
> yes, it should be fixed once/if that branch graduates to next, and it
> is currently broken in master and all maint branches as well as the
> last 2 releases from those.
>
> Carlo
Thanks for clarifying. Wasn't sure if it was finger trouble on my side.
P.
