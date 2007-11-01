From: Sergei Organov <osv@javad.com>
Subject: Re: Where man git-format-patch sends me?
Date: Thu, 01 Nov 2007 18:47:42 +0300
Message-ID: <877il22cip.fsf@osv.gnss.ru>
References: <87lk9i2hkc.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711011437440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 16:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IncI7-0005Bq-Lh
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 16:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757764AbXKAPry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbXKAPrx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 11:47:53 -0400
Received: from javad.com ([216.122.176.236]:2338 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbXKAPrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 11:47:52 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA1Flmm62636;
	Thu, 1 Nov 2007 15:47:48 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IncGk-00037Q-KL; Thu, 01 Nov 2007 18:47:42 +0300
In-Reply-To: <Pine.LNX.4.64.0711011437440.4362@racer.site> (Johannes Schindelin's message of "Thu\, 1 Nov 2007 14\:38\:41 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62976>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 1 Nov 2007, Sergei Organov wrote:
>
>> $ man git-format-patch
>> [...]
>> OPTIONS
>>        -p     Generate patch (see section on generating patches)
>> 
>>        -u     Synonym for "-p".
>
> As you can easily see from Documentation/git-format-patch.txt, this part 
> is generated from the file Documentation/diff-options.txt.

Sorry, I did saw that, but it doesn't change anything.

1. As a user reading man git-format-patch, where do I find this "section
   on generating patches"? In another man-page? In the html
   documentation? On the moon?

2. I can't find "section on generating patches" in the man git-diff
   either, and I did say this in the part of my original message you've
   snipped.

So the main question remains: could you please point me to the exact
place in 'Documentation/' directory where this "section on generating
patches" resides?

-- 
Sergei.
