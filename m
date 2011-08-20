From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Sat, 20 Aug 2011 22:11:30 +0100
Message-ID: <4E502302.4000300@ramsay1.demon.co.uk>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org> <4E4D7DD3.2000701@obry.net> <7vhb5e73hy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pascal@obry.net, git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 19:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvuaB-0007Oq-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 19:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1HWRQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 13:16:05 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:33928 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754156Ab1HWRQD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 13:16:03 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Qvua1-0007PF-ZV; Tue, 23 Aug 2011 17:16:01 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vhb5e73hy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179952>

Junio C Hamano wrote:
> Pascal Obry <pascal@obry.net> writes:
> 
>> Junio,
>>
>>> * po/cygwin-backslash (2011-08-05) 2 commits
>>>   - On Cygwin support both UNIX and DOS style path-names
>>>   - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep
>>>
>>> I think a further refactoring (no, not my suggestion) was offered?
>> I think the current patchset is fine. It is always possible to improve
>> things but the current patch goes in the right direction. So to me it
>> is ready as-is.
> 
> Not very assuring to hear that only from the original submitter, no?

Commit 704c335 (On Cygwin support both UNIX and DOS style path-names,
05-08-2011) in pu needs an update to fix the commit message.

Also, I didn't see any response to Johannes Sixt's query concerning
backslash in pathspec. (I personally don't want to go down that
route, but ...)

ATB,
Ramsay Jones
