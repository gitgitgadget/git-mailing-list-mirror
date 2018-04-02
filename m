Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C641F404
	for <e@80x24.org>; Mon,  2 Apr 2018 23:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754660AbeDBXrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 19:47:18 -0400
Received: from elephants.elehost.com ([216.66.27.132]:42581 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754584AbeDBXrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 19:47:18 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w32NlFeD080424
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Apr 2018 19:47:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Stefan Beller'" <sbeller@google.com>
Cc:     "'git'" <git@vger.kernel.org>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>        <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>        <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com> <xmqqfu4dxkky.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfu4dxkky.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.17.0
Date:   Mon, 2 Apr 2018 19:47:10 -0400
Message-ID: <01a501d3cadc$ee24a070$ca6de150$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhLuUQLx28uJBqsgyhh0QfTRDAYAHShdv4AZlZtpABvesl16SqDRSg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 2, 2018 7:20 PM, Junio C Hamano wrote:
> To: Stefan Beller <sbeller@google.com>
> Cc: Randall S. Becker <rsbecker@nexbridge.com>; git <git@vger.kernel.org>
> Subject: Re: [ANNOUNCE] Git v2.17.0
> 
> Stefan Beller <sbeller@google.com> writes:
> 
> > Patch at
> > https://public-
> inbox.org/git/010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge
> > .com/
> 
> Thanks for a pointer.  I think it was left behind and got forgotten while
> waiting for a reroll and tying the loose ends.
> 
> I'll go offline for most of the rest of the week.  It would be wonderful
if Git
> 2.17 turns out to be flawless, but that is not a realistic expectation.
Wishing
> for the second best, I'd very much appreciate it if people worked hard to
find
> and fix regressions and collect materials for its first maintenance
release
> 2.17.1 ;-)

No worries. We're running the test suite now (NonStop Platform) and assuming
all is good, it goes into our prod environment this week.

Cheers,
Randall

