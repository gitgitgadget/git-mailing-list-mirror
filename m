From: DeMarcus <demarcus@hotmail.com>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Mon, 19 Dec 2011 22:46:29 +0100
Message-ID: <jcobbo$jab$1@dough.gmane.org>
References: <jcki8u$oip$1@dough.gmane.org> <84ty4ycdcc.fsf@cenderis.demon.co.uk> <jckvpk$i8v$1@dough.gmane.org> <4EEF736A.4070802@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 22:50:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcl68-0000Lr-IW
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab1LSVuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 16:50:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:53659 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab1LSVuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 16:50:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rcl5y-0000IZ-Pf
	for git@vger.kernel.org; Mon, 19 Dec 2011 22:50:06 +0100
Received: from c83-251-142-66.bredband.comhem.se ([83.251.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 22:50:06 +0100
Received: from demarcus by c83-251-142-66.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 22:50:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c83-251-142-66.bredband.comhem.se
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EEF736A.4070802@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187478>

On 2011-12-19 18:24, Holger Hellmuth wrote:
> On 18.12.2011 16:10, DeMarcus wrote:
>>> You probably don't want to use stash. Just commit whatever partial work
>>> you've done.
>>>
>>
>> It feels strange doing a commit of partial work. Some of the files may
>> not even be supposed to be checked in.
>
> You have heard of "git commit --amend" ? Makes partial commits really
> easy to work with.
>
>

Yes, I know that one. It's just that I know myself, I don't really like 
to go back rearranging. I prefer to keep things spread out at first and 
then inserted properly when it's time. But maybe I'm just unused to the 
git workflow.
