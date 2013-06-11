From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 16:40:58 +0200
Message-ID: <51B736FA.5010407@alum.mit.edu>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com> <51B6AA7F.1060505@alum.mit.edu> <CALkWK0nNn8Rcu4JpV4r+0ct+_cuW3aUHXKV4bcB-Hn6Xg8Y+bA@mail.gmail.com> <87li6g969j.fsf@linux-k42r.v.cablecom.net> <CALkWK0kMvac7Sp3QwvEm+J_-Hj7JAn-AY-juDDw1HR3oQ+hamA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 16:41:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPl2-0007yQ-FK
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab3FKOlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:41:07 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50780 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752421Ab3FKOlG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 10:41:06 -0400
X-AuditID: 12074411-b7f296d000001209-f6-51b73700c84e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id AE.F6.04617.00737B15; Tue, 11 Jun 2013 10:41:04 -0400 (EDT)
Received: from [192.168.69.140] (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BEewJv027164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 10:40:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALkWK0kMvac7Sp3QwvEm+J_-Hj7JAn-AY-juDDw1HR3oQ+hamA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsUixO6iqMtgvj3QYMFxY4tVMx+zW3Rd6Way
	aOi9wmwx7ecuVou3N5cwWty9vIrdgc1j56y77B63X89n9rh4Sdnj8ya5AJYobpukxJKy4Mz0
	PH27BO6MGW8iCzZLVPTsvsDWwHhCuIuRk0NCwESip2s1O4QtJnHh3nq2LkYuDiGBy4wS+2/e
	ZYFwzjNJTPu4kxWkildAW2J1wxQwm0VAVWJq/w6wbjYBXYlFPc1MILaoQJjE+2VToeoFJU7O
	fAI0iINDBKjm2SpvkJnMAhcYJU5O2sQIUiMsYCZx7MVMqGVLmSSuH2tgA0lwCgRKtJ+cxQ7S
	zCygLrF+nhBImFlAXmL72znMExgFZiFZMQuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz
	8lKLdE31cjNL9FJTSjcxQgJccAfjjJNyhxgFOBiVeHgTGLcFCrEmlhVX5h5ilORgUhLl1TDe
	HijEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdRDijHm5JYWZValA+TkuZgURLn5Vui7ickkJ5Y
	kpqdmlqQWgSTleHgUJLgdTUDahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWl8
	MTBSQVI8QHttQdp5iwsSc4GiEK2nGI05Np+f/I6RY8YPICnEkpeflyolzqsJUioAUppRmge3
	CJbaXjGKA/0tzOsIUsUDTItw814BrWICWjVFfQvIqpJEhJRUA2NCgY1tO3fWheusP32ZZ3Ad
	YgwN7LqnJrHroUv7hCN6aR5JvZNb+H1b05Kkgh/IrdSX3vn46GxGycPlChLGwQb7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227448>

On 06/11/2013 03:40 PM, Ramkumar Ramachandra wrote:
> Is it because you have realized deep down that you have absolutely no
> rational argument...Why are you incapable of
> using your words to counter my arguments rationally?Are you so blind
> that you cannot see the consequences of acting without reason?

Ram, you are insulting Thomas the human being rather than addressing his
points.  Please stop.

> Tomorrow the majority opinion will dictate that I am a fire hazard and
> must be removed.  Soon, anybody who disagrees with the majority
> opinion will be removed, and the community will be reduced to a
> handful of circlejerking yes-men.  The git project will die a sad
> death.  And the blood will be on your hands.

It is not disagreement that is causing problems; it is the inflammatory
tone of the discussion.  Civil and constructive disagreement is
completely welcome here.  But hurtful and offensive discussion is not,
even if it is in support of the "party line" (haha as if there were such
a thing).

And yes, I know that the word "offensive" is subjective, but for the
sake of this discussion let's take it to mean "offensive to the vast
majority of a community".  Not "controversial", not "contrarian", not
even "stupid"; I don't think anybody is proposing to prohibit dissent or
stupidity.  But there is no reason for discussion that is gratuitously
aggressive, insulting, or derogatory; such discussion is what I mean by
"offensive".

> [...]  I already gave you the
> example of the survivors on the boat with limited food/water on IRC:
> it is you who stupidly refused to throw anyone overboard, killing all
> the survivors; I am the one who said that I would get them to draw
> sticks to "fairly choose" who to throw overboard, maximizing the
> chances of survival of the others.  I am making a pragmatic argument,
> based on what is best for the community; not some stuck-up idealistic
> bullshit.  Further, I tried to help you think through the justice
> problem, by recommending an accessible course.  You have either not
> gone through it, or have gone through it and learnt nothing.

Your idea that you can assign Thomas "homework" in ethics and call him
stupid for coming to a different conclusion than you is presumptuous in
the extreme.

> [...]
> You have embarrassed yourself and the entire git community today.

This is also presumptuous, not to mention extremely ironic.  In my
opinion Thomas's email was calm and reasonable while yours is beyond the
pale.

Ram, don't just take my opinion on this matter.  At the risk of being
presumptuous myself, I suggest that you show a copy of your email to
somebody whom you know and respect in the real world, somebody who is
not immersed in the Git community meltdown.  For example, somebody like
your mother or father, or a teacher whom you respect, or a member of
clergy if you are so inclined.  Ask that person's opinion about your email.

It is so easy to lose perspective in the Internet.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
