From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 20:52:05 +0200
Message-ID: <51B771D5.6030809@alum.mit.edu>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com> <51B6AA7F.1060505@alum.mit.edu> <7v38sod1kn.fsf@alter.siamese.dyndns.org> <20130611182936.GM22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTg1-0007kh-72
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab3FKSwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:52:12 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57130 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755340Ab3FKSwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 14:52:09 -0400
X-AuditID: 1207440d-b7f006d000000adf-de-51b771d985eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.D4.02783.9D177B15; Tue, 11 Jun 2013 14:52:09 -0400 (EDT)
Received: from [192.168.69.140] (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BIq5E9007523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 14:52:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130611182936.GM22905@serenity.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqHuzcHugwZteVotVMx+zW3Rd6Way
	aOi9wmwx7ecuVosb54HE25tLGB3YPHbOusvucfbRA2aPi5eUPT5vkgtgieK2SUosKQvOTM/T
	t0vgzmg+OZm5YJ1oxcljf5kaGB8IdDFyckgImEg8mDeDHcIWk7hwbz1bFyMXh5DAZUaJh1Nv
	MEE455kkTjX2MYNU8QpoS0x51csCYrMIqErc/X0azGYT0JVY1NPMBGKLCoRJvF82lRWiXlDi
	5MwnYDUiQPXTPt0A28YscItR4sxRbhBbWMBM4tiLmSwQyw4wSty4PQmsmVPASOLKim9sEA06
	Eu/6HjBD2PIS29/OYZ7AKDALyY5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjX
	SC83s0QvNaV0EyMkzHl3MP5fJ3OIUYCDUYmH94DZ9kAh1sSy4srcQ4ySHExKorzFBUAhvqT8
	lMqMxOKM+KLSnNTiQ4wSHMxKIry6uUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC
	1CKYrAwHh5IE73eQoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgaI0vBsYrSIoH
	aO9fkHagyxJzgaIQracYdTlm/Jj8jlGIJS8/L1VKnPcjSJEASFFGaR7cClhSe8UoDvSxMO8R
	kCoeYEKEm/QKaAkT0JKiDLAlJYkIKakGRg7L8wwtP5lWFx5gdYh+pjR7ypMA9f0hsY/z/Pcu
	EdMqWy27mntSc1b0hG1rOPUMzN/+/xB90FIlzSPpr8PWOCHpmY+nR+rfkjts+dlL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227496>

On 06/11/2013 08:29 PM, John Keeping wrote:
> On Tue, Jun 11, 2013 at 10:00:56AM -0700, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> * When reviewing other peoples' code, be tactful and constructive.  Set
>>> high expectations, but do what you can to help the submitter achieve
>>> them.  Don't demand changes based only on your personal preferences.
>>> Don't let the perfect be the enemy of the good.
>>
>> I think this is 30% aimed at me (as I think I do about that much of
>> the reviews around here).  I fully agree with most of them, but the
>> last sentence is a bit too fuzzy to be a practically useful
>> guideline.  Somebody's bare minimum is somebody else's perfection.
>> An unqualified "perfect is the enemy of good" is often incorrectly
>> used to justify "It works for me." and "There already are other
>> codepaths that do it in the same wrong way.", both of which make
>> things _worse_ for the long term project health.
> 
> One thing that I think is missing from these proposals so far is some
> clear indication that a review should not be confrontational.  Consider
> the following two review comments (taken from a recent example that
> happened to stick in my mind, but I don't want to single out any one
> individual here):
> 
>     Ugh, why this roundabout-passive-past tone?  Use imperative tone
>     like this:
> 
>         ...
> 
> vs.
> 
>     We normally use the imperative in commit messages, perhaps like
>     this?
> 
>         ...
> 
> Both say the same thing but the first immediately puts the submitter on
> the defensive.  If I see something like that on one of my patches I have
> to consciously resist the urge to reply immediately and instead review
> what I'm about to send once I've calmed down.

That's a very good point (and a good illustration, too).  How do you
like the new second and third sentences below?

* When reviewing other peoples' code, be tactful and constructive.
Remember that submitting patches for public critique can be very
intimidating and when mistakes are found it can be embarrassing.  Do
what you can to make it a positive and pleasant experience for the
submitter.  Set high expectations, but do what you can to help the
submitter achieve them.  Don't demand changes based only on your
personal preferences. Don't let the perfect be the enemy of the good.

(As Junio pointed out, the last sentence is not so great and a better
replacement would be welcome.)

> As my mother would say, "politeness costs nothing" ;-)

Does your mother program C?  We could use her around here :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
