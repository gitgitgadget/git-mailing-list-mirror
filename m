From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Thu, 15 Nov 2012 03:14:30 +0100
Message-ID: <CAMP44s0Mrdj6rr3BGuwNW1OHjks_LvymUGK5thtBqX45SRSU+Q@mail.gmail.com>
References: <20121113032727.GA8387@sigill.intra.peff.net>
	<CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
	<20121113040104.GA9361@sigill.intra.peff.net>
	<CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
	<20121113074720.GA18746@sigill.intra.peff.net>
	<CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
	<20121113164845.GD20361@sigill.intra.peff.net>
	<CAMP44s3sBj0iYsCLUpiouUB8PXRwLORDEyD_+dWKrSsMP+TOaw@mail.gmail.com>
	<20121115000726.GA16910@sigill.intra.peff.net>
	<CAMP44s3vYP6zR6sKxgVSoZUySxcAuR7MioMeT1WDAnU0PtZKGA@mail.gmail.com>
	<20121115015052.GA19131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 03:14:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoyb-0000GR-4v
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 03:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423501Ab2KOCOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 21:14:31 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58643 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab2KOCOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 21:14:31 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so1204929obb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 18:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=URW3qDax7TY7FoOh4FCrnyYwUVVIZvPOA01fP/7G9BY=;
        b=k3jZz6prxx8xhBKjIGuUJS/V8h7bcSPfIwVoTYYi1gyH/5YS94eyEFksxqaQR2QoIm
         NzQVsp0oLxVHzXg6pOaw9q9ZA94BujGQAyKr31nnjL1W52rZjwIjG+1tVYvGXDK7/fLs
         6TE3MvIr8tKmDdpHsQtd5YxeRKK/XwxolI0tF+IIETWolJuCnYpOD02BI2Pcq8JGF1ij
         Dytt4+m/L3CyIHKg8kN0svpHlORnT46iHzpllxSi2LDTeZXlw7ERG6VqjmGYMvFzhZY4
         oCsLxqEP/CjjJlE2eWG/xJ5E1ftDb6Tg1NUsStPKrCDF4oIdEwSYZXaP/BiKtZmzIs3V
         SNlA==
Received: by 10.60.26.234 with SMTP id o10mr21569647oeg.85.1352945670575; Wed,
 14 Nov 2012 18:14:30 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Wed, 14 Nov 2012 18:14:30 -0800 (PST)
In-Reply-To: <20121115015052.GA19131@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209792>

On Thu, Nov 15, 2012 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 15, 2012 at 02:41:50AM +0100, Felipe Contreras wrote:
>
>> But that I meant that when I introduce a regression it's like I'm
>> killing all that is good and sacred about git, and when you do it's
>> everything but that.
>
> The rhetoric in this statement is a good indication that there is
> nothing productive to come from our discussing it anymore.

The point is still true.

>> > If you want to seriously propose changing the behavior of "git commit",
>> > I think the best thing would be to make a real patch, laying out the
>> > pros and cons in the commit message, and post it. I would not be
>> > surprised if the other list participants have stopped reading our thread
>> > at this point, and the idea is going otherwise unnoticed.
>>
>> I would, if I saw any chance in it actually going through.
>
> Well, it certainly will not go through if you do not try.

At least I wouldn't be wasting my time.

Cheers.

-- 
Felipe Contreras
