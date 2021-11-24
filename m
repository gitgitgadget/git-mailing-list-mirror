Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59444C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 21:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbhKXVPa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 24 Nov 2021 16:15:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:64361 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbhKXVP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 16:15:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AOLCFmk045210
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Nov 2021 16:12:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <git-packagers@googlegroups.com>
References: <xmqq7dcx1ent.fsf@gitster.g>        <000201d7e173$3eb3d320$bc1b7960$@nexbridge.com> <000301d7e174$1b568570$52039050$@nexbridge.com> <xmqq35nl1dsh.fsf@gitster.g>
In-Reply-To: <xmqq35nl1dsh.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.34.1
Date:   Wed, 24 Nov 2021 16:12:08 -0500
Organization: Nexbridge Inc.
Message-ID: <000c01d7e177$f43327b0$dc997710$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLMPeZyQzNqkxJMp5NZJ0GWXnoyAHsQPH9Av+RRgcC+Nw176vtaDqw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 24, 2021 3:48 PM, Junio C Hamano:
> <rsbecker@nexbridge.com> writes:
> 
> >> In an unusual situation, make reports:
> >>
> >> GIT_VERSION = 2.34.GIT
> >>
> >> Instead of the expected
> >>
> >> GIT_VERSION = 2.34.1
> >>
> >> which we see usually.
> >>
> >> Am I missing a step that was added since 2.34.0?
> >
> > Oops. I have to build off 'maint' not master. Got it.
> > -R.
> 
> You made me cut my lunch break short to double check, but all is well if the
> release materials are good after all ;-)

Hopefully when travel is permitted and I can next get to your area, I can repair this with beer 😉
Cheers,
-Randall

