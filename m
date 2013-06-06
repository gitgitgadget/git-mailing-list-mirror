From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 13:16:48 -0500
Message-ID: <CAMP44s3JZh6sn77Tz9gaRZe2or-pbrCrHUhbxQysA1gQY0AzUw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:17:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkekE-0001r4-7q
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab3FFSQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:16:52 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61537 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab3FFSQt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:16:49 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so3331381lbh.24
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VQ6Nt2nA8XvuD5A+yWQJwEMUb5TEyTEPotRuTUM7Vsc=;
        b=XQXgNthvYJNHNKmmyYBVx3I+9Eu5wXJxV8vsEHpKb33LK0HmTuWPuYt1mIkU3zQzTs
         ejHgGK2jwr2tNLcfqR4vVX12ar0fxoVkqOLv0Fa4pX7laP0QyExTSWxUlQtlbzYiol+j
         jBk7MqJz8r3pmmIg+5NHx9D0zH2EVL5DgHx1CHTDJ2DFdD7o62OTX1GBoBNUnG+VejC5
         wIRrCWdksuUsF0dpmOVFBHK2S2z22INxKR5TsPkImu8LC96D7+Vy6ROt7xw2kaBfRsX/
         1QpTMVLm8wOSiIKVZ7XBnak6l82nn9xPeaeHD3ZEE+goPRTA4i7RHV1id6W31m62DTB+
         9dRQ==
X-Received: by 10.152.7.74 with SMTP id h10mr706887laa.83.1370542608226; Thu,
 06 Jun 2013 11:16:48 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 11:16:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226521>

On Thu, Jun 6, 2013 at 11:09 AM, David Lang <david@lang.hm> wrote:
> On Thu, 6 Jun 2013, Felipe Contreras wrote:
>
>> In the end my point remains unchanged; Perl is declining, so it would
>> be wise for the future to use another scripting language instead.
>
>
> Perl use may or may not be declining (depending on how you measure it), but
> are you really willing to take on the task of re-writing everything that's
> in Perl into another language and force all developers of scripts to learn
> that other language?

But that's exactly what we are asking the newer generations of
developers; to learn another language. Fewer and fewer new
contributors will come with knowledge of Perl.

> What are the odds that the 'newer' language that you pick is going to pull a
> "python 3" on you?

Ruby 2 speaks volumes on that front.

> There have been a very large number of scripting languages show up, make a
> lot of press, and then fade in favor of other languages while Perl has
> continued. It's not the sexy languange nowdays, but it's there, reliable,
> and used so heavily that there's really no chance of it dissapearing in the
> forseable future.

Yet it's declining, more and more every year. And the more the time
goes by, the more we hurt ourselves.

-- 
Felipe Contreras
