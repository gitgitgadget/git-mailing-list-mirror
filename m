Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A6A1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 14:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbcHLOhV (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 10:37:21 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35766 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcHLOhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 10:37:18 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so1574017pad.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 07:37:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=0n2AwfiSH2cprPPDFUQJhi4l0IA7JVuGc4Z6ySIggPU=;
        b=A1D1LZfkaArzZFKjuokzJHsNFqg3xYtQSZThiarNCsWl7H9SJFs+c3n2iblmLuTqlm
         u2SHl5T1hf5Y0QeWYaNEz5aakOWOEMNXCHt5EFWge9rZMqVXXkKxS9WBwkxPP0j6DH6U
         KgXD+idSMS84VnNpA1npAqsojZEP9hztr+QgGl8qF1p7dwF25gDMT2rEuf+koIKT32Bh
         11KixDjiSk1rmu68Pzv99YM9GxDwtewSjJmzGtHLK9m2mRIpFDsWs1Vkv/5NVgFccDAz
         2HO+iraSqa8RNRRvOBj9xsE28f/n5V3wgm6eafIuEkMb1ck21WFwpxS9UY5bG+8eH7YR
         Ky2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0n2AwfiSH2cprPPDFUQJhi4l0IA7JVuGc4Z6ySIggPU=;
        b=mQ/gF/Mxt/cFyuzM8TnXmhMnRiAvUbY7vM+4doHFx+5aEwj7K8okJOb+IimkPOFN5N
         OncpcaRVGtLs+jBes8nNgiDWpHzyAqpGaujCnCqqhAlBlc86l0LVKpoti3lMxwSSkKt9
         ng0BWr+opsNgzm7JGiwN7AIR5P4d/IWsrqYV2dWfyHA5dSgo4Tv8CdORlKMfkPr8GbX1
         2RDMke1i8lX18OSIHnOfQ+jXpwcIHW+zjDPSJC9oxDQJy5nWndi2s0BFnJ+86m8KBRgc
         xW5HYyy4Rx8elJ2JiKrQZk1b+N2wlIQ3UntyDERmv0cxsDzOw/kml1LIJGH9vLZ5g2VB
         Ybhg==
X-Gm-Message-State: AEkoout6HCvPaXx5Thz5F3Map6FY2yMJa9xObJ/GFYl8XrQt0JQZSJ3DK5sGxVwskiLBoA==
X-Received: by 10.66.82.42 with SMTP id f10mr27854381pay.17.1471012637548;
        Fri, 12 Aug 2016 07:37:17 -0700 (PDT)
Received: from Jons-MacBook-Pro-2.local (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.gmail.com with ESMTPSA id z10sm13641267pff.95.2016.08.12.07.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 07:37:16 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
References: <nn1euf$h6q$1@ger.gmane.org>
 <d2ef9717-beb2-2661-d0b0-4e33f82511ae@gmail.com>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <be1b1fcd-48d7-facd-f45c-0c52e6c12e88@gmail.com>
Date:	Fri, 12 Aug 2016 07:37:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <d2ef9717-beb2-2661-d0b0-4e33f82511ae@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 8/12/16 6:11 AM, Sitaram Chamarty wrote:

> At present gitolite is -- AFAIK -- the only "pure server side", "no GUI"
> solution for access control, and has some interesting features that more
> "GUI" solutions may not.  It is also (again, AFAIK) used by kernel.org,
> Fedora, Gentoo, and several other open source projects as well as many
> enterprises.
>
> If you're ok with adding that, I'd be happy to supply some text for your
> consideration.

I appreciate your offer and I don't disagree with what you're
suggesting, but my goal, for now at least, is to keep the same coverage 
as upstream.

If they add something about Gitolite to their next edition, then
I will also.

Cordially,
Jon Forrest

