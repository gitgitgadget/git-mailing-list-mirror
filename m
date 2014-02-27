From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git in GSoC 2014
Date: Thu, 27 Feb 2014 08:34:58 +0100
Message-ID: <530EEAA2.3030306@alum.mit.edu>
References: <20140225154158.GA9038@sigill.intra.peff.net> <530CCFB0.5050406@alum.mit.edu> <20140226102350.GB25711@sigill.intra.peff.net> <530DC4D1.4060301@alum.mit.edu> <xmqq8usx4pvh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 08:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIvbh-000345-2G
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 08:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaB0HmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 02:42:08 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42897 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382AbaB0HmG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 02:42:06 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 02:42:06 EST
X-AuditID: 1207440c-f79656d000003eba-73-530eeaa759f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BA.CC.16058.7AAEE035; Thu, 27 Feb 2014 02:35:03 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1R7YxA4019587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 02:35:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqq8usx4pvh.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqLv8FV+wwf0HAhZdV7qZLBp6rzBb
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDNab/cyFewXrjjVNIO1gXEO
	fxcjJ4eEgInEkyfPWCFsMYkL99azdTFycQgJXGaUmHvsGSOEc55JYtKM84wgVbwC2hLz/nxh
	B7FZBFQldi1oZgGx2QR0JRb1NDOB2KICwRKrLz9ggagXlDg58wmYLSKgJjGx7RCQzcHBLGAk
	Me90PUhYWEBW4v691VCLrzNKLHh/nBWkhlPAWmJuRxaIKSEgLtHTGARSziygI/Gu7wEzhC0v
	sf3tHOYJjIKzkCybhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNK
	NzFCAppnB+O3dTKHGAU4GJV4eE8w8wULsSaWFVfmHmKU5GBSEuVd8xIoxJeUn1KZkVicEV9U
	mpNafIhRgoNZSYT3kAtQjjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wfsVZKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KH7ji4ERDJLiAdrr+Apkb3FB
	Yi5QFKL1FKMux+22X58YhVjy8vNSpcR55UCKBECKMkrz4FbA0tcrRnGgj4V5J4JcwgNMfXCT
	XgEtYQJaclSaB2RJSSJCSqqBsahe7Ng0WR7Nj++lgzY48p/lsK9UXCJd4Ndw0SPixaY61bbN
	JfXqcpIhOvrnv+72NK4yVrjPKxaZn+uz76PQjI+CC79+cj94MVCXo8D91uVaRZar 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242789>

On 02/26/2014 08:48 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> See my branch on GitHub [1] or read the appended text below.
> 
> Very nice.
> 
>> ## Introduction
>>
>> It is strongly recommended that students who want to apply to the Git
>> project for the Summer of Code 2014 should submit a small code-related
>> patch to the Git project as part of their application.  Think of these
>> microprojects as the "Hello, world" of getting involved with the Git
>> project; the coding aspect of the change can be almost trivial, but to
>> make the change the student has to become familiar with many of the
>> practical aspects of working on the Git project:
> 
> I'd suggest one step before all of the below.  
> 
>  * Here (http://thread.gmane.org/{TBD1,TBD2,TBD3...}) are a sample
>    set of threads that show how a change and a patch to implement it
>    is proposed by a developer X, the problem it attempts to solve,
>    the design of the proposed solution and the implementation of
>    that design are reviewed and discussed, and that after several
>    iterations it resulted in inclusion to our codebase.  As a GSoC
>    student, you will be playing the role of X and engaging in a
>    similar discussion.  Get familar with the flow, need for clarity
>    on both sides (i.e. you need to clearly defend your design, and
>    need to ask clarifications when questions/suggestions you are
>    offered are not clear enough), the pace at which the discussion
>    takes place, and the general tone of the discussion, to learn
>    what is expected of you.
> 
> That would help the later step, namely:
> 
>> * Expect feedback, criticism, suggestions, etc. from the mailing list.
>>
>>   *Respond to it!* and follow up with improved versions of your
>>   change.  Even for a trivial patch you shouldn't be surprised if it
>>   takes two or more iterations before your patch is accepted.  *This
>>   is the best part of the Git community; it is your chance to get
>>   personalized instruction from very experienced peers!*

Sounds good.  I suggest we make your blob a paragraph before the list of
bullet points rather than part of the list.  Please suggest some "TBD*"
then I'll add it to the text.  Would we also fill in "X" with the name
of the actual student involved in the conversation that is pointed to?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
