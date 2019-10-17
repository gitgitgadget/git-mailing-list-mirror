Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE43D1F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 13:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437267AbfJQN4F (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 09:56:05 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:45542 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfJQN4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 09:56:05 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iL6G0-0006ZP-60; Thu, 17 Oct 2019 14:56:01 +0100
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
To:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
 <20191010001853.h2pepvg7yilevipv@dcvr>
 <20191011055827.GA20094@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <00cb61a1-0044-1faf-b237-2ac449a34091@iee.email>
Date:   Thu, 17 Oct 2019 14:56:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011055827.GA20094@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On 11/10/2019 06:58, Jeff King wrote:
> I snipped your concerns with some of the language. I do agree with you
> that a lot of is open to interpretation. But I also think it's
> impossible to get it 100% airtight. My feeling was that it was a good
> idea to go with some existing, well-established text, even if it has
> some wiggle room. And then rely on the existing community and especially
> the people listed above to do that interpretation.
>
> So...
>
>> Just pointing out some concerns of mine.  No ack from me
>> (but it's not a NACK, either).  I'm pretty ambivalent...
> For me it is obviously an ack, but I wanted to make clear that I think
> your concerns (and those of others who spoke up, like René and Gábor)
> are certainly_valid_. I just think that adopting this CoC is, while not
> perfect, the least-bad option.
>
> I'd also say that we might consider living with it for a while (6
> months? a year?) and seeing if people have an interest in revising it
> after that point based on experience.
  I also didn't positively ack the CoC (code of conduct).

I'm not sure it addresses the broader _underlying_ issues that may need 
to be addressed that are behind the pressure for CoCs. I'd also 
commented [1] on the git-for-windows CoC partly because the CoC didn't 
positively address the need for tolerance.

These CoCs are essentially defensive, rather than forward looking. In 
essence they say:

We are a welcoming and inspiring community, open to anyone and 
everyone(all 2^16 variants).

We list various egregious behaviours that are unwanted and hence 
intolerable.

We list responses to such intolerable behaviour.

However we (in the CoC document) don't really address what we may need 
to do to extend the community to the broader many.

Part of the wider problem is we often don't appreciate our pre-existing 
organisational biases (e.g.[2, 3]) that we fit into within a community. 
For example the implicit gender bias toward independent sole author 
contributions[4], rather than the inclusiveness of co-authorship as a norm.

While following peff's "interpretation" document link [5], I did see, in 
the wider kernel document, that it does have a "Co-developed-by:" option 
[6] but then requires a secondary "Signed-off-by:", thus making those 
who co-author do extra work, which shouldn't be required.

Thus, while the CoC is good, for clarifying the egregious behaviour 
issues, it doesn't really address the wider 'Diversity and Equality' 
*expectations* within the community.

Philip

[1] https://github.com/git-for-windows/git/pull/661#issuecomment-186846113
[2] "institutional racism" 
https://en.wikipedia.org/wiki/Institutional_racism
[3] "institutional sexism" ... no Wikipedia article?
[4] 
https://www.computing.co.uk/ctg/sponsored/3082288/want-to-increase-diversity-it-starts-with-the-job-ad
[5] 
https://www.kernel.org/doc/html/latest/process/code-of-conduct-interpretation.html
[6] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

