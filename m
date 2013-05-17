From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 15:14:58 +0200
Message-ID: <51962D52.7070200@alum.mit.edu>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com> <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com> <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu> <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com> <5195F3EB.8000308@alum.mit.edu> <CACPiFCLqtSy_=1yw6mGWFhNOi=M1rrPNbD6=qpo4FOO_QywCgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 15:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdKV6-0007Ax-1X
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 15:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab3EQNPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 09:15:04 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:60122 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754886Ab3EQNPD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 09:15:03 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-20-51962d552254
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DD.99.02295.55D26915; Fri, 17 May 2013 09:15:01 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4HDExCV028266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 May 2013 09:15:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CACPiFCLqtSy_=1yw6mGWFhNOi=M1rrPNbD6=qpo4FOO_QywCgg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqBuqOy3Q4N9hQ4sNc++yWHRd6Way
	aOi9wmyxcZ2JA4vHzll32T0uXlL2+LxJLoA5itsmKbGkLDgzPU/fLoE7Y+/aRvaCd3IVy38t
	Z2xgPCfRxcjJISFgIrFz4lVmCFtM4sK99WxdjFwcQgKXGSVuLVrEDuFcZ5I4vP0sK0gVr4C2
	xK3eg2A2i4CqRPveBrBuNgFdiUU9zUwgtqhAmMSq9cuYIeoFJU7OfMLSxcjBISKgL7H0tjxI
	mFmgSuLGlu1sIGFhAR2JeTNDIVZ1Mku0rv8FNp5TIFBi5r0OFoh6HYl3fQ+YIWx5ie1v5zBP
	YBSYhWTDLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREsI8
	Oxi/rZM5xCjAwajEw1vxe0qgEGtiWXFl7iFGSQ4mJVHeNK1pgUJ8SfkplRmJxRnxRaU5qcWH
	GCU4mJVEeI9/nBooxJuSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4A3U
	ARoqWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rU+GJgrIKkeID2xoO08xYXJOYC
	RSFaTzEac2w+P/kdI8eMH0BSiCUvPy9VSpxXCaRUAKQ0ozQPbhEseb1iFAf6W5hXC6SKB5j4
	4Oa9AlrFBLSK9RrIi8UliQgpqQbG9Nlse34mqGWf3+LrKsxfve5FV6nDFrYSljtaP/1PFyy2
	WNP9TXyn8dx8B1u79k9ZbDMefTNSF9NRYX8e+41LUIyD/+78lK49O289zkm0OKF9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224689>

On 05/17/2013 01:50 PM, Martin Langhoff wrote:
> On Fri, May 17, 2013 at 5:10 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> For one-time imports, the fix is to use a tool that is not broken, like
>> cvs2git.
> 
> As one of the earlier maintainers of cvsimport, I do believe that
> cvs2git is less broken, for one-shot imports, than cvsimport. Users
> looking for a one-shot import should not use cvsimport as there are
> better options there. Myself, I have used parsecvs (long ago, so
> perhaps it isn't the best of the crop nowadays).
> 
> TBH, I am puzzled and amused at all the chest-thumping about cvs
> importers. Yeah, yours is a bit better or saner, but we all wade in
> the muddle of essentially broken data. So "is not broken" is rather
> misleading when talking to end users. It carries so many caveats about
> whether it'll work on the users' particular repo that it is not a
> generally truthful statement.

I disagree.  I use the following definition of "correct":

    The Git history output by an importer must not contradict the
    history that is recorded in CVS.

We both know that the CVS history omits important data, and that the
history is mutable, etc.  So there are lots of hypothetical histories
that do not contradict CVS.  But some things are recorded unambiguously
in the CVS history, like

* The contents at any tag or the tip of any branch (i.e., what is in the
working tree when you check it out).

* The order of modifications to a single file on a single branch and the
file contents after each of those revisions.

* Who committed a particular change, and approximately when (modulo
clock skew).

If a tool doesn't get these things correct (especially the first!) then
it should only be used with great caution.  cvsimport can make mistakes
on the first two.  As far as I know, cvs2svn/cvs2git are correct
according to this definition.


That being said, I appreciate that cvsimport can do incremental imports.
 cvs2git doesn't even attempt it.  I've thought about what it would take
to implement correct incremental imports in cvs2svn/cvs2git, and it is
far beyond the budget of time that I have for the project.  So I
definitely give props to cvsimport for attempting incremental imports
and apparently often doing a good enough job that it is useful to people.

> [...]
> At the time, I looked into trying to use cvs2svn (precursor to
> cvs2git) as the "CVS read" side of cvsimport, but it did not support
> incremental imports at all, and it took forever to run.

cvs2svn still doesn't support incremental imports, and it still takes a
long time to run (though less than before).  cvs2git is considerably
faster, partly because of the speed and convenience of using
git-fast-import.  But conversion time is much less of an issue for
one-time conversions.

> It was a time when git was new and people were dipping their toes in
> the pool, and some developers were pining to use git on projects that
> used CVS (like we use git-svn now). Incremental imports were a must.
> 
> One of the nice features of cvsimport is that it can do incrementals
> on a repo imported with another tool. That earns it a place under the
> sun. If it didn't have that, I'd be voting for removal (after a review
> that the replacement *is* actually better ;-) across a number of test
> repos).

Incremental imports are indeed the saving grace of cvsimport and for
that reason I don't advocate it's removal.  But I think we should be
clearer about warning users against using it for one-time imports,
because it can produce output that is *objectively* incorrect in
important ways.

Regarding tests, the failing tests that I added to the cvsimport test
suite a few years ago were taken directly from the cvs2svn/cvs2git test
suite, where they pass :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
