From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 13:52:17 +0530
Message-ID: <CALkWK0=zpZ25X_jVBoF77E75kmV38VC+nwtQ6MYA9=UO99HqyQ@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <7vip5p9rtm.fsf@alter.siamese.dyndns.org> <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
 <7v7gm492ty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 09:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7iTf-0001cp-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 09:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362Ab3BSIWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 03:22:38 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:49358 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab3BSIWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 03:22:37 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so5888471iak.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=e6uYii/EHxUnortQWJqWXZfccRH+z1WBucr8rfG4U8Y=;
        b=PxfNI6adII/sWzhl8tFnsGejY2PGj7Wvy+yqnxtfzBoK0UCJcOE7pjuedU5i7UVABB
         zKRgiBLMUCTxB6KK+xk4UVFjJ9RnwAaZVLA14asK1IQnLNCxd00uYcMHlNvnZD0Nvtt+
         3afJd0CckmTVdKUoEXuf9mNs133j3l28KGs3pKyKsK8wXqgeGd7eH2utgHxGlH/Gy/jA
         NVOK9Zsj6k+FfA46nRolRepDn1o27yKin25g4kI4/AYH3/nxtIjkyHz8+Q8/QlpgmENf
         puWaKCS6PezMUcvTgsKzB9bU5jAxbBqAPSCR2Byhihe7/UnSVGRn4YXw41Qt7EjX+Ipy
         NVmg==
X-Received: by 10.50.108.235 with SMTP id hn11mr7700265igb.107.1361262157071;
 Tue, 19 Feb 2013 00:22:37 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 00:22:17 -0800 (PST)
In-Reply-To: <7v7gm492ty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216575>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>> ...
>>> I think the real issue is everybody in the GSoC mentor candidate
>>> pool grossly underestimates the scope of suggested projects, does
>>> not encourage students to send early drafts to the public from the
>>> beginning, and perhaps overestimates the ability of total beginners.
>>> After seeing my "index-thing is too big in scope" warning repeatedly
>>> ignored for the last year's GSoC, I am not very hopeful unless the
>>> attitude towards GSoC and its students drastically changes on our
>>> mentors' end.
>>
>> The short undiplomatic version of that is that our mentors suck (I'm
>> not pointing fingers, but that's what I infer from failing projects).
>
> I was conflating between people who add "suggested project" and who
> act as mentors.  I do not think mentors are primarily responsible
> for bad suggested projects.

Why do mentors pick badly sketched-out projects to mentor?  They're
free to pick anything they want/ propose what they want.

> Our mentors may be wonderful but I do not have enough evidence to
> judge either way.  They are mostly student-facing and I as a
> bystander to GSoC process didn't see much of their involvement in
> their students' work---maybe that is how it is supposed to work,
> maybe not.  The only failing of them observable from my point of
> view was that we repeatedly saw the initial round of patches come
> very late.

Ideally, the initial round of patches should come in well before the
GSoC even starts, I think (the initial round might just be doing some
minor surrounding work though).

>> I propose that we have one thread for every proposal where we can all
>> discuss the implementation outline- this will serve as authoritative
>> source of information for students, and for picking mentors (the
>> people who contribute most to the discussion).  Students should be
>> matched with mentors on an individual basis.
>
> You are being unreasonable and/or unrealistic. A topic that needs a
> large discussion thread to pre-discuss design and outline by many
> existing members of community and mentor candidates is a sure sign
> that the topic is too big for a beginner. A topic that needs only a
> small enough discussion thread on the other hand will come to a
> polished conclusion before even the student shows up.

I that case, projects like inotify support that Duy suggested in a
nearby thread are not realistic candidates.  No, I wouldn't like huge
discussion threads on each proposal either: but a ~10 email thread
with everyone's thoughts on it would be useful, I think.  If the size
of the thread exceeds a certain threshold, the project is deemed
un-doable automatically.

> This is exactly why I suggested "doable as a private, at most
> two-weekend hack by an experienced" as a quick and dirty way to
> measure the size of a project.

Yes, that's a good measure.
