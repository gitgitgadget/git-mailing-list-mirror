From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Thu, 13 Jun 2013 05:45:50 +0200
Message-ID: <51B9406E.30104@alum.mit.edu>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com> <51B6AA7F.1060505@alum.mit.edu> <7vehc72j46.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 05:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmyU2-00011Z-M7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 05:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524Ab3FMDpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 23:45:55 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49454 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932403Ab3FMDpx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 23:45:53 -0400
X-AuditID: 12074414-b7f626d0000001f1-c8-51b940717c2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 87.8B.00497.17049B15; Wed, 12 Jun 2013 23:45:53 -0400 (EDT)
Received: from [192.168.69.140] (p57A2535E.dip0.t-ipconnect.de [87.162.83.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5D3joYM028277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Jun 2013 23:45:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vehc72j46.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqFvosDPQYO1kHotVMx+zW3Rd6Way
	aOi9wmwx7ecuVou3N5cwOrB67Jx1l93j4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M5Ycn8de
	8Fe84uFJzgbG+0JdjJwcEgImEjMOn2CFsMUkLtxbz9bFyMUhJHCZUeLz8wZ2kISQwDkmiR/L
	PboYOTh4BTQlWj+XgYRZBFQlprQ+BSthE9CVWNTTzARiiwqESbxfNhVsJq+AoMTJmU9YQGwR
	ATWJiW2HWEDmMwusZZQ42/+DESQhLGAmcezFTBaIxbMYJS5OeM0KsowTKHH1NtgCZgEdiXd9
	D5ghbHmJ7W/nME9gBCpG2DELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVm
	luilppRuYoQEs8gOxiMn5Q4xCnAwKvHwTmjeESjEmlhWXJl7iFGSg0lJlHeP5c5AIb6k/JTK
	jMTijPii0pzU4kOMEhzMSiK8noeAynlTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQW
	wWRlODiUJHiz7YGGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6g
	vX4g7bzFBYm5QFGI1lOMuhwHfmx5zyjEkpeflyolzusFUiQAUpRRmge3Apa6XjGKA30szBsM
	UsUDTHtwk14BLWECWlKUsR1kSUkiQkqqgTHohafydPE/dREZi/qnMu2p+Dv9nGbTZsXyCw8u
	LHrgrn9Na9mhAg5nozuFCUceTBDd8tz7zu/iWbmGthb1S9mEp7QHP/hgJcthqMoS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227694>

On 06/12/2013 10:02 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I would prefer a community standards document that looks more like this:
>> ...
>>
>> * Be welcoming to new community participants.  Help them get oriented,
>> and be patient with their questions.  Gently introduce them to our
>> community standards, above all by setting a good example yourself.
> 
> I agree that on-boarding is an important process.
> 
> In addition to the reviews I'd give to regulars, I personally try
> to do some of these things:
> 
>  - Even in a negative review, end the message with "Thanks".  More
>    important is to express that the particular patch is rejected but
>    contributor's future contribution (either a reroll or a separate
>    topic) is welcome.
> 
>    This is free, and there is no reason not to be nice.
> 
>  - Point out problems in a milder way than usual.  Instead of saying
>    "Why is this done like so?", risking to be misinterpreted that I
>    am saying the patch did something wrong and the contributor was a
>    horrible programmer, rephrase it to "Hmph, this may work in such
>    and such cases, but I wonder how well it would in this case?",
>    followed by "How about going this route instead, which would
>    cover all these cases?"
> 
>    Doing so is more time consuming at reviewers' end; once you know
>    the current design well enough, you can immediately smell a wrong
>    approach a lot faster by just looking at code and design in a
>    patch, without having to come up with a concrete example.
> 
>  - Instead of just pointing out minor nits and have the new
>    contributor reroll, point them out, and then show how the patch
>    should have looked like, often after "-- >8 --" and the "From:"
>    line that keeps attribution.
> 
>    Again this is more work at reviewers' end.
> 
> Coaching new contributors, like mentoring GSoC students, is often
> more time consuming than scratching the same itch yourself for any
> reviewer, but it is an investment, which hopefully yields dividend
> in the longer term.

Thanks for these concrete examples / suggestions for reviewers.  I
remember especially that during my first contacts with the Git community
I was very impressed by these very things in your code reviews and in
those of other reviewers.

Are you proposing that your text should find its way into the
CommunityGuidelines in some form?  I hesitate to make the document *so*
long, especially considering that the section for contributors would
then probably also be expanded by a similar amount.  But I think
distilling the advice into one or two sentences, also taking into
account the suggestions of others in this thread, would be a definite
improvement.

When I have time I want to submit some form of CommunityGuidelines as an
explicit patch, and I will try to synthesize all of the suggestions that
have been made.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
