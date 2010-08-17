From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [GSoC] Libgit2, Summer of Code is over
Date: Tue, 17 Aug 2010 09:53:58 +0800
Message-ID: <AANLkTikUKS7jjXyzLY0h50jg1gdDsKKWM3ZkPQcbgAJ7@mail.gmail.com>
References: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 03:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlBNP-0005Iy-9D
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 03:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab0HQByA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 21:54:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40191 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab0HQBx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 21:53:59 -0400
Received: by eyg5 with SMTP id 5so1695487eyg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 18:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=brXjLRM/mPQGEl3TTvYIiuNbJS/dNfVuFVeT1u7OWoY=;
        b=w7VIneIO0dp5kyS8l1LaYupRvEm3JrMInUf3OD8lOgt87G8jGS+GR0lOADmYA/IFkF
         bFFGzPvqqKpf0aoeigKftjvUjHorMAtRuglocDWOid1YUbTcnzUbGRr1n5b5TCtjSEOK
         glgbOIs7g42z6dgeIMmaK5H2PR6/dabzNvors=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ND/VkL1vlviOqyDDZuSxdf/LEusYMnHePGFfuhNnkBMxHj59IvZOY1uxg8RYBxSU2q
         BP9mVJJpT4eQDMKaWKMfLCopwXiK5GmvfDUvYw5XEyJK/WJhL1+hRmAell5s/73ogsRM
         6/nQzKzzx8QaEWZM3E7CIqaKq/vjyxefV4CDY=
Received: by 10.213.109.10 with SMTP id h10mr334503ebp.50.1282010038272; Mon,
 16 Aug 2010 18:53:58 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Mon, 16 Aug 2010 18:53:58 -0700 (PDT)
In-Reply-To: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153682>

Hi,

On Tue, Aug 17, 2010 at 3:46 AM, Vicent Marti <tanoku@gmail.com> wrote:
> the Summer of Code has just reached its end and I'd like to offer some
> closure; neither me nor my mentors have been too active on the mailing
> list -- to be fair, there was too much work to be done on the library
> before it could be considered of general interest. We've been focusing
> on that.

IIRC, Scott Chacon from github is your mentor?

I wonder if libgit2 is being used at github (either directly or via
ruby bindings) - not only will it help through real-world testing, it
will also help to boost "street-cred".

-- 
Cheers,
Ray Chuan
