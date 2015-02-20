From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 00:06:21 -0800
Message-ID: <CAPc5daVUqHd4YAJh9TyMZ8Og12ZGj1A9v=qpVNa+kV6E6U16Mg@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <54E6C78D.3070506@alum.mit.edu> <20150220072924.GC8763@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:06:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOibn-0004O8-43
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 09:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbbBTIGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 03:06:43 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:50216 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbBTIGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 03:06:42 -0500
Received: by mail-oi0-f45.google.com with SMTP id i138so1398214oig.4
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 00:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AhBeTv/6/Dy+PkWEr+YVVa7r6AcgdqtBw2Z8m+rVH3w=;
        b=wbTgkqd1WPvWDXcg27ZQaPrQ64+j6+xcJ8s0W1dySw8Z6neH3174bugnTEDa/2MsSK
         wIoce6ubmaeXG2OA2JjG9ow+AyMcaJhPxv7AupA5rekh6TUxNl/kSDfBZG10WNya4lG0
         pdXtcdTxlDUmvZMsF4HjE+2lTZVMMzxKWggg4vS3d8xGMzLrfIk8XTWXlv4XbMHWFAnF
         lgXOg9ZHoLgmLokX9BpzCHg0JiGMbdu/RnixlS5dsR/FhCsrX6fMYXoMl55mTzGlssZQ
         xL/CkbVlobzFeo0lCdD1AM4KILLc4qX5h4MHSbPvLPM6lKqabFBaddtLHkl0AVDl1N16
         uE1A==
X-Received: by 10.182.209.72 with SMTP id mk8mr5603296obc.54.1424419601611;
 Fri, 20 Feb 2015 00:06:41 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 20 Feb 2015 00:06:21 -0800 (PST)
In-Reply-To: <20150220072924.GC8763@peff.net>
X-Google-Sender-Auth: eeUuJgiwgjIM2wiz9bJ8BLh-UIE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264138>

On Thu, Feb 19, 2015 at 11:29 PM, Jeff King <peff@peff.net> wrote:
>
> This brings up an important issue. We cannot do GSoC without mentors. I
> had hoped that people populating the "ideas" list would volunteer to
> mentor for their projects.
>
> But so far the possibilities are:
>
>   - Stefan
>
>   - me, who has already promised to be stingy
>
>   - Matthieu, who also cited time constraints
>
>   - Junio, who contributed some project ideas, but who in the past has
>     declined to mentor in order to remain impartial as the maintainer
>     who evaluates student results (which I think is quite reasonable)
>
> So...basically 1 mentor and 2 reticent maybes? That doesn't look good.

Indeed, the mentor panel looks particularly weak this year, if nobody
can afford the time for proper mentoring.

Even though I can indirectly help by giving reviews at a more hand-holding
level than usual, there is a limit. And I definitely do not foresee acting as a
mentor myself.
