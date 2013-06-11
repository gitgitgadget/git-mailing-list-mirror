From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 18:19:23 -0500
Message-ID: <CAMP44s10TVF9-uT5OtCLXBKrrXAspYnHM+go1zvu6ocMZwN14A@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<7v38sod1kn.fsf@alter.siamese.dyndns.org>
	<20130611203303.GA14907@sigill.intra.peff.net>
	<7va9mw9xkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 01:19:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmXqc-0004TL-9a
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 01:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab3FKXT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 19:19:26 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:36281 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3FKXTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 19:19:25 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so7358029lab.29
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6nQjOGaLukCeGjLJ4GmaVxWKd/iBZWDQIMET2Rmg+94=;
        b=J92dgHaPJv93qo5rPL8IuVDDDZfSjQlorK4hcv/0i3+C0R5FioS/rzA2V6YSsRL5s1
         DD6IIKeI22NCCfWldiStEaxBd6Ns+bHvaOgbzK835BCXq9tLSWU/j0tEA16esv8B6vMI
         4IchErWV2giU3vCqBwo0GeOlx84/T+E3kApJ7QbVdidxoBYDMtKnA77MLs+B+Dgp+O1/
         ZAinI7Tg4b9OiDKZHE1EcvbMbFgAjX4ErbjrYEtkCsH8NXMfn60RaKXMVCvj0+43KUub
         kxWW8Nn+nPGbSjHNx+4gW1ead59MNPYIOABLINqb8uVK9aWgZyJEgLNaPQWATgAX9m3w
         2VOA==
X-Received: by 10.152.7.74 with SMTP id h10mr8405381laa.83.1370992763627; Tue,
 11 Jun 2013 16:19:23 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 16:19:23 -0700 (PDT)
In-Reply-To: <7va9mw9xkb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227575>

On Tue, Jun 11, 2013 at 3:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> So there are no hard rules, and this is not a democracy[1]. For the most
>> part the community runs itself in an open and collective fashion, and
>> the dictator's job is easy; but ultimately, he or she is in charge of
>> what gets applied and what doesn't. Rules like "break ties in favor of
>> reviewers" are just a guideline for the dictator to use in making
>> decisions.
>>
>> I do not think any of that is news to you, but I think the point needs
>> to be made, as it applies to any concrete rules.
>
> My original draft had "I am hoping we do not have to come to that"
> after "(I heard some communities break ties this way)", but I
> removed it by mistake.
>
> And I think you are right. I also am hoping that I am being fair to
> dictate ;-)

Fair? Fairness requires to judge each action without biases, nor
double standards. In the case of an open source community it requires
you to listen to the arguments before dismissing them, and consider
the patches before dropping them on the floor. Fairness requires no
favoritism.

You think you are being fair? You have acted the equivalent of a judge
that says "oh, you again? I don't need to look at the case, you are a
drunk and you go to jail". I'm not saying that's wrong, I'm saying you
can't call that fair.

-- 
Felipe Contreras
