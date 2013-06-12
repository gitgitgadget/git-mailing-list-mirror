From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Wed, 12 Jun 2013 17:33:51 +0530
Message-ID: <CALkWK0=SjNE+_8EGhOsSZAMBPrHAj7-16rZFf2By6NttoQOa5w@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B6AA7F.1060505@alum.mit.edu> <7v38sod1kn.fsf@alter.siamese.dyndns.org> <20130611203303.GA14907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umjn2-0006jZ-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab3FLMEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 08:04:32 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48885 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab3FLMEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:04:32 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so8223238iec.13
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uqiuT2HJGTenbp+FtGJrqs3DiBLWXuMZEi+3M20gD3o=;
        b=a8IFB/6DjjIPYx5YxQ2sUXM9trzAfoRn9+gtYIdv1YCy+Nq5lLRf7D5r+kFyPYSXXr
         y9eOKZKZ8cWRxkNMKcGSr4KxRri5MIx8yZofthd7xVaba+rSzdnBYeZxqDmZIJm+UpAF
         k+T/dw9FpEzVrDFOuWbcQeMqoc6dEkYYBbVreea6EWri13LCuENlOVkLFMC/mrPk4RiI
         K7qLao74lLhQR6EBfZbdnrRctpsbjp44+sp8W8QgqvVaUNO1jKWns7gZvEZXqJulrfN9
         3zeOg3FLqpL439qthPIWpO3UQmIjsyMzM2o+U5cSylBN7n4/GNjTuLSGgbZnVfWMoUOe
         TfJQ==
X-Received: by 10.50.154.106 with SMTP id vn10mr3118102igb.0.1371038671635;
 Wed, 12 Jun 2013 05:04:31 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Wed, 12 Jun 2013 05:03:51 -0700 (PDT)
In-Reply-To: <20130611203303.GA14907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227604>

Jeff King wrote:
> And I think that is where the benevolent dictator role comes in. They
> weigh not just the points made in the discussion (or a summary of it),
> but also use their judgement on who is making comments (how many people,
> the utility of their past comments) and other factors (other things
> happening in the project, being conservative because of recent mistakes
> made, etc). They may break such a tie by applying or rejecting, even by
> putting off a decision to revisit later (which is a de facto reject, of
> course).

Junio has one of the hardest jobs of all: his sense of fairness plays
a major role in determining the health of the project.

That said, I'm quite happy with Junio's sensibilities.  He's not
devoid of shortcomings, but that is an unrealistic expectation.

> So there are no hard rules, and this is not a democracy[1]. For the most
> part the community runs itself in an open and collective fashion, and
> the dictator's job is easy; but ultimately, he or she is in charge of
> what gets applied and what doesn't. Rules like "break ties in favor of
> reviewers" are just a guideline for the dictator to use in making
> decisions.

Do not confuse "democracy" with "rule of the majority" (not implying
that you are; just saying).  Governments have been voted out of power
because they failed to protect minority interests.  When it comes to a
decision like "whether or not to execute this rapist", the government
does not make a decision based on the votes of the common public.  It
has a constitution, and courts where it is interpreted and decisions
are made.  Cases are often not won or lost on the basis of "hard
rules", but on the force of the arguments that the two lawyers
present.  There are societies that use the jury system to lessen the
burden on the judge; but again, a decision cannot be made on the basis
of majority: the jury panel must reach a consensus.

It's not all that different from what happens in this community, I think.
