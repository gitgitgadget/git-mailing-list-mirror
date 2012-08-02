From: Jim Meyering <jim-Oxw1nKZkIVjk1uMJSBkQmQ@public.gmane.org>
Subject: Re: GNU patch close to next stable release (2)
Date: Thu, 02 Aug 2012 23:13:49 +0200
Message-ID: <877gtht2sy.fsf@rho.meyering.net>
References: <CAHpGcM+DkL_CCisCjF9m0j3NRJUNAdfL05T0cfLjLfVORQHrpw@mail.gmail.com>
	<7v8vdyfqa9.fsf@alter.siamese.dyndns.org>
	<CAHpGcML5PVAgd9x75=5k1-ev+Px4V+26KJhhyZk-O54p0WxfxQ@mail.gmail.com>
	<501AEC59.7010907@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: bug-diffutils-mXXj517/zsQ@public.gmane.org,
	Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, bug-patch-mXXj517/zsQ@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Eggert <eggert-764C0pRuGfqVc3sceRu5cw@public.gmane.org>
X-From: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org Thu Aug 02 23:13:59 2012
Return-path: <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>
Envelope-to: gcgpb-bug-patch@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1Sx2iS-0002i8-St
	for gcgpb-bug-patch@m.gmane.org; Thu, 02 Aug 2012 23:13:57 +0200
Received: from localhost ([::1]:60840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1Sx2iS-0001Ds-5w
	for gcgpb-bug-patch@m.gmane.org; Thu, 02 Aug 2012 17:13:56 -0400
Received: from eggs.gnu.org ([208.118.235.92]:50575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jim-Oxw1nKZkIVjk1uMJSBkQmQ@public.gmane.org>) id 1Sx2iP-0001Cl-OI
	for bug-patch-mXXj517/zsQ@public.gmane.org; Thu, 02 Aug 2012 17:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jim-Oxw1nKZkIVjk1uMJSBkQmQ@public.gmane.org>) id 1Sx2iO-0007yF-OT
	for bug-patch-mXXj517/zsQ@public.gmane.org; Thu, 02 Aug 2012 17:13:53 -0400
Received: from mx.meyering.net ([88.168.87.75]:47617)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jim-Oxw1nKZkIVjk1uMJSBkQmQ@public.gmane.org>)
	id 1Sx2iM-0007xN-Pa; Thu, 02 Aug 2012 17:13:50 -0400
Received: from rho.meyering.net (rho.meyering.net [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 439A5600AE;
	Thu,  2 Aug 2012 23:13:49 +0200 (CEST)
In-Reply-To: <501AEC59.7010907-764C0pRuGfqVc3sceRu5cw@public.gmane.org> (Paul Eggert's message of "Thu, 02
	Aug 2012 14:08:41 -0700")
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 88.168.87.75
X-BeenThere: bug-patch-mXXj517/zsQ@public.gmane.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: "Bug reports, suggestions,
	general discussion for GNU patch." <bug-patch.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-patch>,
	<mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-patch>
List-Post: <mailto:bug-patch-mXXj517/zsQ@public.gmane.org>
List-Help: <mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-patch>,
	<mailto:bug-patch-request-mXXj517/zsQ@public.gmane.org?subject=subscribe>
Errors-To: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org
Sender: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202792>

Paul Eggert wrote:
> On 08/02/2012 01:02 PM, Andreas Gr=FCnbacher wrote:
>> Paul and Jim, any thoughts about adding filename quoting to GNU diff any=
time
>> soon, or about the format?
>
> The git format looks OK.  I don't have time right now to add it to GNU di=
ff, tho.

I agree, and have no more free time for the task than Paul does.
Would someone care to contribute a complete patch?
