From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 19 Dec 2013 00:44:29 +0100
Message-ID: <52B2335D.2030607@alum.mit.edu>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com> <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com> <52B02DFF.5010408@gmail.com> <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com> <20131217145809.GC15010@thyrsus.com> <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com> <20131217184724.GA17709@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Thu Dec 19 00:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtQnA-0001Na-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 00:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab3LRXog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 18:44:36 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63993 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751231Ab3LRXof (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 18:44:35 -0500
X-AuditID: 12074414-b7fb46d000002a4d-a3-52b23362e23d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.BF.10829.26332B25; Wed, 18 Dec 2013 18:44:34 -0500 (EST)
Received: from [192.168.69.148] (p57A24A3C.dip0.t-ipconnect.de [87.162.74.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBINiVLQ019286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Dec 2013 18:44:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131217184724.GA17709@thyrsus.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqJtkvCnIYMJ6ZYurW3wsuq50M1ms
	uDqH2WLe3V1MFhvXmTiweuycdZfd49LL72wey752snh83iQXwBLFbZOUWFIWnJmep2+XwJ2x
	sP8uU8E7iYpLV54xNjAeFu5i5OSQEDCR+Pd2FxuELSZx4d56MFtI4DKjxJYVSl2MXED2OSaJ
	GxtfsoAkeAW0JVoOTQIq4uBgEVCV2HIrFiTMJqArsainmQnEFhUIknh06CE7RLmgxMmZT1hA
	ykUEhCWO9amBjGQWOMMo0btoE9guYQE1iWdPVzFC7LrJLPHp9XZmkASngKHE+xe/GEGaJQTE
	JXoag0BMZgF1ifXzhEAqmAXkJba/ncM8gVFwFpJtsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1
	Wbc4OTEvL7VI10IvN7NELzWldBMjJNBFdjAeOSl3iFGAg1GJhzfg+cYgIdbEsuLK3EOMkhxM
	SqK8s402BQnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b3CApTjTUmsrEotyodJSXOwKInzflus
	7ickkJ5YkpqdmlqQWgSTleHgUJLgXQQyVLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQk
	Ix4Uu/HFwOgFSfEA7Z0I0s5bXJCYCxSFaD3FqMsx78uHb4xCLHn5ealS4rxLQIoEQIoySvPg
	VsDS2itGcaCPhXkngVTxAFMi3KRXQEuYgJY8X7MOZElJIkJKqoExZseblWoSNgJ6k6wSQ85X
	K6y8tX2eUXnzaafNZ00U3vjlxr62Z9dTlS3YlLRyHrdz9Cb+l99D1Vb8WLQptN3/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239500>

On 12/17/2013 07:47 PM, Eric S. Raymond wrote:
> Johan Herland <johan@herland.net>:
>> However, I fear that you underestimate the number of users that want
>> to use Git against CVS repos that are orders of magnitude larger (in
>> both dimensions: #commits and #files) than your example repo.
> 
> You may be right. See below...
> 
> I'm working with Alan Barret now on trying to convert the NetBSD
> repositories. They break cvs-fast-export through sheer bulk of
> metadata, by running the machine out of core.  This is exactly
> the kind of huge case that you're talking about.
> 
> Alan and I are going to take a good hard whack at modifying cvs-fast-export 
> to make this work. Because there really aren't any feasible alternatives.
> The analysis code in cvsps was never good enough. cvs2git, being written
> in Python, would hit the core limit faster than anything written in C.

cvs2git goes to great lengths to store intermediate data to disk and
keep the working set small and therefore (despite the Python overhead) I
am confident that it scales better than cvs-fast-export.  My usual test
repo was gcc:

Total CVS Files:             25013
Total CVS Revisions:        578010
Total CVS Branches:        1487929
Total CVS Tags:           11435500
Total Unique Tags:             814
Total Unique Branches:         116
CVS Repos Size in KB:      2074248
Total SVN Commits:           64501

I also regularly converted mozilla (4.2 GB) and emacs (560 MB) for
testing purposes.  These could all be converted on a 32-bit computer.

Other projects that cvs2svn/cvs2git could handle: FreeBSD, Gentoo, KDE,
GNOME, PostgreSQL.  (Though for KDE, which I think was in the 16 GB
range, I know that they used a giant machine for the conversion.)

If you haven't tried cvs2git yet, please start it up somewhere in the
background.  It might take a while but it should have no trouble with
your repos, and then you can compare the tools based on experience
rather than speculation.

> Which matters, because right now the set of people working on CVS lifters
> begins with me and ends with Michael Rafferty (cvs2git), who seems even
> less interested in incremental conversion than I am.  Unless somebody
> comes out of nowhere and wants to own that problem, it's not going
> to get solved.

A correct incremental converter could be done (as long as the CVS users
don't literally change history retroactively) but it would be a lot of
work.  Parsing the CVS files isn't the problem; after all, CVS has to do
that every time you check out a branch.  The problem is the extra
bookkeeping that would be needed to keep the overlapping history
consistent between runs N and N+1 of the tool.  I sketched out what
would be necessary once and it came out to several solid weeks of work.

But the traffic on the cvs2svn/cvs2git mailing list has trailed off
essentially to zero, so either the software is perfect already (haha) or
most everybody has already converted.  Therefore I don't invest any
significant time in that project these days.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
