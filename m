From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Wed, 23 Jan 2013 10:54:36 +0100
Message-ID: <50FFB35C.7070809@alum.mit.edu>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com> <20130120125838.GK31172@serenity.lan> <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com> <20130120152857.GM31172@serenity.lan> <7vsj5vlm1d.fsf@alter.siamese.dyndns.org> <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txx2w-00044V-9m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 10:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab3AWJyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 04:54:44 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:44653 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753926Ab3AWJyl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 04:54:41 -0500
X-AuditID: 1207440d-b7f306d0000008b7-67-50ffb3615f3c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C4.87.02231.163BFF05; Wed, 23 Jan 2013 04:54:41 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0N9sbcF027859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Jan 2013 04:54:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqJu4+X+AwZ3zHBY75+5jtei60s1k
	0dB7hdnixvldrA4sHmcfPWD2uHhJ2WP3aVaPz5vkAliiuG2SEkvKgjPT8/TtErgz7mxNKngl
	W3H51xfWBsZn4l2MnBwSAiYS56+9Y4awxSQu3FvP1sXIxSEkcJlR4uWJTmYI5ziTxK1bm1hA
	qngFtCV+/Z0B1sEioCqx7P0MVhCbTUBXYlFPMxOILSoQJtH7+hwjRL2gxMmZT8B6RYDq7zVc
	ZQexmQXSJVbvOsMGYgsLWEjs2L6ZFWLZQSaJuzv3gRVxCgRKTLmyjwmiQUfiXd8DZghbXmL7
	2znMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5i
	hIQz7w7G/+tkDjEKcDAq8fByPfkXIMSaWFZcmXuIUZKDSUmUd/am/wFCfEn5KZUZicUZ8UWl
	OanFhxglOJiVRHhV1gLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoS
	vLtBhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL37QNp5iwsS
	c4GiEK2nGHU5tv9uf84oxJKXn5cqJc5bB1IkAFKUUZoHtwKWvF4xigN9LMy7F6SKB5j44Ca9
	AlrCBLRk/yywJSWJCCmpBkbtVl+nmJ36MXGMhUsSN536kHbaf2FwneGCF80d/xmr9WS2vHn0
	kW3NS8330yzq0hbPsfp+tX55Y+XuugPid62uJlZVTF+9UXrx1vii3qQtxYx739YU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214306>

On 01/20/2013 09:17 PM, Chris Rorvick wrote:
> I probably won't be sending any more patches on this.  My hope was to
> get cvsimport-3 (w/ cvsps as the engine) in a state such that one
> could transition from the previous version seamlessly.  But the break
> in t9605 has convinced me this is not worth the effort--even in this
> trivial case cvsps is broken.  The fuzzing logic aggregates commits
> into patch sets that have timestamps within a specified window and
> otherwise matching attributes.  This aggregation causes file-level
> commit timestamps to be lost and we are left with a single timestamp
> for the patch set: the minimum for all contained CVS commits.  When
> all commits have been processed, the patch sets are ordered
> chronologically and printed.
> 
> The problem is that is that a CVS commit is rolled into a patch set
> regardless of whether the patch set's timestamp falls within the
> adjacent CVS file-level commits.  Even worse, since the patch set
> timestamp changes as subsequent commits are added (i.e., it's always
> picking the earliest) it is potentially indeterminate at the time a
> commit is added.  The result is that file revisions can be reordered
> in resulting Git import (see t9605.)  I spent some time last week
> trying to solve this but I coudln't think of anything that wasn't a
> substantial re-work of the code.
> 
> I have never used cvs2git, but I suspect Eric's efforts in making it a
> potential backend for cvsimport are a better use of time.

Thanks for your explanation of how cvsps works.

This is roughly how cvs2svn used to work years ago, prior to release
2.x.  In addition it did a number of things to try to tweak the
timestamp ordering to avoid committing file-level commits in the wrong
order.  It never worked 100%; each tweak that was made to fix one
problem created another problem in another scenario.

cvs2svn/cvs2git 2.x takes a very different approach.  It uses a
timestamp threshold along with author and commit-message matching to
find the biggest set of file-level commits that might constitute a
repository-level commit.  But then it checks the proto-commits to see if
they violate the ordering constraints imposed by the individual
file-level commits.  For example, if the initial grouping gives the
following proto-commits:

proto-commit 1: a.txt 1.1        b.txt 1.2

proto-commit 2: a.txt 1.2        b.txt 1.1

then it is apparent that something is wrong, because a.txt 1.1
necessarily comes before a.txt 1.2 whereas b.txt 1.1 necessarily comes
before b.txt 1.2 (CVS can at least be relied on to get this right!) and
therefore there is no consistent ordering of the two proto-commits.
More generally, the proto-commits have to form a directed acyclic graph,
whereas this graph has a cycle 1 -> 2 -> 1.  When cvs2svn/cvs2git finds
a cycle, it uses heuristics to break up one or more of the proto-commits
to break the cycle.  In this case it might break proto-commit 1 into two
commits:

proto-commit 1a: a.txt 1.1

proto-commit 2:  a.txt 1.2        b.txt 1.1

proto-commit 1b:                  b.txt 1.2

Now it is possible to commit them in the order 1a,2,1b.  (Exactly this
scenario is tested in t9603.)

Of course a typical proto-commit graph often contains far more
complicated cycles, but the approach remains the same: split
proto-commits up as necessary until the graph is acyclic.  One can
quibble about the heuristics that cvs2svn/cvs2git uses to break up
proto-commits.  But the final result of the algorithm is *guaranteed* to
be consistent with the file-level CVS history and also self-consistent.

I am skeptical that a simpler approach will ever work 100%.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
