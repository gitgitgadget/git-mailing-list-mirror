Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D1EC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417D623BEF
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgLIQT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:19:28 -0500
Received: from elephants.elehost.com ([216.66.27.132]:29285 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgLIQT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:19:28 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0B9GIbLo033123
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Dec 2020 11:18:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Felipe Contreras'" <felipe.contreras@gmail.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Git'" <git@vger.kernel.org>, "'Jeff King'" <peff@peff.net>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
References: <20201209002619.25468-1-felipe.contreras@gmail.com>        <X9A1On3v35nEjL7i@camp.crustytoothpaste.net>        <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>        <xmqqlfe731vh.fsf@gitster.c.googlers.com>        <CAMP44s2xo=n4z6m7FhuPiZ66yPWvmdQuAodvh2XNpdVAfo6R8g@mail.gmail.com> <xmqqh7ov2y97.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7ov2y97.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH] Add project-wide .vimrc configuration
Date:   Wed, 9 Dec 2020 11:18:31 -0500
Message-ID: <01a801d6ce46$f2cad520$d8607f60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMa8e/vn8tNvHS03BrW9a/rqTdcswLK6y90AwfBnRcBWCbXHQFrgRpPAtWtGGanC0jrsA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 9, 2020 3:13 AM, Junio C Hamano wrote:
> To: Felipe Contreras <felipe.contreras@gmail.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>; Git
> <git@vger.kernel.org>; Jeff King <peff@peff.net>; Emily Shaffer
> <emilyshaffer@google.com>
> Subject: Re: [PATCH] Add project-wide .vimrc configuration
> 
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> *2* In other words, I doubt these graphs are depicting "how widely is
> >> an editor used by developers".  It is just showing how often it is
> >> installed, and I know the primary workstation I use daily has vim and
> >> nano installed without me choosing to have them, as opposed to emacs
> >> I had to manually install, and I only use vim once every month and
> >> nano once every quarter.
> >
> > Yes, but in Arch Linux at least no editor is installed by default.
> 
> I thought everybody has nano not because it is adequate and usable for
> them, but because it comes by default with distros, and distro in turn
choose
> nano not because it is particularly popular but is small enough not to
matter
> if left behind unused when the user chooses a real editor.
> 
> But you are essentially usaying that 80% of Arch users install nano by
choice.
> I find it doubly surprising.

I know of perhaps 3 or 4 nano users in the NonStop community. There are
probably three orders of magnitude more vi/vim users. vim and vi both come
installed on the platform by default. Nano is an add-on that my team builds
as a courtesy but there's small interest but it is loyal.

Regards,
Randall

