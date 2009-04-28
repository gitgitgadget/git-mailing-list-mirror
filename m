From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: (topgit question) deleting a dependency
Date: Tue, 28 Apr 2009 15:41:22 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngve8t2.is7.sitaramc@sitaramc.homelinux.net>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
 <20090428094138.GB9415@piper.oerlikon.madduck.net>
 <slrngve3mf.f45.sitaramc@sitaramc.homelinux.net>
 <20090428150753.GB30582@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 17:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LypRx-0000M3-Ix
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980AbZD1Plg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbZD1Plg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:41:36 -0400
Received: from main.gmane.org ([80.91.229.2]:55531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736AbZD1Plf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:41:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LypR8-00015Q-F2
	for git@vger.kernel.org; Tue, 28 Apr 2009 15:41:35 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 15:41:34 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 15:41:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117794>

On 2009-04-28, martin f krafft <madduck@madduck.net> wrote:

> also sprach Sitaram Chamarty <sitaramc@gmail.com> [2009.04.28.1612 +0200]:
>> When one branch is deemed to be cooked, a "tg export" takes
>> that code to master, and I intend to delete t/all and create
>> it afresh with the rest of the dependencies (the old set
>> minus the one that finished cooking).
>
> Are any of the t/* branches ever used by anyone else but you? Are
> they published?

No to both questions.  Sorry I should have mentioned that
earlier :-)
