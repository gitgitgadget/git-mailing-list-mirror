From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Wed, 12 Jun 2013 09:06:31 -0500
Message-ID: <CAMP44s1CnNQH+rvammgXyiSux5Gzn6Jhm8D0H4brFDez52nLwg@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<7v38sod1kn.fsf@alter.siamese.dyndns.org>
	<20130611203303.GA14907@sigill.intra.peff.net>
	<7va9mw9xkb.fsf@alter.siamese.dyndns.org>
	<CAMP44s10TVF9-uT5OtCLXBKrrXAspYnHM+go1zvu6ocMZwN14A@mail.gmail.com>
	<20130612122723.GA26281@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 16:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umlh7-0007Oa-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 16:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab3FLOGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 10:06:34 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36523 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3FLOGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 10:06:33 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so4198916lbc.17
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lDcu4gIripW/H3UkgE8sBIBop9XqsDQ7MKfhZdM+lnE=;
        b=knATyRfjnGqS7JgQ4hg78b+cdR5G3K4M5+Iy2FDXJ6TWXoa3kD0IxRVqllcAFm4+pS
         LQlX7dNcHI9kqCiTQyDbOjRCW+Z9JQHSjCIOzP0BZT/D8p1AECGUYwQ3k8G1bDCGrLtz
         xYz57shJiUPk4bglOrkPj2y2nwvqplRBI60T0tL6vyVw2ZfA8+9ReSByui4oRP00KZIk
         LCimOD64S0ITFYgwI/T8jYmkaBJv1K1VzfzelrzVoVO+4AoG4N/Z9+ZJKuAXXGA4wuqa
         HwWtwP4j10LAXunqG6ToSjktq/bP1OAcFLYLpWI2bMzNL40zvcM96CsSHU8i96VPwIIX
         MHJQ==
X-Received: by 10.112.140.231 with SMTP id rj7mr11239745lbb.16.1371045991624;
 Wed, 12 Jun 2013 07:06:31 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 12 Jun 2013 07:06:31 -0700 (PDT)
In-Reply-To: <20130612122723.GA26281@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227618>

On Wed, Jun 12, 2013 at 7:27 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Jun 11, 2013 at 06:19:23PM -0500, Felipe Contreras wrote:
>> Fair? Fairness requires to judge each action without biases, nor
>> double standards. In the case of an open source community it requires
>> you to listen to the arguments before dismissing them, and consider
>> the patches before dropping them on the floor. Fairness requires no
>> favoritism.
>
> At least in development communities that *I* run, if someone were as
> rude to me as you have been in some previous exchanges to Junio, I
> would have set the bozo bit a long time ago and reviewed your
> submissions with a very jaudiced eye, and treated your non-technical
> arguments with same amount of attention as I give madmen and drunkards
> in the street.  Junio has given you *far* more latitude than I would
> have.

Yeah, you certainly can do that, but a judge cannot do that, can he?

> Keep in mind, the demands for respect go in both directions, and in
> non-technical matters about style and "good taste", at the end of the
> day the maintainer does get to have the final say, because he or she
> is the one who applies the patches or accepts the pull request.  So if
> the maintainer says something like, "maintaining ABI backwards
> compatibility for libext2fs (or for kernel syscalls) is critically
> important", that's not up to you.  Sending me abusive e-mails about
> how I'm not listening to your arguments isn't going to help.

I'm not abusing anyone. Junio is making the mistake of thinking he is
being fair, I made the judge analogy so that he can see that he is not
acting like a judge. A judge has an obligation of being fair, so he
acts fairly, Junio don't have that obligation, yet he thinks he is
being fair when he is not.

That is not abuse, that is pointing the truth.

> You can
> try to change my mind with reasoned arguments, but for questions like
> that, or what functions do or don't belong in a library, the
> maintainer is the benevolent dictator.

Yes, he makes the decision, that doesn't mean the rationale for the
decision is correct.

He is making the decision based on the idea that
init_copy_notes_for_rewrite() (and similar) will be used by binaries
other than 'git'. He is wrong.

> For things like that it *IS* his (or her) opinion,

The problem is he doesn't accept it's his opinion. He thinks it's a fact.

-- 
Felipe Contreras
