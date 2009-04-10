From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: legend on top-right pane in 'git gui'
Date: Fri, 10 Apr 2009 19:19:16 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngtv6tk.7aq.sitaramc@sitaramc.homelinux.net>
References: <slrngt4h04.q0l.sitaramc@sitaramc.homelinux.net>
 <slrngtqr13.566.sitaramc@sitaramc.homelinux.net>
 <885649360904082111q31f1d90br8ee62eb4afba2611@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 21:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsMHh-0001ZU-KT
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 21:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762726AbZDJTTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760593AbZDJTTb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 15:19:31 -0400
Received: from main.gmane.org ([80.91.229.2]:43778 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759150AbZDJTTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 15:19:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LsMG7-0006Rv-NR
	for git@vger.kernel.org; Fri, 10 Apr 2009 19:19:27 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 19:19:27 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 19:19:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116277>

On 2009-04-09, James Pickens <jepicken@gmail.com> wrote:
> On Wed, Apr 8, 2009, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> Can someone at least tell me "Sita, you're wrong/this is a
>> stupid question/this is perfectly correct behaviour/whatever"?  :-)
>>
>> I won't even ask why, I promise :-)
>
> Well, I for one think your proposed new message - "untracked, not
> staged (partial)" - is nonsense.  A file can't be both untracked
> and partially staged.

Fine, some other wording may suit better; doesn't matter if
you don't even agree that the message needs to be different.

> Also I don't agree that the message needs to be different
> depending on where you click; actually I think such behavior
> would be more confusing to users than the current behavior.

Right now, both panes say "Portions staged for commit".

In fact, while one pane does indeed show the portions staged
for commit, the other one is actually showing portions *not*
staged for commit.  To some of my users, that is certainly
confusing.

I guess confusion, like beauty, is in the eyes of the
beholder...
