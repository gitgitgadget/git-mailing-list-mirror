Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638441F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 07:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbcHZHE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 03:04:58 -0400
Received: from mout.web.de ([212.227.17.11]:59177 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbcHZHE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 03:04:57 -0400
Received: from [10.12.248.195] ([5.57.48.80]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M6mL2-1bFtZG0IAW-00wYde; Fri, 26 Aug 2016 09:03:43
 +0200
Subject: Re: [PATCH v1 0/3] Update eol documentation
To:     Junio C Hamano <gitster@pobox.com>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <20160825155255.28929-1-tboegi@web.de>
 <xmqqy43klhds.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <3ab51b90-f0f8-52b1-e12f-adb151f031bf@web.de>
Date:   Fri, 26 Aug 2016 09:03:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqy43klhds.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:383kq+98cpa6cHGqMmCVUre/wwgtuFK4dD3FQyY0c6ZJVyeTv6E
 dEoMm5BBqCcgiKqRAebEo6WRGlqO2E1Bdoy5gMOxhiA9+Ghn+zZtgtqwKpcFFE75RiK9z0C
 HQeprJp0zHgtWpHYVxe41mdKFXOSw7CDh0SJKF2I7BTJxGk01n1hrBLmz+E4HKR84laDKck
 q0g7MtmfPt5oq9PD1XnbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DDjqjB05CZ8=:n4Nuc/CdfjtWrOf9AmIG47
 h+8KRy/g9kh4iXoJLUe15ttbEsTN3/02VaX6nrcO6i4ca/rz+CStnZxIzXUDUuXW4IFtaAUuR
 FTqjNI1qn+n/5aswMoXNcjVhJsrlZLVl0SF99jArB88etPuECxVclpa5DyRaQmR4tvoUGsUPo
 Io0FaHiy6xT2vI0CgEwRPtHCEVJDgZ2TfDyWaqNrV+EeKDms0SHEr3saSNo0wDdSxBLOLYyox
 6KC1VGCslbhQwO7TpbpWgZhl/hVzCtFUqlJhr+qKp7S5UcUsjTtXMx/VDgebOXzlYrhqbS5cf
 SMM9yj4c6cXy+99C/cEkFQe79y1KN9XZhQC7WPYEWvFZdOdABxTWNrMkfwvsIsaQ6ZQb9Kca0
 3/LSHc69ctqksrQYt4BLMLdVeTyfRLKOMsUmdTSBe+dgw0pf0pufG2aw6YyZDdL6+cAJGT9F6
 wa6wsoZ/42JTGzWa469cCVliyVNHQ9N68aZVNNrdaWofDO0MtlZeQ10f82Mt/6QFzj8vO4Kuo
 0FZvUOqo+jxoqK2EyXV2IpYDrBFf/pyK13aU6mBZlqj0Bf4pTXQoXQQlKh5aJdY7lNCKKbtSH
 4dA42L6k5ShPv/fUnJ0N4oxBrQFIwsdSe4e7qwP0aQce4dWHeh4Hct7pc2AjturMHvfJUUdOo
 PPnuIHDoMea0OiIcC9vntro7hI8pcZws8NKTyQH8UAJDSNdvNPsL2LBoGxj1mbiHN8OGXuQ7W
 EuZ8gQamR1r9eTuGaNgMOCd5510EsLoZkI7gBVZcDTqazHST3WWt0FKX133ubUEjeEuFVmRX8
 RsBDsWm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/08/16 22:31, Junio C Hamano wrote:
> []

> This [0/3] is meant to be a cover for [1/2] and [2/2]?
>
> I am trying to see if we broke format-patch recently, or it is a
> manual editing error.  The latter I do not care about; the former I
> do.
>

No worry, 0/3 is patched by me by hand, sorry for the confusion.

