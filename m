From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/14] misc test-suite patches
Date: Sat, 18 Dec 2010 20:08:48 +0000
Message-ID: <4D0D14D0.5020809@ramsay1.demon.co.uk>
References: <4D07B4C1.2050007@ramsay1.demon.co.uk> <7v4oagt9zu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 23:09:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4yD-00063k-KY
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 23:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab0LRWJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 17:09:27 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:43295 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943Ab0LRWJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 17:09:26 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PU4xx-0000of-b1; Sat, 18 Dec 2010 22:09:25 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v4oagt9zu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163939>

Junio C Hamano wrote:
>> [PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
>> [PATCH 09/14] t1301-*.sh: Fix the 'forced modes' test on cygwin
> 
> I sense that there is something fundamentally wrong with the tricky l/stat
> emulation set-up code there, but I lack an expertise to judge if these two
> patches is going in the right direction.  Help from people savvier on
> Windows issues than I is very much appreciated.

Just as a matter of interest, since I put some extra effort into writing
them, did you find the commit messages to be insufficient/unhelpful/confusing?
What could I have done better?

ATB,
Ramsay Jones
