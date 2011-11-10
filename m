From: Jack Nagel <jacknagel@gmail.com>
Subject: Re: pretty placeholders for reflog entries
Date: Wed, 9 Nov 2011 19:56:54 -0600
Message-ID: <CAMYxyaWLEy3VEYcR26vc1pic1z59t4Rgnp7a03PhJ8EvSEmxoA@mail.gmail.com>
References: <CAMYxyaWPWVGUHz0qQOnARb9wexHCx73a04Bu_UhrJR=xrinX7g@mail.gmail.com>
 <20111107211325.GB7380@sigill.intra.peff.net> <CAMYxyaWJO7e8Lg__8N9BhL16mwfQtd-GBuLpBSCYmLMZ3gsMPA@mail.gmail.com>
 <20111107224556.GA28188@sigill.intra.peff.net> <7v8vnr1oww.fsf@alter.siamese.dyndns.org>
 <20111108054745.GD29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 02:57:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROJtQ-0000H9-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 02:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756987Ab1KJB5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 20:57:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63784 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983Ab1KJB5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 20:57:16 -0500
Received: by fagn18 with SMTP id n18so11684fag.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 17:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qz65t+3tCY2e4dVBhFt1T8GL0E/meoxBL5cJGYnQtzM=;
        b=gxp6+AoEazG5aTKbKikxV/UKegBCQsHmcjsuZXGBi7sd7RGKw++ZvNHzlZZuZ4LhOf
         pYG5xSFM5Zp6SDT5gh3wleHvKM+yuO0YVt2vW39AOkQ6D+p6wv+tucZzOoVN8kdD4rHl
         Q0/sNA83Igjwhd23npc0cIyuZ8APh7/vK+vGQ=
Received: by 10.223.7.20 with SMTP id b20mr8681134fab.21.1320890235114; Wed,
 09 Nov 2011 17:57:15 -0800 (PST)
Received: by 10.223.72.1 with HTTP; Wed, 9 Nov 2011 17:56:54 -0800 (PST)
In-Reply-To: <20111108054745.GD29643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185183>

On Mon, Nov 7, 2011 at 11:47 PM, Jeff King <peff@peff.net> wrote:
> Sure. I'll re-send the patch once the release is out. That will also
> give Jack and any other interested parties time to comment and test.

Thanks. I used this day, and combined with "--date=", it gets me pretty
close to where I wanted to be. But your comments about reorganizing the
date placeholders make sense, so this is perfectly fine for the time
being.

Thanks again.

Jack
