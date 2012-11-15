From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Thu, 15 Nov 2012 19:05:20 +0000
Message-ID: <50A53CF0.7040809@ramsay1.demon.co.uk>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, mlevedahl@gmail.com, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ51W-0006U4-Ck
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 20:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768763Ab2KOTWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 14:22:37 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:39484 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768727Ab2KOTWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 14:22:35 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 8D317A648D5;
	Thu, 15 Nov 2012 19:22:34 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id ECD20A648C3;	Thu, 15 Nov 2012 19:22:33 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Thu, 15 Nov 2012 19:22:32 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <50A2B14C.9040608@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209841>

Torsten B=C3=B6gershausen wrote:
>> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
>>  - Update cygwin.c for new mingw-64 win32 api headers
>>
>>  Make git work on newer cygwin.
>>
>>  Will merge to 'next'.
>=20
> (Sorry for late answer, I managed to test the original patch minutes =
before Peff merged it to pu)
> (And thanks for maintaining git)
>=20
> Is everybody using cygwin happy with this?

I am still on cygwin 1.5.22 and quite happy that this patch does
not (seem) to cause any problems. ;-P

> I managed to compile on a fresh installed cygwin,
> but failed to compile under 1.7.7, see below.
> Is there a way we can achieve to compile git both under "old" and "ne=
w" cygwin 1.7 ?
> Or is this not worth the effort?

Did the cygwin project not bump an api version number somewhere?

ATB,
Ramsay Jones
