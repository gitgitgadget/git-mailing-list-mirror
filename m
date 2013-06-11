From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 00:38:07 -0500
Message-ID: <CAMP44s0Ra1cEjLqX9iwoRWpO5wHjGFygK-MUw7z1q_d-DhcMNQ@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 07:38:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmHHa-0006x1-R6
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 07:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab3FKFiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 01:38:10 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:59856 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3FKFiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 01:38:09 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so6449441lab.29
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 22:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DM57V7zpqvRj9x1Cn1M3cAPSXR8GFxEYc25WFIwm0WQ=;
        b=bRx1msHJY7PCZ7llEZZqgp90oeHk99Uc1KDbe8tpBXWOydzXvz9IHIPYRaLh+WQMVi
         4XK6e5yBW2f11LVVinlFMzdeF3UCDDb0f2TSfHoq8Ph4RQdeUMW8+dOQouKwecKz3W4+
         JEb8qK9Q9BRn02fSe3yTuVc1ha65vYeobSkFBb9SQqis2K+zU1x54i/3j+bLRmh8PB04
         a8imN4eOd9/CnpKJWHJ2+Xf+bGYDXqt5kio9SJmkzRuJI16nQjP8f5UJhRfh180erGp1
         fFwzqdSwfwVQ5ClfJVLYqG/kY0WWjDlKytXjUjRBvj37LpOoVdEE3IMDRk/87cqcIDtX
         R94w==
X-Received: by 10.152.28.162 with SMTP id c2mr2050985lah.45.1370929087505;
 Mon, 10 Jun 2013 22:38:07 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 22:38:07 -0700 (PDT)
In-Reply-To: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227418>

On Mon, Jun 10, 2013 at 8:28 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> I've tried to write down a bare minimum, without restating the obvious.

I think there's an even more important number 0:

Always assume good faith. When discussing through digital mediums,
it's very easy to misconstrue the tone and intentions of other
parties, so it's better to err on the side of caution, and if one is
mistaken, assuming good faith doesn't cause harm, while the contrary
does irreparable damage. This does not mean that one should continue
to assume good faith when there's evidence to the contrary.

> 0. You do not take offense, no matter what.  If someone attacks you
> irrationally, you do not respond.  This is a public mailing list, and
> we are all rational people: the attacker has already humiliated
> herself in public, and everyone can see that.

I don't like the wording of this. "Attacker", "humiliation",
"everyone"; it's very absolutist rhetoric. Yes, you see the other
person as an attacker, and yes you think she is humiliating herself in
front of everyone, but thinking so doesn't make it so.

An even better and less absolutist version would be:

Do not participate in flamewars. It is very tempting to prove somebody
else wrong, but if you think a discussion is turning into a flamewar,
just say so, and avoid it. Do not throw lumber to the flames. You
might feel you should correct the erroneous claims being made in
public, but by replying you are making things worst. Leave the
erroneous (in your opinion) claims alone, the damage has been done,
all that is left is what *you* can do, and the best you can do is
ignore them.

> 3. Thou shalt not commit logical fallacies.  The ones that are most
> common on this list: strawman, ad hominem, burden of proof, false
> cause, the texas sharpshooter, and appeal to authority.

It might be better to turn this negative rule into a positive one:
"Discuss on the basis of logic and evidence". Then you can describe
the common logical fallacies, and I would add "If you make a claim, be
prepared it to defend it with evidence, or add an appropriate
qualifier; probably, most likely, I think, etc."

> If someone breaks one of these rules, there's a very simple way to
> communicate this to them: you don't respond to their email.
> Optionally, respond to their email off-list calmly explaining what
> went wrong.

I think you should reply, but not to her, to the mailing list, asking
for others to don't reply. Then mute the thread. I already explained
that about in the comment about flamewars.

There's a corollary to that that works rather well in the LKML; you
are permitted one flamewar per year. I'm not going to explain why this
is a good thing, because unfortunately there's an irrational negative
bias against me already, but there's a reason why this is a good rule.
Even if you don't agree it's only one flamewar per year per person,
it's not that much.

-- 
Felipe Contreras
