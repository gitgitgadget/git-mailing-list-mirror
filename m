From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My patches
Date: Fri, 18 Oct 2013 06:41:41 -0500
Message-ID: <52611e75bdc8d_2b6dcb7e7459@nysa.notmuch>
References: <20131012072450.GA21165@nysa>
 <xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
 <525c64ebe2390_197a905e84c@nysa.notmuch>
 <xmqq8uxrzn9h.fsf@gitster.dls.corp.google.com>
 <52605a36eef0f_448145fe7466@nysa.notmuch>
 <9A62D872-0FCF-41B9-B185-7061B25F1CBC@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 14:10:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX8sq-0000kL-NG
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 14:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab3JRMKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 08:10:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:55359 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab3JRMKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 08:10:00 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3048043obc.37
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=AiR+4LvQtZIAZpZ29DbvGBLNwEnRT8lGyhxNRo6w6Jo=;
        b=uIWY63F11CQeJabcs+v9Br4hD4TnofZwxdVrMBveqjQABClXXd512THIHnIphiKNgU
         kAqPn3BkMmZEmrWnqx3ZxfQSVnA+jJT3OTsQIf5kl9nEnazeiGpQ47M2xC0xs6C43igk
         F5lU9uPRmeS3jqn9cbWgOElhzljsDYe4/OVNOAwOY1jUo1q9bwd+tKVb8GlxOqIRxFps
         Lqe1fpCnqCfvfwuqiLw01QwT/um+jiTj18fNEL6dDb7H3OvzA/w8R48GgxKAnwRps/9O
         1alVsRewj6GC+4AIm6fiRqnrslPBD4/HHgcr7qI8vjbcIDS1ft+f4crJSjrsp1h/M+Pk
         jydg==
X-Received: by 10.182.96.100 with SMTP id dr4mr4234427obb.22.1382098199694;
        Fri, 18 Oct 2013 05:09:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm2563965obi.14.2013.10.18.05.09.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2013 05:09:58 -0700 (PDT)
In-Reply-To: <9A62D872-0FCF-41B9-B185-7061B25F1CBC@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236346>

Max Horn wrote:
> I guess most other people keep out of this because they are sensible enough
> to not feed the troll, and instead focus on useful things. But I can't help
> it, I have to say this.

You should probably read the definition of troll:

https://en.wikipedia.org/wiki/Troll_(Internet)

Unless you think that contributing useful patches to Git is off-topic, a person
that does that by definition cannot be a troll.

> On 17.10.2013, at 23:44, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>> Junio C Hamano wrote:
> >>>> Such a review comment and the discussion that follows it after a
> >>>> patch is posted is an essential part of the collaborative
> >>>> development process in this community and it has helped the quality
> >>>> of our end product. We unfortunately saw time and again that the
> >>>> process rarely works when the discussion involves your patches.
> >>> 
> >>> No, you did not. What you saw was a person that unlike a trained dog, argued
> >>> against you. And apparently your definition of a good discussion is one in
> >>> which the other person just does what you say, and doesn't argue back.
> >> 
> >> That is so untrue that it is not even funny.
> > 
> > It is true, and there's penty of evidence that proves it.
> 
> No, it is not true, and there is plenty of evidence that proves it.
> 
> But I don't think it's helpful for either of us drag up such "evidence", as
> it'll convince nobody -- indeed, I am sure almost everybody here has already
> formed a clear opinion on this matter.

That's why I didn't bring it up.

> And I hazard to guess that the vast majority agree with Junio on this (based,
> again, on email evidence). Not with you.

That is irrelevant, and a fallacy. The vast majority of people thought the
Earth was the center of the universe, and they were all wrong.

It's called ad populum fallacy, look it up. Wether the majority of Git
developers agree that there's something more than a disagreement is irrelevant,
their opinion doesn't change the truth.

And by the way, a disregard for evidence is a clear sign of a person that is
not interested in the truth.

> Of course one can't prove mathematical theorems by a majority vote, but as we
> are not talking about theorems, but rather about judging whether Junion's
> behavior is considered fair or not, I think it is appropriate to.

No, that's not what we are talking about.

My claim is that all I did was disagree with Junio. You can invalidate that
claim easily by providing *a single* example where I did more than disagree.

> Moreover, if I look at e.g. the "staging area" discussion, you also bring up
> the "everybody but Junio and one other guy" argument (incorrectly
> generalizing from "those people on this mailing list who chose to reply" to
> "everybody"), so I think I am entitled to do the same ;-).

I've stated multiple times that by "everybody" I mean "virtually everybody".
Since Junio has accepted that "the index" is not the best term, "virtually
everybody" is actually everybody that has voiced an opinion, except one single
person.

> > Every single time that you get mad at me, it's because I disagree with you.
> 
> I have not yet seen Junio get "mad" here, even in discussions with you were I
> think most other people would indeed have gotten "mad" at you.

I can provide the evidence when Junio has become clearly "mad"... If you are
interested in the truth that is.

> He stays remarkably polite, despite the insults and dirt you keep flinging at
> him...  If at all, it would seem that you are getting mad at Junio.

That is pure libel. Show me *one* example where I threw an insult, or "dirt".

> >> Contributors often make sensible counter-arguments and/or explain
> >> the rationale better than they did in their original messages, and
> >> then receive a "Thanks for a dose of sanity" (or an equivalent
> >> phrased in different ways).
> > 
> > Yes, when there's an agreement, so you are basically proving what I said. I
> > disagree with you, you disagree with me, and that means I'm the problem.
> 
> Actually, it is more like this: "Felipe disagrees with Junio, Junio disagrees
> with Felipe, Felipe insults Junio and in passing half a dozen other people."

Lies. When did I insult anybody?

> > In any healthy collaborative project that simply means there was a
> > disagreement, and that's that.
> 
> If your premise was correct (that there is simply a disagreement), then this
> conclusion might be correct. As it is, though, your premise is false.

Evidence, or that claim is dismissed.

That which can be asserted without evidence can be dismissed without evidence.

> The problem is rather a disruptive person: you.

Nelson Mandela was considered a "disruptive person" (a terrorist[1]), yet
virtually everyone agrees that the problem was not him, but the system that
labeled him as such.

[1] http://en.wikinews.org/wiki/Nelson_Mandela_taken_off_US_terrorist_list

-- 
Felipe Contreras
