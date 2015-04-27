From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 22:05:05 +0200
Message-ID: <553E9671.3000902@alum.mit.edu>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>	<vpq383ltoxi.fsf@anie.imag.fr>	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>	<vpqh9s1s9by.fsf@anie.imag.fr>	<xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com>	<vpq618hqu5d.fsf@anie.imag.fr> <xmqqfv7lwfvx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 27 22:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmpHT-0000xI-Sz
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 22:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbbD0UFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 16:05:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44953 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932964AbbD0UFX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2015 16:05:23 -0400
X-AuditID: 12074414-f797f6d000004084-5b-553e9673e28a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AA.72.16516.3769E355; Mon, 27 Apr 2015 16:05:07 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9763C.dip0.t-ipconnect.de [79.201.118.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3RK55A9023938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 27 Apr 2015 16:05:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqfv7lwfvx.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqFs8zS7UoPmbtUXXlW4mi4beK8wW
	lz6vZ3Vg9pj45Tirx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGdsfnqYtWCPeMWlzxOYGhh/
	CXUxcnBICJhIvPjr2sXICWSKSVy4t56ti5GLQ0jgMqNE65KDrBDOeSaJbT/OsYBU8QpoS3zr
	WMcMYrMIqEosaHnKDmKzCehKLOppZgKxRQWCJFqvTWWEqBeUODnzCViviECMxI97K5hAFjML
	iEv0/wMLCwtYSXza/okJYtddJompq66xgiQ4Bawlvn+/D2YzC+hJ7Lj+C8qWl2jeOpt5AqPA
	LCQrZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkNAV2cF4
	5KTcIUYBDkYlHt6CybahQqyJZcWVuYcYJTmYlER523rsQoX4kvJTKjMSizPii0pzUosPMUpw
	MCuJ8E7OBMrxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwPpoC1ChY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPZ+A2nnLS5IzAWKQrSe
	YlSUEudNnwqUEABJZJTmwY2FJaRXjOJAXwrz+oJU8QCTGVz3K6DBTECDK2fagAwuSURISTUw
	Ju1UjeKL/CJ6ymdP7xaXnBMaCVOy8/vt36Zq9vEwegZbOR64zHjYu0PLaO7/uTs2bX2h28e6
	606P4mrBreuEz68JvbdQISXJ+96kPJ/Et8u/XEq0Ss+/3m9bW/e/5+GxWal7qyJ4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267882>

On 04/27/2015 09:05 PM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>> [...]
>>> Well, the patch does not update git_multimail.py at all.  Requoting
>>> the part you omitted from my response
>>>
>>>     $ git rev-list -1 master contrib/hooks/multimail/
>>>     b513f71f6043c05c3918e670b332dfa7ec6b2661
>>>
>>>     which is b513f71f (git-multimail: update to version 1.0.0,
>>>     2014-04-07)
>>>
>>> it matches what "was obtained from the upstream project on
>>> 2014-04-07".
>>
>> Yes, but it also matches "was obtained on 2015-04-27", since only the
>> README has changed (the commit message of this patch says: "The only
>> changes are to the README files, most notably the list of maintainers
>> and the project URL.").
>>
>>> Or did you forget to include the update to the software in the
>>> patch?
>>
>> The update to the software is empty.
> 
> Hmm, that may be technically correct but it is grossly misleading to
> update the existing "was obtained on 2014-04-07" to "was obtained on
> 2015-04-27", especially if nothing was actually obtained, isn't it?

I'm sorry to have caused confusion. Matthieu, your explanations have
been exactly correct. Let me just add a couple of details:

Junio, you asked me (off-list) for an update to README and README.Git.
Those two files come from the git-multimail repo, as
git-multimail/README and git-multimail/README.Git.template,
respectively, so I modified the files in our repo then submitted the
corresponding patch to your repo.

It's true that only documentation changes are in the patch, but it still
seemed like good practice to create a tag and all that. If nothing else,
it will make it easier to figure out the baseline for future code drops.

There have been a couple of small software changes in git-multimail's
master branch, but I didn't include those in the patch I submitted to
you because I thought you wouldn't want to have code changes so close to
the release. So 1.0.2 is on the newly-created "maint" branch.

> I honestly am surprised that, after seeing the announcement about "a
> new repository, co-maintainer and multiple contributors", no code
> change is made over the past 12 months.

I totally understand your disappointment. Mea culpa. That, in fact, is
WHY I'm so happy that Matthieu has agreed to help maintain the project.
If it's any consolation, none of the user feedback that I have been so
remiss in addressing involves serious or security-related bugs.

> I would understand it if the description were "The version in this
> directory matches the upstream project as of 2015-04-27", though.

I think of the contents of contrib/hooks/multimail as a whole, so even
if the software hasn't changed, updated documentation *has* been
"obtained" from upstream. But feel free to adjust the text in whatever
way you like.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
