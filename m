From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] msvc: Add a definition of NORETURN compatible with
 	msvc compiler
Date: Fri, 22 Jan 2010 19:35:34 +0000
Message-ID: <4B59FE06.5010506@ramsay1.demon.co.uk>
References: <4B575D48.9070508@ramsay1.demon.co.uk> <40aa078e1001201345p1cf9dfbbm651f1ba7244a340f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 22 21:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYPla-0004AQ-Eo
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 21:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0AVUFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487Ab0AVUFv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 15:05:51 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49332 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753372Ab0AVUFv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 15:05:51 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NYPlN-00002h-XY; Fri, 22 Jan 2010 20:05:50 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <40aa078e1001201345p1cf9dfbbm651f1ba7244a340f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137779>

Erik Faye-Lund wrote:
> On Wed, Jan 20, 2010 at 8:45 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> I thought that Erik had already submitted this patch along with
>> those that resulted in commits a4f3131c and 18660bc9. However, I
>> don't seem to be able to find it anywhere! (maybe I only imagined
>> it).
>>
>> If you find Erik's patch, please apply that instead...
> 
> I don't think I ever sent one - I haven't bothered to set up msvc for
> git compilation, so I only did the preparation (and I think I sent a
> comment about how it could be done).

Ah, so maybe it's this comment that I (mis-)remembered then! (yeah, my
memory is not what it used to be ;-)). Thanks for doing the preparation
work!

ATB,
Ramsay Jones
