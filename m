From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 23:38:47 +0100
Message-ID: <AANLkTikDLV0LC_35aJAiV5LrdQj_2vDkCzOwmwDQ+6YH@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net> <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net> <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
 <vpqr5bath2z.fsf@bauges.imag.fr> <20110214223557.GA13070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:39:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp75D-0005bt-JU
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab1BNWjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:39:31 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50080 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab1BNWj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:39:28 -0500
Received: by yib18 with SMTP id 18so2288633yib.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=acBYwjQ/1+jEhc8WDBxJ9vq6slgZC5ZkPtjv6AVpu9M=;
        b=QN5nv5TvqMBdGmOvzTZYrJsMMqW/ukhOEqKJxqgd0Eq3iCxXog+LEraUqwuOmjMPWH
         N/5oPOmjfiMGfO8MesvQCdiAGziQl1uLaOnDJ/JaJ+YCPM6ssepQEQr/Use8pnBx6PqH
         eho6r2T1HZFEiJxCsUW2h/7/ZBK44hnVuOZd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dneYboapERDvUVfHlYKVY2+vGtSgqDhqWOparhUg/6BdcjJDWmwrWnwE2ZHRuYoN+F
         9bZI6JTsC+UvTsYjpT94Za/QInf6VZ87W9azyOkqD8yF/MGmJkzvTGpd6xcfTeS+g6lV
         K8lv7c4gPIsrVWc5vDOcEA0MbQQJlAqtvXFRs=
Received: by 10.150.150.3 with SMTP id x3mr5051335ybd.336.1297723167521; Mon,
 14 Feb 2011 14:39:27 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Mon, 14 Feb 2011 14:38:47 -0800 (PST)
In-Reply-To: <20110214223557.GA13070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166788>

Heya,

On Mon, Feb 14, 2011 at 23:35, Jeff King <peff@peff.net> wrote:
> I think the whitespace makes it easier to see there are two choices, and
> most people have some kind of triple-click-to-copy-whole-line in their
> terminal.

+1 to giving a clear way to choose either the current or the
new-default behavior. The only thing I can think of to make it even
better now is to inline the description of what those two modes mean
;)

-- 
Cheers,

Sverre Rabbelier
