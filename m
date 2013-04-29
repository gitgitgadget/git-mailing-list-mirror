From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] Minor additions to git-completion.bash
Date: Sun, 28 Apr 2013 23:58:53 -0500
Message-ID: <CAMP44s0Rp2mJ67f+=sq_g78hNCQSiStkeBMtcfK+kS30S=cXVg@mail.gmail.com>
References: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
	<CALkWK0mgfVNqOxaVY-JgKrzQe3rCJvaQuvp7frZKh7orRwdtig@mail.gmail.com>
	<CAMP44s1K9VYNbGFkec6mJ-xBZBafKvZqvu949DcVae12fuG9xA@mail.gmail.com>
	<7vvc76qyo4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 06:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgB1-0000jf-LK
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 06:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab3D2E64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 00:58:56 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:37433 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3D2E6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 00:58:55 -0400
Received: by mail-lb0-f172.google.com with SMTP id o10so416515lbi.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qfEsg+TruJE8YFJYR0TkEI8Pr5aeNwZPfqoPK65zH2g=;
        b=nLQKPhho/quiowZwJXw6L+jnrJPFNtl13K131uZvbok3cPxlrpa8QYLlhsHBbsEX8K
         yvrnGyOoS4CxfBCc0zB6uwe3h1eCse3s1iGM5IK2ZMsUFiPaNvslzPA/dpwBLlmnkZV3
         fHbhnGfn/4Q2vM0I9XrlqKftagPJ1bGvMVdSOLXCrW+oHAhEDKS8qU3hPPeJsSXlYVuY
         r4B7k+vDd/4HuGVs0v/UNxLF8oM1cszpnbUtLBOXF0D+BAjCa5lmcaxqr94Xdf8qzQ4w
         Fv6ow8vTBrDYBb+Oo1rMieQRFNHSnSEmb+8k3r0W9pR8IK1WoXYWhpZlZIC5s/9ANY0H
         xl2g==
X-Received: by 10.112.17.36 with SMTP id l4mr2090978lbd.103.1367211533792;
 Sun, 28 Apr 2013 21:58:53 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 28 Apr 2013 21:58:53 -0700 (PDT)
In-Reply-To: <7vvc76qyo4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222766>

On Sun, Apr 28, 2013 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Apr 24, 2013 at 2:49 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> Ramkumar Ramachandra wrote:
>>>> [...]
>>>
>>> Any updates on this?
>>
>> FWIW they all look OK to me.
>
> I do not have the original series, so a resend with Felipe's Acked-by
> after your original Sign-off would be nice.

I only gave them a quick look.

-- 
Felipe Contreras
