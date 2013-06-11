From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 06:41:35 +0200
Message-ID: <51B6AA7F.1060505@alum.mit.edu>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 06:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmGOv-0004nr-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 06:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab3FKEll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 00:41:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57137 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751158Ab3FKElk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 00:41:40 -0400
X-AuditID: 12074413-b7f136d000006de1-03-51b6aa8374ba
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.4A.28129.38AA6B15; Tue, 11 Jun 2013 00:41:39 -0400 (EDT)
Received: from [192.168.69.140] (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5B4faUc003320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 00:41:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SXUhTURzn7O7q9ePa8arttMzo6hKyrYS0FRURPghKOIKiXubV3dxou8ru
	Jq7PlYIwLSNn5RAr0YkrtExMzXoYJaiIlkIYFJq2zFIJFSwf7B7Fj5fDn98n5/wPRTDNpJIy
	CTbeKnBmNihUzgSn7VEX+9p1B183qLS+6olgrWukTKZ13h4htPf/dpHamdF6cJJM7/R8CU7/
	8DE+fb41Lou4EHYsh7MVnjHlCQdOZIcZx+74yYKApujJ20bCCZZULkBRCB5CvxplLhAijdvR
	0NeWIBcIpRg4DND8m3E5Jhg4KENzNXo80zAJDZRVkHiWQxVa6n4G8BwE1aiuvHg1KAaeRXPe
	KnJNH4l6qyfluCta0gR8GTifgF6AJko+r2qiYCrqmape1TAwC90svYrhEKhDL8Z7VmECJqKW
	WgbDBNyNXs3UEHcB9Gwp8GyqPFtUjwHhA3Gc2W5RWziTWeRz1WIuJwi8VX1YYzHZNLzB3grW
	3jiqA3T1xvkBpAAbTmeDdh1DcoWiw+IHOygZG0O7myQoIiff4DByolFvtZt50Q8QRbDRdHWK
	xNEGznGZt+avUzspOaug99YnnmZgHmfjL/F8AW9dZ2MpikV0PQ6NtPJ5fNFFk9m2ScuoEBwe
	qowWecHAWzm7zajHC9WL0kYxFS713sB2WizgLBK6Zu0DR6iXg5WzgHq4hM9/4+5ZwMiFfIFX
	KuhWbIDYYLQLG3Xr32waKKTbR9HFWBUufcKN1GmpUCYVuhPbcKGN26SUTqBPWazdVhnwXBnS
	kt6OhIYfauhP9XRpH3VeWzAkjB6PzTwazyYty69n/nmXP/pe+SCw63vTt5X+n4rz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227415>

On 06/10/2013 03:28 PM, Ramkumar Ramachandra wrote:
> I've tried to write down a bare minimum, without restating the obvious.

Thank you for drafting a proposed CommunityGuidelines document; I think
such a document would be helpful.  But I don't like the overall flavor
of your proposal; frankly, it sounds to me more like

Documentation/GuidelinesForCommunityToBendOverBackwardsToLiveWithFCsProvocations

and I don't think that is healthy.

> 0. You do not take offense, no matter what.  If someone attacks you
> irrationally, you do not respond.  This is a public mailing list, and
> we are all rational people: the attacker has already humiliated
> herself in public, and everyone can see that.

This is secondary to the more important rule, "do not attack other
people on the mailing list".  Not taking offense is at best a(n
important) fallback position for those regrettable occasions when
somebody else has already violated the primary guideline.

> 1. You do not take sides or vote.  Do not post emails under the
> pretext of agreement: repeating what has already been said does not
> strengthen the argument.  Post only if you have something unique to
> add to the discussion.
> 
> 2. You stop pointing fingers.  Every heated discussion requires more
> than one participant, and a flamewar requires many participants.  If
> you participate, you have implicitly agreed to share the blame for
> whatever happens on the thread.  People can judge for themselves who
> is to blame.

Here your wording "every heated discussion requires more than one
participant" seems to put more of the blame for heated discussions on
participants 2..N and give a pass to participant number one.

> 3. Thou shalt not commit logical fallacies.  The ones that are most
> common on this list: strawman, ad hominem, burden of proof, false
> cause, the texas sharpshooter, and appeal to authority.

I think putting a rule like this in CommunityGuidelines puts too much
weight on it.  In my recollection, pointing out other people's supposed
logical fallacies is far more often used on this list as a nitpicking
diversionary tactic that usually leads a conversation *further* away
from the real issues.  I think it would be a mistake to encourage such
formal and stylized argument on the ML.

> 4. Lead by example.  If you do not like how someone presents
> themselves on the list, you counter it by presenting yourself nicely
> on the list.  Others will follow your example, making that person's
> behavior the minority.  It is far more powerful than explicitly
> stating what is "acceptable" behavior and what is not.

Leading by example is a great approach, and has the effect that you
describe on the majority of people.  But I also think it would be
helpful for the community to agree on a few very minimum standards of
behavior that we insist on, and to call people out (preferably in a
private email) if they fall short of these standards.

> 5. We are a community of programmers, and we are here to collaborate
> on code.  The argument that leads to higher efficiency and better code
> has an automatic advantage over the argument that doesn't.
> 
> If someone breaks one of these rules, there's a very simple way to
> communicate this to them: you don't respond to their email.
> Optionally, respond to their email off-list calmly explaining what
> went wrong.

I would prefer a community standards document that looks more like this:

* Treat other community members with courteousness and respect.

* Conduct disagreements on a technical, not a personal, level.  It is
unacceptable to attack another community member personally, even by
insinuation.

* Keep in mind that email is a medium prone to misunderstandings, and
that many mailing list participants do not speak English as their first
language.  Interpret other people's emails charitably.  If you are not
sure that you understand, ask for clarification.  Assume good intentions
on the part of others, and do not attribute technical disagreements to
ulterior motives.  Choose your words carefully to help other people
avoid misinterpreting them, and avoid hyperbole.

* Strive to keep the mailing list a forum for effective collaboration.
Only post if you have something worthwhile to add to the discussion.  Be
concise and do not repeat what has already been said.  Code reviews,
contributions of patches, and concrete data such as bug reports are far
preferable to philosophizing, vague suggestions, and whining.  Avoid
bikeshedding and do not participate in flame wars.  Avoid revisiting
settled debates unless the facts have changed.

* Accept reviewers' comments gratefully and take them very seriously.
Show that you appreciate the help by giving the reviewer the benefit of
the doubt.  If, after careful consideration, you find that you cannot
agree with a reviewer's suggestion, explain your reasoning carefully
without taking or giving offense, and seek compromise.

* When reviewing other peoples' code, be tactful and constructive.  Set
high expectations, but do what you can to help the submitter achieve
them.  Don't demand changes based only on your personal preferences.
Don't let the perfect be the enemy of the good.

* Be welcoming to new community participants.  Help them get oriented,
and be patient with their questions.  Gently introduce them to our
community standards, above all by setting a good example yourself.

* It is not OK to use these guidelines as a stick with which to beat
supposed violators.  However, if you genuinely feel that another
community member is routinely behaving in ways that are detrimental to
the community, it might help to calmly express your concerns to that
person, preferably in a private email, and naming concrete and specific
incidents rather than broad generalizations.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
