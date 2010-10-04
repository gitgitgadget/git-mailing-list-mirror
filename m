From: Darren Hart <darren@dvhart.com>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 4 Oct 2010 12:05:20 -0700
Message-ID: <AANLkTinvOhTO4Zs3_wSvV4ONmbWK-=jjtjPLPW2F_54v@mail.gmail.com>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
	<1285967766.6750.2.camel@gandalf.stny.rr.com>
	<4CA9815D.3040801@drmicha.warpmail.net>
	<20101004075015.GN28679@pengutronix.de>
	<4CA98EF1.1050102@drmicha.warpmail.net>
	<20101004085050.GQ28679@pengutronix.de>
	<4CA99E43.1000204@drmicha.warpmail.net>
	<7vlj6d988o.fsf@alter.siamese.dyndns.org>
	<vpqfwwlvov1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qLn-0001kW-6q
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337Ab0JDTFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:05:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43832 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0JDTFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:05:22 -0400
Received: by qwh6 with SMTP id 6so3279647qwh.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:05:21 -0700 (PDT)
Received: by 10.229.189.83 with SMTP id dd19mr7339332qcb.92.1286219121169;
 Mon, 04 Oct 2010 12:05:21 -0700 (PDT)
Received: by 10.229.26.82 with HTTP; Mon, 4 Oct 2010 12:05:20 -0700 (PDT)
In-Reply-To: <vpqfwwlvov1.fsf@bauges.imag.fr>
X-Google-Sender-Auth: BcCJVV_gHbrkaYN8yYnl0-c90YE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158096>

On Mon, Oct 4, 2010 at 10:39 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> A "mirror"'s purpose is to, ehh, mirror a remote so that local
>> people can share it as a nearby copy.
>
> I think this is the one sentence that is missing in the description.
> Even after the patch, the reader knows _what_ --mirror does, still not
> really _how_ to use it.

Agreed, that would be a nice addition.

-- 
Darren Hart
