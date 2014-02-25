From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git in GSoC 2014
Date: Tue, 25 Feb 2014 18:15:28 +0100
Message-ID: <530CCFB0.5050406@alum.mit.edu>
References: <20140225154158.GA9038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 25 18:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WILbZ-0006m7-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 18:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbaBYRPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 12:15:33 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52121 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960AbaBYRPc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 12:15:32 -0500
X-AuditID: 12074413-f79076d000002d17-b2-530ccfb2ede8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 08.E4.11543.2BFCC035; Tue, 25 Feb 2014 12:15:30 -0500 (EST)
Received: from [192.168.69.148] (p57A2448A.dip0.t-ipconnect.de [87.162.68.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1PHFSM6011290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 25 Feb 2014 12:15:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140225154158.GA9038@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqLvpPE+wQfceA4uuK91MFj9aepgd
	mDye9e5h9Pi8SS6AKYrbJimxpCw4Mz1P3y6BO+NbTzdbwQn+ig97HzE3MB7j6WLk5JAQMJG4
	+P8/I4QtJnHh3nq2LkYuDiGBy4wSndM7mCCc80wSxw9vYAep4hXQlrj85BhYB4uAqkTT8YVM
	IDabgK7Eop5mMFtUIFhi9eUHLBD1ghInZz4Bs0UEZCW+H94I1MvBwSwgLtH/DywsDBS+f281
	G4gtJGApcbz3OdgqTgEriRdb37KDlEsAlfc0BkF0qkusnycEUsEsIC+x/e0c5gmMgrOQ7JqF
	UDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCGhK7yDcddJuUOM
	AhyMSjy8HcXcwUKsiWXFlbmHGCU5mJREefce4QkW4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7
	dRVQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbvhHFCjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCh244uB0QuS4gHaewyknbe4IDEXKArReopRl+N2
	269PjEIsefl5qVLivGwgRQIgRRmleXArYInqFaM40MfCvGUgVTzAJAc36RXQEiagJUelwZaU
	JCKkpBoYrVIDp3n/kXx0zq/I50Dz2gVrFf47cL5auTddRuh5haehw+yX7T8tX1WFJLY3TrQU
	+7gz46yvuyfTtEwJlgRx7XevUtYHSeyxafow4Xh17/Tzy79Ypi3dMT9kE/PF3XfZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242675>

On 02/25/2014 04:41 PM, Jeff King wrote:
> I'm pleased to announce that Git has been accepted to this year's Google
> Summer of Code.

Cool!  Thanks to Peff and Thomas and Vicent and whomever else was
involved in getting our application done!  For those who don't know, the
application covers both Git core and libgit2.

> We didn't discuss earlier whether we would have any specific
> requirements for students during the proposal period (e.g., having a
> patch accepted). It would be good to put together rules (or barring any
> specific requirements, guidelines to help students put together a good
> proposal) as soon as possible. Suggestions are welcome.

Requiring students to submit a reasonable patch and follow up on review
comments seems like it would be a good way to filter out non-serious
students.  (I hesitate to require that the patch be accepted because it
can take quite a while for a patch to make it to master, despite of the
student's efforts.)

Does anybody know whether other organizations have had good experience
with criteria like that?  Does it chase *all* the applicants away?

If we wanted to impose such a hurdle, then we would definitely have to
make up a list of microprojects so that the students don't have to start
from nothing.  I imagine it shouldn't be too hard to find tiny projects
estimated at 10-30 minutes of actual work, which should be plenty
difficult for a student who also has to figure out how to check out the
code, conform to our coding standards, run the unit tests, create a
patch submission, etc.

If the reaction is positive to this idea then I volunteer to spend
several hours tomorrow looking for microprojects, and I suggest other
core developers do so as well.  They should presumably be submitted as
patches to the ideas repository [1].

What do you think?

Michael

[1] https://github.com/git/git.github.io

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
