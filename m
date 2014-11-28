From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Our cumbersome mailing list workflow
Date: Fri, 28 Nov 2014 16:34:09 +0100
Message-ID: <547895F1.1010307@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com> <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu> <546F4B5B.2060508@alum.mit.edu> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com> <5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de> <20141127225334.GA29203@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 16:34:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuNZ1-0007sg-5S
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 16:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaK1Pe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2014 10:34:27 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62433 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbaK1Pe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 10:34:26 -0500
X-AuditID: 1207440e-f79d26d000001b6e-6e-547895f43747
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.BA.07022.4F598745; Fri, 28 Nov 2014 10:34:12 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0216.dip0.t-ipconnect.de [93.219.2.22])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sASFY9lV029266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Nov 2014 10:34:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141127225334.GA29203@dcvr.yhbt.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqPtlakWIwcmnohZdV7qZLBp6rzBb
	vL25hNFif1OSxb8JNRabN7ezWHR2fGV0YPfYOesuu8eCTaUeFy8pe3zeJOdx+9k2Fo/mKedZ
	A9iiuG2SEkvKgjPT8/TtErgzNk2+yFgwVbZi4r1TzA2MW8W7GDk5JARMJPbceMgKYYtJXLi3
	ng3EFhK4zCix8HNqFyMXkH2WSWLF3Z/MXYwcHLwC2hKtywRAalgEVCUmnN0G1ssmoCuxqKeZ
	CcQWFQiSOLnnOjuIzSsgKHFy5hMWEFtEoFxi4cd1LCAzmQX2MUr0938DSwgLGEo8un+ODWLZ
	KiaJmYc/gU3iFDCWaN+0FmwSs4C6xJ95l5ghbHmJ5q2zmScwCsxCsmQWkrJZSMoWMDKvYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgJfr4djO3rZQ4xCnAwKvHwBjBWhAix
	JpYVV+YeYpTkYFIS5fXqAArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4U0vAcrxpiRWVqUW5cOk
	pDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4V04BahQsSk1PrUjLzClBSDNxcIIM55IS
	KU7NS0ktSiwtyYgHxWp8MTBaQVI8QHvvgbTzFhck5gJFIVpPMSpKifMuAkkIgCQySvPgxsJS
	2itGcaAvhXnfgVTxANMhXPcroMFMQIPFppaCDC5JREhJNTCW3HJj3sTl4Pz28OzABJ5AP17+
	jyKrpqS4qf7ZMDFn28/d1xg2nuvuSUqI+CHY/dnKMqzS9Oh+q0MGygy/yz0OaXUk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260366>

On 11/27/2014 11:53 PM, Eric Wong wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>> On 2014-11-25 01.28, Michael Haggerty wrote:
>>> [...]
>> In short:
>> We can ask every contributor, if the patch send to the mailing list
>> is available on a public Git-repo, and what the branch name is,
>> like _V2.. Does this makes sense ?
>=20
> Not unreasonable.  I hope that won't give folks an excuse to refuse
> to mail patches, though.  Some folks read email offline and can't
> fetch repos until they're online again.

My ideal would be to invert the procedure. Let the patches in a public
Git repository somewhere be the primary artifact, and let the review
process be focused there. Let email be an alternative interface to the
central review site:

* Generate patch emails (similar to the current format) when pull
requests are submitted.

* Generate notification emails when people comment on the patches.

* Allow people to respond to the patch and notification emails via
email. The central review site should associate those comments with the
patches that they apply to, and present them along with other review
comments received via other interfaces.

>> I like Gerrit as well.
>> But it is less efficient to use, a WEB browser is slower (often), an=
d
>> you need to use the mouse...
>=20
> IMNSHO, development of non-graphical software should never depend on
> graphical software.  Also, I guess there is no way to comment on Gerr=
it
> via email (without registration/logins?).

The days of the vt52 are over. I'm an old neckbeard myself and have use=
d
*real* vt52s. But these days even my *cellphone* is able to handle the
GitHub website [1]. Rejecting modern technology is not intrinsically
virtuous; it only makes sense if the old technology is really superior.
And it is not enough for it to be superior only for neckbeards; it
should be superior when averaged over all of the people whose
participation we would like to have in the Git project.

And by the way, there are text-only clients for interacting with GitHub=
 [1].

> Lately, I've been trying to think of ways to make collaboration less
> centralized.  Moving to more centralized collaboration tools is a ste=
p
> back for decentralized VCS.

If an efficient decentralized collaboration system existed, then I'd
love to give it a chance. But as far as I know, the existing systems ar=
e
all embryonic.

Don't forget that even our current system is centralized to some extent=
=2E
There is a single mailing list through which all emails pass. There are
a few email archives that we de facto rely on (and it is a brittle
dependency--if Gmane were to disappear, we would have an awful lot of
broken URLs in our emails that would be impossible to fix).

It seems like a few desirable features are being talked about here, and
summarizing the discussion as "centralized" vs "decentralized" is too
simplistic. What is really important?

1. Convenient and efficient, including for newcomers
2. Usable while offline
3. Usable in pure-text mode
4. Decentralized

Something else?

In my opinion, a central system with good Git integration (helps with 1=
)
and both a straightforward web UI (also helps 1) and a good email
interface (which gives both 2 and 3) and the ability to export the
review history (which avoids lockin, the most important aspect of 4)
would be perfect. Is there such a thing?

Michael

[1] ...probably other websites too. I'm really not trying to flog GitHu=
b
here; it's just the one I have the most experience with. In fact, I
kindof assume that the Git project would choose a service that is itsel=
f
based on open-source software.

--=20
Michael Haggerty
mhagger@alum.mit.edu
