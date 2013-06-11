From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 11:17:46 -0500
Message-ID: <CAMP44s2r5DcG3KVfM79c-ZZZS0t_8pBp2TEtp2958JuB=Ne3Xw@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<87ppvszl0i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 11 18:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmRGb-0003zA-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 18:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab3FKQRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 12:17:50 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:60262 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab3FKQRs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 12:17:48 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so6825838lab.38
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ojeDV8gqJG+EdCEpm6MeOml2TLAf+9GLHnNtMdefnJo=;
        b=zgrGwb5jGfqptyzBzwukpskXpcbCcXsbp4Oc6CKQ0pKKX7wuRMMC8Tpq9n8avvuvZQ
         /GE0J2aNcaObbbLWpmszyIH5eZwmJqhIzvt75YlrkukCP0kh2+iboHuI9vX26HnRblor
         pi8+tCQV38tjGzLy/yFqvkKggEQFH0R3/lBkhz+iBpmgIlPm7T+pUXpWFWYyy2bKQvIX
         5xmVB9v8LbnnRvwrWTNWHhvlCm32Y3rW4dzWPSc9HpsnSu6DNDEOU8wvhSzYexOCkcdL
         DVbRCBhCj/wfjYekApKtLliwoopexahWqIT/7KYyrVjRJRBMEb9PwXKXaEY3tKnXJymJ
         RWCw==
X-Received: by 10.112.16.163 with SMTP id h3mr9095239lbd.85.1370967466500;
 Tue, 11 Jun 2013 09:17:46 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 09:17:46 -0700 (PDT)
In-Reply-To: <87ppvszl0i.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227459>

On Tue, Jun 11, 2013 at 11:10 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> * Accept reviewers' comments gratefully and take them very seriously.
>> Show that you appreciate the help by giving the reviewer the benefit of
>> the doubt.  If, after careful consideration, you find that you cannot
>> agree with a reviewer's suggestion, explain your reasoning carefully
>> without taking or giving offense, and seek compromise.
>
> I'm not sure yet how to phrase it, but I have come to the conclusion
> that the dual nature of reviews is part of the problem.
>
> On the one hand, reviews are code criticism: they are extra work spent
> by the reviewer to try and help you improve your work.
>
> On the other hand, they are also quality checks.  Reviews serve to spot
> bugs, misdesigns, noncompliance with project standards, etc. before they
> ever go into the code base.
>
> The problems start when these start having a contradictory impact on the
> correct course of action in a discussion, or in the longer term in
> dealing with a person.  For example, I have attempted to deal with
> Felipe at one point by refusing to review, i.e., ignore the email.
>
> However, this must be weighed against the requirements of the second
> kind of review.  So while it is exceedingly easy for everyone to say
> "just ignore the flamebait", the flamewars keep recurring because this
> "gatekeeper" type of review continues to be necessary, and continues to
> elicit nonconstructive responses.

Why do you assume the review is for the patch submitter? You can reply
so your review is stored on the record, and the maintainer, Junio, can
see it. Then you can ignore the fallout.

I think this type of review is hurtful, because the fact that you said
some words doesn't mean you are right, and you might be blocking a
perfectly good patch by not following up the counter arguments.

Presumably you are not worried about that, and you would be content
with simply blocking all my patches. Whatever floats your boat.

-- 
Felipe Contreras
