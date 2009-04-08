From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Showing the version of a file that's in the Index.
Date: Wed, 08 Apr 2009 08:00:36 +0300
Message-ID: <87y6ubvix7.fsf@iki.fi>
References: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com>
	<200904072210.05591.markus.heidelberg@web.de> <874ox0w7ak.fsf@iki.fi>
	<200904072357.47881.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Apr 08 07:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrPvT-0001zE-25
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 07:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbZDHFAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZDHFAm
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 01:00:42 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:37504 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbZDHFAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 01:00:41 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 49CA1EE500986A22; Wed, 8 Apr 2009 08:00:36 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LrPts-0007yg-6v; Wed, 08 Apr 2009 08:00:36 +0300
In-Reply-To: <200904072357.47881.markus.heidelberg@web.de> (Markus Heidelberg's message of "Tue\, 7 Apr 2009 23\:57\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116034>

On 2009-04-07 23:57 (+0200), Markus Heidelberg wrote:

> Teemu Likonen, 07.04.2009:
>> Or
>> 
>>     git show :file
>
> Huh, I use git-show daily for commits, but I completely forgot about it
> for files when replying.

It's nice for trees too:

    git show HEAD~3:
    git show master~1:directory/
