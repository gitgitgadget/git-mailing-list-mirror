From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 10:17:33 +0100
Message-ID: <535E1CAD.1020304@game-point.net>
References: <535C47BF.2070805@game-point.net> <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com> <535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535D6EB1.9080208@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:17:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wehgr-0007zD-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbaD1JR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:17:29 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:34800 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbaD1JR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:17:29 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 818C118A09AC;
	Mon, 28 Apr 2014 04:25:17 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <535e18cdc7bce_338911e930c72@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247261>

On 28/04/2014 10:01, Felipe Contreras wrote:
> Jeremy Morton wrote:
>> On 27/04/2014 20:33, Johan Herland wrote:
>>> The problem is not really "less tidy commit trees" - by which I gather
>>> you mean history graphs that are non-linear. IMHO, the history graph
>>> should reflect parallel/branched development when that is useful.
>>> Blindly rebasing everything into a single line is IMHO just as bad as
>>> doing all your work directly on master and blindly running "git pull"
>>> between each of your own commits (which results in a lot of useless
>>> merges). The merge commits themselves are not the problem. Merge
>>> commits are a tool, and when used properly (to introduce topics to the
>>> master branch like described above) they are a good tool. When abused
>>> (like blindly running "git pull" and accepting useless "merge
>>> bubbles") they create more problems than they solve.
>>
>> Sounds like the default behaviour of "git pull" might not be ideal if it
>> easily causes these problems.
>
> It's not idea. Virtually everyone agrees with that, even Linus Torvalds, and we
> have the patches to fix it, but it's not going to change.
>
> The Git project doesn't welcome change.

Well, you sure don't seem to.  Why are there so many "no-can-do" people 
on this list?  :-)

-- 
Best regards,
Jeremy Morton (Jez)
