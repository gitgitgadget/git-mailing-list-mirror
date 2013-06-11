From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 20:24:15 +0200
Message-ID: <51B76B4F.4030504@alum.mit.edu>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com> <51B6AA7F.1060505@alum.mit.edu> <7v38sod1kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:24:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTF1-0002fC-FN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab3FKSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:24:19 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49568 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755957Ab3FKSYS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 14:24:18 -0400
X-AuditID: 12074414-b7f626d0000001f1-7c-51b76b51fed7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 27.40.00497.15B67B15; Tue, 11 Jun 2013 14:24:17 -0400 (EDT)
Received: from [192.168.69.140] (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BIOFed006275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 14:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7v38sod1kn.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqBuYvT3QYOsVG4tVMx+zW3Rd6Way
	aOi9wmwx7ecuVou3N5cwOrB67Jx1l93j4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M7o+7GYt
	mKlYcfU3TwPjFakuRk4OCQETiYY181khbDGJC/fWs3UxcnEICVxmlGj+MpcZJCEkcJ5J4vh6
	fxCbV0BbYsPXD+wgNouAqsTHvn4mEJtNQFdiUU8zmC0qECbxftlUVoh6QYmTM5+wgNgiAmoS
	E9sOsYAsYBZYyyhxtv8HI0hCWMBM4tiLmSwQm2cxSuzduhgswQmUuL1pB1g3s4COxLu+B8wQ
	trzE9rdzmCcwAlUjLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RS
	U0o3MUICWmQH45GTcocYBTgYlXh4D5ptDxRiTSwrrsw9xCjJwaQkyrsoEyjEl5SfUpmRWJwR
	X1Sak1p8iFGCg1lJhFcvESjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PB
	oSTBm5UF1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitX4YmC0gqR4QPaCtPMW
	FyTmAkUhWk8xWnJsPj/5HSPHjB8g8tfDKe8YhVjy8vNSpcR5o0AaBEAaMkrz4NbB0torRnGg
	74UhruIBpkS4qa+AFjIBLSzKAFtYkoiQkmpgrA+3D1/+o4HfQHum2bJa6S8Hm/YwMuzMT7F2
	d27hecR6UbrhUx7nuupEjlPPVgS8evlNqF/VZ57PhqZrfxY/PVTs/FnHkkXjXf2y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227485>

On 06/11/2013 07:00 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> [...]
>> * When reviewing other peoples' code, be tactful and constructive.  Set
>> high expectations, but do what you can to help the submitter achieve
>> them.  Don't demand changes based only on your personal preferences.
>> Don't let the perfect be the enemy of the good.
> 
> I think this is 30% aimed at me (as I think I do about that much of
> the reviews around here).  I fully agree with most of them, but the
> last sentence is a bit too fuzzy to be a practically useful
> guideline.  Somebody's bare minimum is somebody else's perfection.
> An unqualified "perfect is the enemy of good" is often incorrectly
> used to justify "It works for me." and "There already are other
> codepaths that do it in the same wrong way.", both of which make
> things _worse_ for the long term project health.

I agree that the last line is fuzzy.  And I don't think that I've
observed any cases where I thought that reviewers were being too strict,
so in a way it's just trying to head off hypothetical future problems
and to make sure that the balance between submitter and reviewer is not
*entirely* one-sided.  Given our (proper, I think) strong deference to
reviewers, one could imagine a reviewer abusing his/her authority to
obstruct reasonable changes by (for example) making demands that the
submitter also fix tangentially-related things that are beyond the scope
of the patch.

In my own projects I have a rough policy of "not worse than before",
meaning that as long as a patch makes progress in at least one
dimension, and doesn't make things worse in any other dimension, then it
is acceptable.  (Of course "worse" can include internal quality issues
like copy-pasting code or even an increase in the amount of code
disproportionate to its benefit.)  A failure to make improvements in one
area should not be a reason to block an improvement in another area, as
long as nothing is made worse.

But I can't right now think of a succinct way to express what I have in
mind.

>> * It is not OK to use these guidelines as a stick with which to beat
>> supposed violators.  However, if you genuinely feel that another
>> community member is routinely behaving in ways that are detrimental to
>> the community, it might help to calmly express your concerns to that
>> person, preferably in a private email, and naming concrete and specific
>> incidents rather than broad generalizations.
> 
> I would think it is perfectly OK to say "The way you are refusing to
> listen to constructive comments is not how things work around here"
> by pointing at a set of guidelines.

I agree.

> Why do you think is it not OK?  The "beating" part?

I think it would be counterproductive for people to start saying things
like "that is a violation of rule 3, section 2" *in everyday
discussions*.  This shouldn't be taken as a list of black-and-white
laws, with allegations of small "infractions" used to shut down
discussions.  And on the other hand, if somebody shows a long history of
acting contrary to the guidelines, and persists despite repeated
requests to stop, I don't want the discussion to turn into a lawyerly
analysis of the guidelines with point-by-point rebuttals and
counter-rebuttals of whether this or that guideline was violated.

The guidelines should just describe the expected tone of the community
in a way that the vast majority of participants can agree on, and any
kind of actions to enforce the guidelines should only be taken when an
overwhelming majority of the community

I think the CommunityGuidelines should have three main uses:

1. An artifact documenting the community consensus about what kinds of
behaviors are encouraged and what kinds are considered unacceptable.  It
should only be accepted, and it only has value, if there is a strong
consensus in favor of it.

2. A resource to help new community members get up to speed on our
practices and expectations.

3. As a point of reference in the direst meltdowns, such as IMO we are
having right now.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
