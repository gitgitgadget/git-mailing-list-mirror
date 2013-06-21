From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 21:37:47 +0530
Message-ID: <CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org> <CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
 <7vk3lno40x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq3t2-0007dn-4V
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422915Ab3FUQI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:08:28 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48983 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161432Ab3FUQI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:08:28 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so18664366ief.26
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VOBMAVRRTU1YO6+4NK78HQRIOY8PJsC/z+DRnXpkGo4=;
        b=ay1/VbkcnP6q5Lce8EgICGXrJjGKe2CzH03j5/xsxWUSeEtX+tbibAp5WNRuBT77b+
         l1Q/VqqGJ6qBHOViCCj/9JqywecHiVUvz1nRAd6h/onlQllH6hcK2fzaZGafFYY7BDzA
         +baf/nYrQeLT9eLQKA1mGurLUWwUgsT9qTZ7KFwwA18YsbPYb+/xB4iGCkSpXARVtgqX
         clNDyfQqnTnpnOH8VL8f2rYM/r4UucsF8y1Hm7L2Pt5AoRF6tFTKMeDsv0b3JxVmFMBG
         fHVVfKrcqgRr0xCF/bugZI1iFoD5onD3wGF+vi26cZUF5xZtmocd2w5plrUjwaK9s1D0
         gj4g==
X-Received: by 10.50.87.71 with SMTP id v7mr2869033igz.29.1371830907579; Fri,
 21 Jun 2013 09:08:27 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 09:07:47 -0700 (PDT)
In-Reply-To: <7vk3lno40x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228624>

Junio C Hamano wrote:
>> - rr/describe-contains-all at  $gmane/228278.
>
> This may overlap with a topic in flight (but I didn't look at it).

Let me know if I can do anything to make it easier for you.  I'm quite
excited about this one.

>> - rr/mixed-case-aliases at $gmane/227959.
>
> Personally, not just uninterested but moderately against.

Okay, but I'd like an explanation.

> I do not think I am the most qualified reviewer in some of the areas
> they touch, I do not want to be the only one who is reviewing
> patches here, and I am personally not very much interested in seeing
> these topics in Git, so I've been waiting if somebody else shows
> interest and starts reviewing.
>
> Which is not happening, so perhaps nobody is interested in them?

I don't know what happened.  I've noticed a significant decline in
list-reviews in general: a lot of good code on the list hasn't been
reviewed.  Everyone must share the burden of review, and I try to do
my bit.
