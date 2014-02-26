From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 11:41:21 +0100
Message-ID: <530DC4D1.4060301@alum.mit.edu>
References: <20140225154158.GA9038@sigill.intra.peff.net> <530CCFB0.5050406@alum.mit.edu> <20140226102350.GB25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 11:41:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIbvn-0000wW-BU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbaBZKlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:41:25 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56845 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750724AbaBZKlY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 05:41:24 -0500
X-AuditID: 12074413-f79076d000002d17-6e-530dc4d3f530
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.AF.11543.3D4CD035; Wed, 26 Feb 2014 05:41:23 -0500 (EST)
Received: from [192.168.69.148] (p57A2498D.dip0.t-ipconnect.de [87.162.73.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1QAfLxO026400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Feb 2014 05:41:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140226102350.GB25711@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqHv5CG+wwaStShZdV7qZLH609DA7
	MHk8693D6PF5k1wAUxS3TVJiSVlwZnqevl0Cd8b+k6dYC5YaV5yaXN7A+F6ji5GTQ0LARGLD
	v4OsELaYxIV769m6GLk4hAQuM0pc+N/BAuGcZ5I4966NDaSKV0Bb4tr062A2i4CqxOo771lA
	bDYBXYlFPc1MILaoQLDE6ssPWCDqBSVOznwCZosIyEp8P7yRsYuRg4NZQFyi/x9YWBgofP/e
	aqjFHYwS0ya2gM3hFLCWmHjoIStIvQRQfU9jEESrusT6eUIgFcwC8hLb385hnsAoOAvJslkI
	VbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERK6wjsYd52UO8Qo
	wMGoxMMbyMIbLMSaWFZcmXuIUZKDSUmU9+phoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3vcH
	gHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQleY2CMCgkWpaanVqRl
	5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYje+GBi9ICkeoL2+IO28xQWJuUBRiNZTjLoct9t+
	fWIUYsnLz0uVEuf1ACkSACnKKM2DWwFLVK8YxYE+FubVBKniASY5uEmvgJYwAS05Ks0DsqQk
	ESEl1cDYdHlW0O7c5nWTbqh+OXJgy4Q/3N4z3Gbq1eSLned6efUG+9aLdpf+1No+XPR4yf1z
	L+sDjO29wh48Zjn4qeONXJFeGet5vdfahg7fJjsnVghP5A5VXrzoMffe+zUi/zW8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242710>

On 02/26/2014 11:23 AM, Jeff King wrote:
> On Tue, Feb 25, 2014 at 06:15:28PM +0100, Michael Haggerty wrote:
>> Requiring students to submit a reasonable patch and follow up on review
>> comments seems like it would be a good way to filter out non-serious
>> students.  (I hesitate to require that the patch be accepted because it
>> can take quite a while for a patch to make it to master, despite of the
>> student's efforts.)
> 
> Yeah, I think the early stages of "accepted" are somewhat vague.
> Probably "patch is in next" is a reasonable definition, but I do not
> think we even need to bind ourselves so strictly. Humans read, evaluate,
> and rank the proposals, so we can use our judgement about whether a
> patch looks promising.

Agreed.

> [...]
>> If we wanted to impose such a hurdle, then we would definitely have to
>> make up a list of microprojects so that the students don't have to start
>> from nothing.  [...]
>> If the reaction is positive to this idea then I volunteer to spend
>> several hours tomorrow looking for microprojects, and I suggest other
>> core developers do so as well.  They should presumably be submitted as
>> patches to the ideas repository [1].
> 
> Yes, though I think it makes sense to put them on a separate page. We
> should probably write up some notes for students, too: how to get in
> touch with us, what do we expect of them in the pre-proposal period,
> what would we expect in terms of communication and day-to-day workflow
> during the summer, etc.

Since time is short, I already started on this.  I wrote a first draft
of an introduction for the students.  I also started looking for
microprojects.  I started going through our source files alphabetically,
and have already found six suggestions by "bundle.c", so I don't think
there will be a problem finding enough tiny things to do.

See my branch on GitHub [1] or read the appended text below.

I've been looking for *really* tiny projects.  Feedback is welcome about
whether they are too trivial to be meaningful in distinguishing
promising students from no-hopers.  My feeling is that there is so much
process involved in submitting a patch that it will take even a
well-prepared student quite a while to make a change, no matter how trivial.

Also, how many suggested microprojects do you think we need (i.e., when
can I stop :-) )?

Michael

[1] https://github.com/mhagger/git.github.io/tree/microprojects


---
layout: default
title: SoC 2014 Applicant Microprojects
---

## Introduction

It is strongly recommended that students who want to apply to the Git
project for the Summer of Code 2014 should submit a small code-related
patch to the Git project as part of their application.  Think of these
microprojects as the "Hello, world" of getting involved with the Git
project; the coding aspect of the change can be almost trivial, but to
make the change the student has to become familiar with many of the
practical aspects of working on the Git project:

* Downloading the source code: clone the repository using the
  [Git via Git](http://git-scm.com/downloads) instructions and read
  the `README` file.

* Build the source code: this is described in the file `INSTALL`.

* Glance over our coding guidelines in the file
  `Documentation/CodingGuidelines`.  We take things like proper code
  formatting very seriously.

* Read about the process for submitting patches to Git: this is
  described in `Documentation/SubmittingPatches`.

* Making the actual change.

* Run the test suite: this is described in the file `t/README`.  (If
  you have added new functionality, you should also add tests, but
  most microprojects will not add new functionality.)

* Commit your change.  Surprise: we use Git for that, so you will need
  to gain at least
  [a basic familiarity](http://git-scm.com/documentation) with using
  Git.  Make sure to write a good commit message that explains the
  reason for the change and any ramifications.  Remember to add a
  Signed-off-by line (see the coding guidelines for more information).

* Submit your change to the Git mailing list.  For this step you
  probably want to use the commands `git format-patch` and `git
  send-email`.

* Expect feedback, criticism, suggestions, etc. from the mailing list.

  *Respond to it!* and follow up with improved versions of your
  change.  Even for a trivial patch you shouldn't be surprised if it
  takes two or more iterations before your patch is accepted.  *This
  is the best part of the Git community; it is your chance to get
  personalized instruction from very experienced peers!*

The coding part of the microproject should be very small (say, 10-30
minutes).  We don't require that your patch be accepted into master by
the time of your formal application; we mostly want to see that you
have a basic level of competence and especially the ability to
interact with the other Git developers.

When you submit your patch, please mention that you plan to apply for
the GSoC.  This will ensure that we take special care not to overlook
your application among the large pile of others.

## Ideas for microprojects

The following are just ideas.  Any small code-related change would be
suitable.  Just remember to keep the change small!  It is much better
to finish a small but complete patch than to try something too
ambitious and not get it done.

1.  Rewrite `git-compat-util.h:skip_prefix()` as a loop, so that it
    doesn't have to scan through the `prefix` string twice.

2.  Change `branch.c:install_branch_config()` to use `skip_prefix()`.

3.  In `branch.c:setup_tracking()`, figure out where the magic number
    `1024 - 7 - 7 - 1` comes from.  (Looking through the commit
    history might help.)  If the check involving the number is still
    necessary, document where the number comes from.  If the check is
    no longer necessary, explain why and delete the check.

4.  Rewrite `bulk-checkin.c:finish_bulk_checkin()` to use a `strbuf`
    for handling `packname`, and explain why this is useful.  Also
    check if the first argument of
    `pack-write.c:finish_tmp_packfile()` can be made const.

5.  Change `bundle.c:add_to_ref_list()` to use `hashcpy()`.  See if
    you can find other places where `hashcpy()` should be used instead
    of `memcpy()`.

6.  Change `bundle.c:add_to_ref_list()` to use `ALLOC_GROW()`.


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
