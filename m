Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3DEC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B9120721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgEDSTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 14:19:10 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19147 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgEDSTI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 14:19:08 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 044IIMd9049557
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 May 2020 14:18:23 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Robert P. J. Day'" <rpjday@crashcourse.ca>,
        "'Simon Pieters'" <simon@bocoup.com>
Cc:     <git@vger.kernel.org>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com> <alpine.LFD.2.21.2005041351170.220597@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2005041351170.220597@localhost.localdomain>
Subject: RE: Rename offensive terminology (master)
Date:   Mon, 4 May 2020 14:18:17 -0400
Message-ID: <056c01d62240$66084e40$3218eac0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMHF4C68syg6gZU1RF29TrqBuT+VAF83mBkpippuDA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 4, 2020 1:54 PM, Robert P. J. Day Wrote:
> On Mon, 4 May 2020, Simon Pieters wrote:
> 
> > "master" is an offensive term, as it can be interpreted as being
> > slavery-origin terminology. See
> > https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_co
> > ncerns
> >
> > The Python programming language, and various other projects, have
> > taken a stance and moved away from offensive terminology including
> > "master". See https://bugs.python.org/issue34605
> 
>   uh ... i just popped over to that python.org discussion, and it does not
even
> *remotely* resemble what you describe. the gist of that discussion is that
> most people seem opposed to a sweeping change, and are annoyed about all
> the bandwidth that was wasted by one person harping about this.
> 
>   based on what i read at that link, python has in no way "taken a
stance," so
> i'm calling you on your rather egregious misrepresentation of what
happened
> there.

If you are the repository owner on GitHub, BitBucket, or GitLab, you can
change the default published branch to whatever you want, which is primarily
where the publicly visible name would be - discounting private repos.
"master" then becomes irrelevant and you can use "main" or "whatever".
However, GitLabFlow depends heavily on the name being "master" for the
workflow to make any sense. The OP might want to take this up with them.

-Randall

