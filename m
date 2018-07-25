Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A771F597
	for <e@80x24.org>; Wed, 25 Jul 2018 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbeGYVMr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 17:12:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:54389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbeGYVMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 17:12:47 -0400
Received: from MININT-3BS5S37.fareast.corp.microsoft.com ([37.201.195.94]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Mdren-1fLVuf1RKX-00Pcov; Wed, 25 Jul 2018 21:59:28 +0200
Date:   Wed, 25 Jul 2018 21:59:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: No rule to make target `git-daemon'
In-Reply-To: <20180720221259.GC18502@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1807252105070.71@tvgsbejvaqbjf.bet>
References: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com> <20180720210459.GA18502@genre.crustytoothpaste.net> <CAH8yC8m7T8k8usGnV_OYp9G=2N4_jdzLT6frme2iBrLnt5iqnw@mail.gmail.com> <20180720221259.GC18502@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s1nNFUNhcDak8+QxIreO858UqTUSx1Zsu6hplaqD4Ab2is4QHJT
 XvrLr3xLMMrqu/Jgjm1A/rq8sKxXLSnTSwpd3wtGud8H66NUpetSMgivTFR7DqffFzYlvUM
 m7G/nro6yYRxBbjwdWee1qRQ0iak1d4Wv8QEAZXjMZPXp3PekZMPWrktt5qDXbhCFQvliEc
 uPIGxVHWhSKOddxkePofQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c3Ugw9/tktE=:6egldqOKw3hVbYfsKs0zds
 LA1CYMLqJpvoqwr02ZAcuxdlEZvVEhyQvRWSGhTmLuylcZwbhbceeUijI0mHn+03DbR8ZwC38
 HLt1xW3jcAwrJhjSbZPUf7eTPu3bEHEftgXqsl8i5yyfuximP3YH5Ayf5YTK2kKnV8Mw9is0J
 dwMjw04S5QxmrYIe6wSA+WErwV+ZNdzJDy1OHbSofNfr4cxzJgpPs3sBp1oFQfkYSe6nvr77v
 mhaC0UT6ilkHVdqmusmMv3iBcBWia3NKsn2c3VsL5x7Z11ivG+L2s5hJC9DUeEb8TSb4e6vQW
 wLFHI+8gEAlC5XEWoF8Ip4DjCp6tv1+1FsaBZ/6fi1b2EYzUyHtaLIx81D9Xe5fJyAyuU99Ao
 Ub6cld0YXclgWJDxgcLN/CNnaBlr2gHTwnkGnzU4LIe0MBoqdttRoWoI3MW0bpWiLicR7M/rF
 KiFmFueMMoLF/G8p9t9hK6X7q51mIwaR1KXLlXbZlzvScFL/IBd8glxfROO73XuOc4j4PYWc/
 Sx50lFSd/RC+HABTAIf+rKwAkfOgIusLfT4BaanedASo/k5+UPtYKXeQYBRogvSM/wUoAqk3n
 Ehyd7bJrRBWUo7xR5DLH+0NcXiaNZSExZX3hvsLRgY27/chsiWWHgOTbHrcjNjxTZsJD9/+t2
 dwG2psMjXE164z75Hlj4lYVxQOa/+39VKVfjqzv6N9UYqH9ABK26i8bMO7c75y75QffRsdPXU
 dp2Tco4Bevh3cR/lIb0Rc0JvZ05Z041f63zg4eThO3WHgV4gGubQldLRm75eYEfBMhZyvX89G
 ZlZO31/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 20 Jul 2018, brian m. carlson wrote:

> On Fri, Jul 20, 2018 at 05:51:46PM -0400, Jeffrey Walton wrote:
> 
> > (If anyone is interested in first class Solaris support then I am
> > happy to help. The patch set needed for the platform has been stable
> > for the last couple of years).
> 
> I'd certainly be interested for you to send it to the list.  I'm not
> sure I can provide a helpful review, since I don't run Solaris, but
> having better support out of the box would definitely be nice.

The cURL team has some SunOS build IIRC that was nicely integrated with
their GitHub-based CI. Maybe we could have something similar?

Ciao,
Dscho
