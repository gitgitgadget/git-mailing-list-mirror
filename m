From: =?ISO-8859-1?Q?Daniel_Nystr=F6m?= <daniel.nystrom@timeterminal.se>
Subject: Re: Whitespace and '&nbsp'
Date: Mon, 30 May 2011 14:52:38 +0200
Message-ID: <BANLkTinNwfuiFtg+y66zmgTJWSoWbB0wXw@mail.gmail.com>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org> <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home> <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org> <7vboyorm4i.fsf@alter.siamese.dyndns.org>
 <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com> <7vy61rrcae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 14:53:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR1xs-0003HU-U7
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 14:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab1E3Mwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 08:52:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58881 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1E3Mwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 08:52:54 -0400
Received: by fxm17 with SMTP id 17so2433281fxm.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 05:52:53 -0700 (PDT)
Received: by 10.223.98.4 with SMTP id o4mr3334846fan.120.1306759973100; Mon,
 30 May 2011 05:52:53 -0700 (PDT)
Received: by 10.223.89.141 with HTTP; Mon, 30 May 2011 05:52:38 -0700 (PDT)
X-Originating-IP: [85.24.181.147]
In-Reply-To: <7vy61rrcae.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 0IMaAyJVFVhRtPhJpiG-u2DV2jo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174743>

2011/5/28 Junio C Hamano <gitster@pobox.com>:
>> Again, I'm not convinced git should really care, but I'm also not
>> convinced that sbsp is necessarily all about the git whitespace
>> fixups.
>
> I am not convinced git should care, either, but if nobody else helps us,
> we need to help ourselves ;-).

Or write a standalone tool through which patches (and code for that
matter) could be piped, with the only purpose of showing "misleading"
unicode characters and the likes?

I can see even wider use of such a tool.
