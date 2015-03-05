From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: weaning distributions off tarballs: extended verification of
 git tags
Date: Thu, 05 Mar 2015 13:36:27 +0100
Message-ID: <54F84DCB.9000900@alum.mit.edu>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>	<CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>	<1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>	<20150302181230.GA31798@kitenet.net>	<CACsJy8C3=f=esBrHE8OudSa0nUbCrLaYJtLC2in3p+tcc-d9bw@mail.gmail.com> <xmqqsidn7ymg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Joey Hess <id@joeyh.name>, GIT Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 13:36:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTV1B-0005V9-9Z
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 13:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603AbbCEMgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 07:36:41 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58776 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755376AbbCEMgj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 07:36:39 -0500
X-AuditID: 1207440d-f79976d000005643-29-54f84dcef4bd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.F6.22083.ECD48F45; Thu,  5 Mar 2015 07:36:30 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25CaSc2020620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 07:36:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqsidn7ymg.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHvO90eIQd9TS4uuK91MFg29V5gt
	rrz6yGzRPeUtowOLx85Zd9k9HjxS8rh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6Mb8+3sBQ8
	4qnYdnwyWwPjT84uRk4OCQETiauPzzBB2GISF+6tZ+ti5OIQErjMKPFy4isWCOcck8Sh2w0s
	IFW8AtoSv97eZQOxWQRUJT41rGAGsdkEdCUW9TSDTRIVCJI4dPoxVL2gxMmZT8BsEQE3ia+3
	r7OC2MwCrhL3X7aA1QsLhEg83XgIatkHJonWQ1vAhnIKWEvsvtML1aAnseP6LyhbXqJ562zm
	CYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQgKa
	dwfj/3UyhxgFOBiVeHg/bP4eIsSaWFZcmXuIUZKDSUmUN9j4R4gQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEd58LaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC944P
	UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFrji4HxCpLiAdq7HaSdt7ggMRco
	CtF6ilFRSpz3EEhCACSRUZoHNxaWpl4xigN9KczLAExaQjzAFAfX/QpoMBPQYC0xsMEliQgp
	qQZGoedvSnZbqQr/XvLb6xOTnrvkBjOZ6VeiWy883JzO87VnjlHtRiuL7Qy9qivFA9MEFqXe
	/JsgyPqzzXxuzpWeOcEJfserOwoXXv5SW/1MYPHvu9GieXGmN/1edc1cOEepfMFt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264832>

On 03/03/2015 12:44 AM, Junio C Hamano wrote:
> [...]
> I was about to suggest another alternative.
> 
>     Pretend as if Git internally used SHA-512 (or whatever hash you
>     want to use) instead of SHA-1, compute the object names that
>     way.  Recompute the contents of a tree object is by replacing
>     the 20-byte SHA-1 field in it with a field with whatever
>     necessary length to hold the longer object names of elements in
>     the tree.
> 
> But then a realization hit me: what new value will be placed in the
> "parent " field in the commit object?  You cannot have SHA-512
> variant of commit object name without recomputing the whole history.
> 
> Now, if the final objective is to replace signature of tarballs,
> does it matter to cover the commit object, or is it sufficient to
> cover the tree contents?

The original goal was to replace a tarball signature, for which the
"alternative" that you described above seems quite elegant.

If the goal were really to certify the entire history, then none of the
proposals that I have seen so far is adequate anyway, because none of
them propose to include better than the original SHA-1s of the parent
commits.

Including other metadata from the release commit does not seem useful to
me; how valuable is it to know the author and commit message of the last
commit that happened to make it into a release? It would be more useful
to know the SHA-1 of that commit, but that would presumably be included
elsewhere in the packaging data used by the distribution.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
