From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Tue, 20 Aug 2013 17:12:47 +0200
Message-ID: <CALWbr2w7XCuD5tUSwR+Cwv4wyXLk8MHDGyU2Dr+jA9vOfDYqig@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
	<87wqon7ok4.fsf@igel.home>
	<7vli52uym0.fsf@alter.siamese.dyndns.org>
	<20130720002241.GA22143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Rahul Bansal <rahul.bansal@rtcamp.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 20 17:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBnc4-000253-Te
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 17:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab3HTPMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 11:12:49 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:63776 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab3HTPMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 11:12:48 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so2545766qab.8
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RtMIXPX7rq90s+6wWLypF7mPgWiDScxamwmvjbhR4vI=;
        b=IaAJRMpxJu/o5G2rfJEGp8Kcjac4m8jHEOWNmJZ9yhdREgHn76pT0hZpWPjLX8pZ9Y
         WH9/fH7NsuMuW0MS3blYsWVUSDPDVilqzUbsjY6AsmLJ6AaGujGfVggDP5LUEzD+LfV+
         eoO4kF2WnLKTN9zmACBykrJGJY1laWmnMmwOtjpLM/uSB27N1knhhjKoJ6sHZjJHx4m8
         49LqihfJ2aA0zFHI04+7cdoEGQid8Bs1ZeEFQm8K/JeY9KU7ZgkXL8r7h5uUBmMqKyrd
         qKzJm859XKoj+LUSe9WEhiFuSwa+FPa03NwsFTvfIMjHgxAe2kX/SQxKvvCNvoIifvAS
         F5dQ==
X-Received: by 10.224.54.210 with SMTP id r18mr4500917qag.62.1377011567990;
 Tue, 20 Aug 2013 08:12:47 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Tue, 20 Aug 2013 08:12:47 -0700 (PDT)
In-Reply-To: <20130720002241.GA22143@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232611>

On Sat, Jul 20, 2013 at 2:22 AM, Jeff King <peff@peff.net> wrote:
> I do plan to finish it eventually, but if anyone else feels like picking
> it up, I'd be glad to review patches and/or share my work-in-progress as
> a starting point.

Hi Jeff,
I have some free time to come, and would like to work on that feature.
Does the offer still hold ?
If it does, I would be interested in your patches.

Cheers,
