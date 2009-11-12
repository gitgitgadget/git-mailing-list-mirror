From: =?UTF-8?B?THXDrXMgU291c2E=?= <llsousa@ualg.pt>
Subject: Re: Idea for git-touch
Date: Thu, 12 Nov 2009 17:05:21 +0000
Message-ID: <4AFC4051.5030607@ualg.pt>
References: <4AFC348B.4000202@ualg.pt> <20091112180132.5819f963@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 18:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8d7O-0006bD-GW
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZKLRFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 12:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbZKLRFg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:05:36 -0500
Received: from smtp3.ualg.pt ([193.136.224.6]:33196 "EHLO smtp3.ualg.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbZKLRFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 12:05:35 -0500
Received: from localhost (smtp3.ualg.pt [127.0.0.1])
	by smtp3.ualg.pt (Postfix) with ESMTP id 326071683B
	for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:05:40 +0000 (WET)
Received: from smtp3.ualg.pt ([127.0.0.1])
 by localhost (host.domain.tld [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 01704-05 for <git@vger.kernel.org>;
 Thu, 12 Nov 2009 17:05:39 +0000 (WET)
Received: from [193.136.224.174] (unknown [193.136.224.174])
	by smtp3.ualg.pt (Postfix) with ESMTP id 0AB8816739
	for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:05:38 +0000 (WET)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20091112180132.5819f963@perceptron>
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132785>

But still preserves the original date, isn't it?

Jan Kr=C3=BCger wrote:
> Hi Lu=C3=ADs,
>
>  =20
>> [...] Then I do a git-reset HEAD~1, git-add . and git-commit with
>> the same message to have the current date.
>>    =20
>
> There is an existing command that does pretty much exactly that:
> git commit --amend.
>
> Jan
>
>
>  =20
