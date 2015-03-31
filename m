From: David Lang <david@lang.hm>
Subject: Re: VCS popularity
Date: Tue, 31 Mar 2015 16:18:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1503311615430.26359@nftneq.ynat.uz>
References: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com> <xmqq7ftwq06b.fsf@gitster.dls.corp.google.com> <CAA787rnbZGv_5rmVK1MLmCMLx9vpubW87hM4XK8U65i7FDZAiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-626721421-1427843906=:26359"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:18:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5QZ-0008L1-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbbCaXSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:18:31 -0400
Received: from mail.lang.hm ([64.81.33.126]:56813 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbbCaXSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:18:30 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t2VNIQ7p023930;
	Tue, 31 Mar 2015 15:18:26 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAA787rnbZGv_5rmVK1MLmCMLx9vpubW87hM4XK8U65i7FDZAiA@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266580>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-626721421-1427843906=:26359
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 1 Apr 2015, Øyvind A. Holm wrote:

> On 1 April 2015 at 00:20, Junio C Hamano <gitster@pobox.com> wrote:
>> Øyvind A. Holm <sunny@sunbase.org> writes:
>>> The graphs are pretty interesting:
>>>
>>> https://github.com/sunny256/openhub-repositories/blob/master/graph/relative.svg
>>>   Graphs of relative growth between the various version control systems.
>>
>> This plots us at a bit over 8000.
>>
>> What does this number mean, exactly?  Since 2014-08-01, the number of Git
>> repositories Ohloh knows about has grown 8000-fold?  Or is it just 80-fold
>> (8000%) growth?  Or 8000 more repositories were created?
>
> Yes, relative.svg and relative-zoom.svg show the number of new repositories
> found by Open Hub. To be specific, these are the numbers:
>
> Bazaar: 75
> CVS: 59
> Git: 8230
> Mercurial: 215
> Subversion: 607
>
> These numbers can of course be discussed, but as a source, I believe Open Hub
> should be one of the more objective ones.

How many of these 8230 git repositories are duplicates of each other on github 
(to pick a specific example).

the distributed nature of DVCS systems is going to inflate their count vs 
non-distributed VCS systems where there is only one copy.

I believe that Git encourages making personal copies public more than Mercurial 
does (with github being the extreme case)

David Lang
--680960-626721421-1427843906=:26359--
