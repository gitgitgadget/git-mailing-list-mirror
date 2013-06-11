From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 16:41:43 +0530
Message-ID: <CALkWK0kzrQpCKc0tCOV-6Tkag4Zmckpt1zqFPR0nvcxQXPKcxA@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <CAMP44s0Ra1cEjLqX9iwoRWpO5wHjGFygK-MUw7z1q_d-DhcMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 13:12:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmMV6-0005kw-39
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 13:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab3FKLMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 07:12:25 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42051 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab3FKLMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 07:12:23 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so5747360ied.28
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w85p5dwj2bZZzlAXTJMHHgRBhAtsmhEm4qsEG8/bomc=;
        b=ycsSO9ldSc/QSDeMD+1Wau9VTrAipAQc3ErA8B6PB/bIC7+v0y3jofDoQ/xiKXNKXC
         JEqxZpD7y+W4OiwO5yLpZcDaSFHzePwyvO55PbGvR5gejWWnfihsxqiK1xSrCHTH0cID
         5gByIsPPKi+pIINnHY2HqftIx1aVSVt1nx/cxD5hHvaDBd/8snc5rqor1qjxbAn0UX9q
         If1oSicIF9oMmKCibqdPP88fGcYZioX4o12Qvw1TU1uGP0eef4EFew2rvrTFSFLiIqfn
         wG1dnUjpon5W5RzJRv34smQqgBJe/vPTPh2YX9ypGduvq/+l2Lg8IrhzoKCNg8JDS7Y9
         dMsw==
X-Received: by 10.42.135.5 with SMTP id n5mr5413805ict.14.1370949143459; Tue,
 11 Jun 2013 04:12:23 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 11 Jun 2013 04:11:43 -0700 (PDT)
In-Reply-To: <CAMP44s0Ra1cEjLqX9iwoRWpO5wHjGFygK-MUw7z1q_d-DhcMNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227428>

Felipe Contreras wrote:
> I think there's an even more important number 0:
>
> Always assume good faith. When discussing through digital mediums,
> it's very easy to misconstrue the tone and intentions of other
> parties, so it's better to err on the side of caution, and if one is
> mistaken, assuming good faith doesn't cause harm, while the contrary
> does irreparable damage. This does not mean that one should continue
> to assume good faith when there's evidence to the contrary.

Agreed.  "Always assume good faith" is a good rule of thumb.

>> 0. You do not take offense, no matter what.  If someone attacks you
>> irrationally, you do not respond.  This is a public mailing list, and
>> we are all rational people: the attacker has already humiliated
>> herself in public, and everyone can see that.
>
> An even better and less absolutist version would be:

I went for the absolutist version because I felt that this point needs
to be driven in harder.  This is the biggest problem, in my opinion.

But yeah, your version is more technically correct.

>> 3. Thou shalt not commit logical fallacies.  The ones that are most
>> common on this list: strawman, ad hominem, burden of proof, false
>> cause, the texas sharpshooter, and appeal to authority.
>
> It might be better to turn this negative rule into a positive one:
> "Discuss on the basis of logic and evidence". Then you can describe
> the common logical fallacies, and I would add "If you make a claim, be
> prepared it to defend it with evidence, or add an appropriate
> qualifier; probably, most likely, I think, etc."

Good addition.

>> If someone breaks one of these rules, there's a very simple way to
>> communicate this to them: you don't respond to their email.
>> Optionally, respond to their email off-list calmly explaining what
>> went wrong.
>
> I think you should reply, but not to her, to the mailing list, asking
> for others to don't reply. Then mute the thread. I already explained
> that about in the comment about flamewars.

I don't think "neglect" is the solution to anything.  We don't want
contributors to feel neglected; we want to make them understand that
their behavior was undesirable because of reasons X, Y, and Z.  In a
raging fire, they might not be able to see these reasons clearly.

> There's a corollary to that that works rather well in the LKML; you
> are permitted one flamewar per year. I'm not going to explain why this
> is a good thing, because unfortunately there's an irrational negative
> bias against me already, but there's a reason why this is a good rule.
> Even if you don't agree it's only one flamewar per year per person,
> it's not that much.

I suppose it's a way for people to vent built-up emotion.  Flamewars
will happen, no matter what we do; we cannot control the actions of
others.  If too many people want to start a fire, we can do nothing: I
don't propose an iron hand of suffocation.  My objective is more
realistic: it is to make people realize the undesirable effects and
"minimize" fires.
