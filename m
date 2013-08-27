From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.8.4
Date: Tue, 27 Aug 2013 07:40:43 +0700
Message-ID: <CACsJy8C3rbxLmSgoR6LY6okHOC=1U4rcdH3CXSYB==+5d81aUg@mail.gmail.com>
References: <xmqqfvu0nkim.fsf@gitster.dls.corp.google.com> <alpine.LFD.2.03.1308232242180.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 02:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE7LX-0008Em-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 02:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab3H0AlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 20:41:15 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:57022 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab3H0AlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 20:41:13 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so4504020oag.12
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 17:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VVE2uzX9rNWmkrTvz7xY7r9tj19HPNxs4NXntONgmVo=;
        b=rwBlw1WwuNb4V+Pxrah41I0AOLsdqg4+HsLobUdS/5g5FyXbtQmMKoScA93VQ1kSjq
         t/JN96GotPJcPLr0XHe7o6aNhjrpMl3guOwZs9ueAbUcpiFmFhbcutJdeREoBu3irf6p
         7P/qMZsandncVnhHGt+gNeg5WWNRURVGZrTXOLUfYR2O0lJFjFXC/IxSH8OmGPhXHC47
         uOQaApYfGY3+XjeyVNDvIr8KMNAnvx+m0Y2y/Jtuuzd/cyahakC6fRrPMfCIKC9vs38h
         2qDl2TxNk0CJzPTXE5axZ0eP/AMUKBfw7LX2N8NWHybT2bFHUY8KtW91h4QCmqAkyRvA
         C5nA==
X-Received: by 10.182.121.137 with SMTP id lk9mr16823603obb.32.1377564073289;
 Mon, 26 Aug 2013 17:41:13 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 26 Aug 2013 17:40:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1308232242180.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233039>

On Tue, Aug 27, 2013 at 7:06 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Yes, after being vaporware for many many years (I don't even remember
> when I started making references to a possible pack format version 4 --
> certainly more than 6 years ago) I finally completed the code to produce
> a new pack format I'm actually happy with.
>
> ...
>
> But the biggest gain will come from direct interpretation of the native
> pack data encoding.  However I'll let others do that part, as well as
> the required fsck support and all the backward compatibility handling,
> etc.  Now that the encoding design is pretty much settled I think it is
> good for review, and for others to get involved as well.
>
> Interested?  ;-)

A clone url, or a patch series please! :-)
-- 
Duy
