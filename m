Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F111FEAA
	for <e@80x24.org>; Thu, 23 Jun 2016 07:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbcFWHFZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 03:05:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57036 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcFWHFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 03:05:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5N74trO027460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 23 Jun 2016 09:04:55 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5N74txJ016040;
	Thu, 23 Jun 2016 09:04:55 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
	<20160622024151.GA20206@google.com>
	<20160622190018.GA786@dcvr.yhbt.net>
	<CAPc5daUiUv-EEv7ouQ=K+Q8S64QVV5wn4H6+TuF0wLeo123K5Q@mail.gmail.com>
Date:	Thu, 23 Jun 2016 09:04:55 +0200
In-Reply-To: <CAPc5daUiUv-EEv7ouQ=K+Q8S64QVV5wn4H6+TuF0wLeo123K5Q@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 22 Jun 2016 12:02:18 -0700")
Message-ID: <vpq8txwtmg8.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 23 Jun 2016 09:04:55 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5N74trO027460
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467270299.63346@DvqUZFUPvwZaJKOWsxLyRA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> On Wed, Jun 22, 2016 at 12:00 PM, Eric Wong <e@80x24.org> wrote:
>>
>> Just wondering, who updates
>> https://kernel.org/pub/software/scm/git/docs/
>> and why hasn't it been updated in a while?
>> (currently it says Last updated 2015-06-06 at the bottom)
>
> Nobody. It is too cumbersome to use their upload tool to update many
> files (it is geared towards updating a handful of tarballs at a time).

Then, I guess it would make sense to remove it to avoid pointing users
to outdated docs?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
