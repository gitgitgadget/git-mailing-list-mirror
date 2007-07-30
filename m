From: david@lang.hm
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:33:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707301013210.11330@asgard.lang.hm>
References: <104942.93033.qm@web51008.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFZ8i-0004Ho-S8
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933421AbXG3ReF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761737AbXG3ReE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 13:34:04 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:49377
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420AbXG3ReB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 13:34:01 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6UHXw75019609;
	Mon, 30 Jul 2007 10:33:58 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <104942.93033.qm@web51008.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54244>

On Mon, 30 Jul 2007, Matthew L Foster wrote:

> --- david@lang.hm wrote:
>
>> On Mon, 30 Jul 2007, Matthew L Foster wrote:
>>> Local commit order is stored locally right?
>>
>> not normally. you could enable reflogs and then mine through the reflogs
>> to find the info, but it's not stored in any easy to access fashion.
>
> Local merge order can be extracted from git?

if you have reflogs enabled on your copy of the git repository then you 
can look at when things were merged into your copy.

David Lang
