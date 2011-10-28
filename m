From: Gelonida N <gelonida@gmail.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 22:21:15 +0200
Message-ID: <j8f2rr$ghe$1@dough.gmane.org>
References: <j8clg9$ldh$1@dough.gmane.org>	<7vfwiexe6m.fsf@alter.siamese.dyndns.org>	<7v8vo6xd4u.fsf@alter.siamese.dyndns.org>	<buoty6t9937.fsf@dhlpc061.dev.necel.com>	<7vvcr9wyje.fsf@alter.siamese.dyndns.org>	<j8ds01$fc7$1@dough.gmane.org> <m31utx5js7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 22:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJsvm-0006IH-4K
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 22:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab1J1UV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 16:21:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:36565 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab1J1UV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 16:21:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJsvf-0006GF-P2
	for git@vger.kernel.org; Fri, 28 Oct 2011 22:21:27 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:21:27 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:21:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <m31utx5js7.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184429>

On 10/28/2011 03:27 PM, Jakub Narebski wrote:
> Gelonida N <gelonida@gmail.com> writes:
> 
> [...]
> 
>> Another small detail:
>>
>> Let's assume I have following alias:
>>
>> log = log --name-status
>>
>>
>> In this case I directly get the help text for git log
>> if I typed 'git log --help' (or 'git help log').
>> I don't even see, that my log is in reality aliased.
> 
> That is because it doesn't work: git does not allow for aliasing its
> built-in commands.


Well this explains why.
Thanks
