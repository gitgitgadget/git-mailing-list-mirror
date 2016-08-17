Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEAD1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 18:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbcHQS2n (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 14:28:43 -0400
Received: from mout.web.de ([212.227.17.11]:62027 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcHQS2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 14:28:42 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Mf0lB-1bpqEF0KfR-00OZVW; Wed, 17 Aug 2016 20:27:14
 +0200
Subject: Re: [ANNOUNCE] Git v2.10.0-rc0
To:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
 <bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de>
 <xmqqoa4uhwcn.fsf@gitster.mtv.corp.google.com>
 <20160817064245.GA5775@tb-raspi>
 <xmqq60qzbebt.fsf@gitster.mtv.corp.google.com>
 <xmqqtwej9txz.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <ab7cdb40-03f4-af04-d9c5-5b09e46968a4@web.de>
Date:	Wed, 17 Aug 2016 20:27:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqtwej9txz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:DfZjd9oM8HD+lx0c6peLB2zbf5P9NOv7FtUcNJeRw7gbDXkTjs9
 SSIGGpS3yXrejb3nZRTNPrUB2nY6Ghek8cgCcBMubjyXi/vfBKJpzBupjgJtxyTDq1B3a7g
 kq19uKcF2Qw01mtXoQy5Qy5e88VGyGkoMj/4Tcb7dMKFRdFd+8WC7IoUaFBZae1P43sAplT
 uSrBFmM4W3La71NWUDkgQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AQtxfcT/MdA=:csuhzK6Z4r69XaTWn1ogOK
 ZNU2yDU6ywP5g0sTUIaf+ECnHNCS9CWX3J+QUaIoh5KShtUsZ86Un3nqLkKQuFraBffZuXawj
 ozIwEJVX8OS5raH2Sn+LEyu3FcYkLQax2bp9AxtbNarxBCssuvGrfKODNMPTl4Dr8DL/90R7q
 Gt6VpZhbh2x+0vlhqVgG7fGaYyoLp5E9NaK3i/4YjiZtooYGXLJMaHAWnquCW3apWsqJ8G2Qa
 q0+tG2Qn1q5lcxl9MVwNRHBdC54MwwF3ZgCaEZP8Xl4aYWbRe6wIUIj6pGgZsd+tKBqQobrpm
 D5tV8TC9XAsoGk8wum/u4vDyZBLgD7qAfFQBNSnQDVtLgvDsq5/Scg8MvJJXk5LOI1pAE13hB
 uriR+kcScnDGSJmtJF/QDKCkGwudW5PD4drXofo3rGFDXEA+dyDygb2dMQYYK6vXXQ7BhhUO0
 w9CBZ7I9sntm8qQQgtWs23zPfEtU27FTTGvnjcJb7zFpFFoV/QoZrVGyTbC3loTRMbeMhbD0q
 qHcPKryq+L+glMbz8SOhrGrtpUjSeq+gR6BxdE7XS1pRBuGf6DM58t+xA8NLs1bPY8uHOPiqM
 1KZlr2gCLzSX6WVJoqFdSXyEtmnrfYBH9pYvCZFwLBCbvOb8OkoMWgVA8PK87EDTUs6zQcSaq
 2YEZli9HvMEx8SSo8NqZoRowTrYmYz4VsMthQzHA4vyXPZsgretOW1cKIe0Elmu6x5aTkvwi4
 XNX0SOY/6R+HsZTBN79knXPc+tB+g9TgYISCerI6wH16GRcMnhx9fju85/WMzAK/4cXqJouP7
 OAME3Zt
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 17.08.16 19:38, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Torsten Bögershausen <tboegi@web.de> writes:
>>
>>> Is this `text=auto` correct ?
>>
>> Thanks for spotting a typo.  Definitely.
>>
>>> I think it should be
>>>
>>>    used to have the same effect as
>>>    $ echo "* text eol=crlf" >.gitattributes
>>
>> Thanks.
>>
>>> # In other words, the `auto` was ignored, as explained here:
>>> +   $ git config core.eol crlf
>>> +   i.e. declaring all files are text; the combination now is
>>> +   equivalent to doing
>>> +   $ git config core.autocrlf true
>>> +
> 
> Just to make sure I got you right, how does this look?
> 
>  Documentation/RelNotes/2.10.0.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/RelNotes/2.10.0.txt b/Documentation/RelNotes/2.10.0.txt
> index 179e575..ccf5f64 100644
> --- a/Documentation/RelNotes/2.10.0.txt
> +++ b/Documentation/RelNotes/2.10.0.txt
> @@ -235,13 +235,13 @@ Performance, Internal Implementation, Development Support etc.
>   * The API to iterate over all the refs (i.e. for_each_ref(), etc.)
>     has been revamped.
>  
> - * The handling of the "text = auto" attribute has been updated.
> + * The handling of the "text=auto" attribute has been corrected.
>     $ echo "* text=auto eol=crlf" >.gitattributes
>     used to have the same effect as
> -   $ echo "* text=auto eol=crlf" >.gitattributes
> +   $ echo "* text eol=crlf" >.gitattributes
# Now we describe/define  the eol at checkouts twice.
# I think we can drop this line:
>     $ git config core.eol crlf
# The rest looks good:
> -   i.e. declaring all files are text; the combination now is
> -   equivalent to doing
> +   i.e. declaring all files are text (ignoring "auto").  The
> +   combination has been fixed to be equivalent to doing
>     $ git config core.autocrlf true
>  
>   * A few tests that specifically target "git rebase -i" have been
> 

# Just to be sure: the whole paragraph may look like this:

* The handling of the "text=auto" attribute has been corrected.
  $ echo "* text=auto eol=crlf" >.gitattributes
  used to have the same effect as
  $ echo "* text eol=crlf" >.gitattributes
  i.e. declaring all files are text (ignoring "auto").  The
  combination has been fixed to be equivalent to doing
  $ git config core.autocrlf true
















