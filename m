Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC6C46467
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 13:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbjACNZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 08:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbjACNZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 08:25:17 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB0FD3F
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 05:25:16 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pChI1-00052h-6k;
        Tue, 03 Jan 2023 13:25:13 +0000
Message-ID: <d84712ed-1504-4d54-a664-63713db570b6@iee.email>
Date:   Tue, 3 Jan 2023 13:25:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
To:     _g e r r y _ _l o w r y _ 
        <gerry.lowry@abilitybusinesscomputerservices.com>,
        'Filip Lipien' <aaa@164.ooo>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <064601d91f0e$b5521940$1ff64bc0$@abilitybusinesscomputerservices.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <064601d91f0e$b5521940$1ff64bc0$@abilitybusinesscomputerservices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01/2023 00:59, _g e r r y _ _l o w r y _ wrote:
> Git stands head and shoulders above other versioning software products;
> the reason is that Linus designed a superior system.

I don't think that ("superior") is quite true, in the same way that
'world class' and 'best practice' don't have the meaning they hope to
convey ;-)

However, what Linus managed to do was to cut the Gordian Knot of the
historical versioning systems that had their original designs created in
the quill pen era, and are totally unsuited for the modern, high speed
computation and perfect replication digital age. Finally, I have control
over my versioning system (at least for software)!

In some ways, Git is like the 'Coming of the Railways'. It has brought
radical change, but at the same time, confusion, reorganisation and new
ways of thinking and working.


*Filip* has accidentally fallen into the attribution trap of blaming the
maintainer, rather than having an analysis and reflection on how Git is
being used in different user contexts. His user context may have
alternate expectations to that of the Linux eco-system, but that doesn't
excuse the lack of self reflection.

--
Philip
