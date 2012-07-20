From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 12:19:57 -0700
Message-ID: <CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	<7vhat2toz8.fsf@alter.siamese.dyndns.org>
	<CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 21:20:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsIkC-00021H-NJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 21:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab2GTTUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 15:20:00 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51363 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab2GTTT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 15:19:59 -0400
Received: by lbbgm6 with SMTP id gm6so5437257lbb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=cgJ9XKsJwUhj1xmEih/U1nhwqsI3kXiCYgT34PrGMEg=;
        b=BTzHQWK82rofXls/E2FrrwBTAKhvkT1Yj9PWBdl9QcFloi2tYTs/lj8zF31urap1l6
         SPcUpLcqfjvLtE974l/XU8SLJd0NN1TEk9kKUzCsUGridJfZuwq5C5W1y+1DU2ZI6EYS
         3C0XVM5JlYyKxALClkJ2fRm7mz6BIlAPf8JB3YV5lRviKnaJDhg8QSl8pjaiZYg/ZhCE
         if5h+tO+CPP7Swq9kYOISkMknRy5IcTZEALQ2YN0MLUPH8akdigzi3uw9ZG5ukirKRJa
         0lGTw/2wNK1MA0soq8m2T5njWrknzlplc6fZJ9ezYjpqfqnRGibBpzodPMklFBNX0595
         ps6w==
Received: by 10.152.106.233 with SMTP id gx9mr7418121lab.48.1342811997757;
 Fri, 20 Jul 2012 12:19:57 -0700 (PDT)
Received: by 10.112.5.102 with HTTP; Fri, 20 Jul 2012 12:19:57 -0700 (PDT)
In-Reply-To: <CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
X-Google-Sender-Auth: f8s09JBpqebZSZ0ZDAflPx-i9iU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201790>

On Fri, Jul 20, 2012 at 8:49 AM, Thiago Farina <tfransosi@gmail.com> wrote:

> What I'm looking for is to upload/create the remote branch in github
> from inside my local branch, without having to checkout master in
> order to do so.

In that case, do exactly what you did, except don't checkout master.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
