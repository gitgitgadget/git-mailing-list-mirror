From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we allow -t abbreviation for --track in 'git branch'
Date: Sun, 10 May 2009 04:23:27 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh0cllu.juu.sitaramc@sitaramc.homelinux.net>
References: <slrnh0agtv.4rv.sitaramc@sitaramc.homelinux.net>
 <7vab5m9ujb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 06:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M30Zr-0004Gy-CN
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 06:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbZEJEXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 00:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbZEJEXo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 00:23:44 -0400
Received: from main.gmane.org ([80.91.229.2]:55537 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbZEJEXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 00:23:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M30Ze-0003pJ-H8
	for git@vger.kernel.org; Sun, 10 May 2009 04:23:38 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 May 2009 04:23:38 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 May 2009 04:23:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118702>

On 2009-05-09, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Would it make sense to teach "git branch" the short option
>> "-t" the same way that "git checkout" knows it, (ie., as an
>> abbreviation for "--track")?
>>
>> I use both frequently, and often forget that in "git branch"
>> the short option does not work.
>>
>> If people think it's OK I'll submit a patch (code and doc).
>
> I have <20090428152119.GA18935@atc.tcs.com> (aka $gmane/117790) in my
> inbox.

Thanks.  I posted it some days ago, but then began to wonder
if there was more to that change than I thought, and perhaps
I should have *asked* first.

Sitaram

PS: And I saw http://gitster.livejournal.com/33638.html only
just now... :-)
