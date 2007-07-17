From: david@lang.hm
Subject: Re: Do a better job at guessing unknown character sets
Date: Tue, 17 Jul 2007 13:01:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707171257420.2467@asgard.lang.hm>
References: <alpine.LFD.0.999.0707171027100.19166@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707172053030.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 22:08:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAtKw-0002i2-Qs
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbXGQUHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbXGQUHz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:07:55 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:36348
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXGQUHy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 16:07:54 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6HK7eop019736;
	Tue, 17 Jul 2007 13:07:40 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <Pine.LNX.4.64.0707172053030.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52794>

On Tue, 17 Jul 2007, Johannes Schindelin wrote:

> On Tue, 17 Jul 2007, Linus Torvalds wrote:
>
>> I think this makes sense from a "the world is moving to utf-8"
>> standpoint, even if obviously some people might consider it a bit ugly
>> to do per-line "guessing".
>>
>> Comments?
>
> Encodings are such a hassle, and probably
> only because the inventors of ASCII just were narrow-minded enough not to
> care.

to be perfectly fair, at the time ASCII was invented it was done to 
eliminate the use of the different, incompatible character sets that were 
in use at the time. And it did the job well (I think the only surviver 
from those sets is EBCDIC, and only due to the legacy installed base)

current character encodings are doing things that weren't dreamed of by 
anyone at the time.

David Lang
