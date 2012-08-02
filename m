From: Paul Eggert <eggert-764C0pRuGfqVc3sceRu5cw@public.gmane.org>
Subject: Re: GNU patch close to next stable release (2)
Date: Thu, 02 Aug 2012 14:08:41 -0700
Organization: UCLA Computer Science Department
Message-ID: <501AEC59.7010907@cs.ucla.edu>
References: <CAHpGcM+DkL_CCisCjF9m0j3NRJUNAdfL05T0cfLjLfVORQHrpw@mail.gmail.com>
	<7v8vdyfqa9.fsf@alter.siamese.dyndns.org>
	<CAHpGcML5PVAgd9x75=5k1-ev+Px4V+26KJhhyZk-O54p0WxfxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: bug-diffutils-mXXj517/zsQ@public.gmane.org, Jim Meyering <meyering-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	bug-patch-mXXj517/zsQ@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: =?UTF-8?B?QW5kcmVhcyBHcsO8bmJhY2hlcg==?=
 <andreas.gruenbacher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org Thu Aug 02 23:08:49 2012
Return-path: <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>
Envelope-to: gcgpb-bug-patch@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1Sx2dT-0000WN-UM
	for gcgpb-bug-patch@m.gmane.org; Thu, 02 Aug 2012 23:08:48 +0200
Received: from localhost ([::1]:59691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-patch-bounces+gcgpb-bug-patch=m.gmane.org-mXXj517/zsQ@public.gmane.org>)
	id 1Sx2dT-00087a-6x
	for gcgpb-bug-patch@m.gmane.org; Thu, 02 Aug 2012 17:08:47 -0400
Received: from eggs.gnu.org ([208.118.235.92]:49938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eggert-764C0pRuGfqVc3sceRu5cw@public.gmane.org>) id 1Sx2dR-000867-3B
	for bug-patch-mXXj517/zsQ@public.gmane.org; Thu, 02 Aug 2012 17:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eggert-764C0pRuGfqVc3sceRu5cw@public.gmane.org>) id 1Sx2dQ-00057m-9a
	for bug-patch-mXXj517/zsQ@public.gmane.org; Thu, 02 Aug 2012 17:08:45 -0400
Received: from smtp.cs.ucla.edu ([131.179.128.62]:53828)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eggert-764C0pRuGfqVc3sceRu5cw@public.gmane.org>)
	id 1Sx2dO-00056j-Dq; Thu, 02 Aug 2012 17:08:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.cs.ucla.edu (Postfix) with ESMTP id B2287A60009;
	Thu,  2 Aug 2012 14:08:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at smtp.cs.ucla.edu
Received: from smtp.cs.ucla.edu ([127.0.0.1])
	by localhost (smtp.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnzNeATYyr9X; Thu,  2 Aug 2012 14:08:40 -0700 (PDT)
Received: from [192.168.1.4] (pool-108-23-119-2.lsanca.fios.verizon.net
	[108.23.119.2])
	by smtp.cs.ucla.edu (Postfix) with ESMTPSA id 54EEBA60007;
	Thu,  2 Aug 2012 14:08:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <CAHpGcML5PVAgd9x75=5k1-ev+Px4V+26KJhhyZk-O54p0WxfxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6 (newer, 3)
X-Received-From: 131.179.128.62
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202791>

On 08/02/2012 01:02 PM, Andreas Gr=C3=BCnbacher wrote:
> Paul and Jim, any thoughts about adding filename quoting to GNU diff an=
ytime
> soon, or about the format?

The git format looks OK.  I don't have time right now to add it to GNU di=
ff, tho.
