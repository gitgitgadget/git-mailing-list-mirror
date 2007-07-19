From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 14:01:57 +0200
Message-ID: <86ir8gbo0a.fsf@lola.quinscape.zz>
References: <20070719104351.GA17182@midwinter.com> <20070719110224.GA4293@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707191211010.14781@racer.site> <Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 14:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBUhx-0000qH-Cw
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbXGSMCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbXGSMCI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:02:08 -0400
Received: from main.gmane.org ([80.91.229.2]:59281 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756486AbXGSMCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:02:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBUhp-0001Wc-GT
	for git@vger.kernel.org; Thu, 19 Jul 2007 14:02:05 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:02:05 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:02:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:JfTD5j49nhnl2b/nwf7xz8MPQbM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52976>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Thu, 19 Jul 2007, Johannes Schindelin wrote:
>
>> Hi,
>>
>> On Thu, 19 Jul 2007, martin f krafft wrote:
>>
>>> [...] I also wonder why use of a pager is default in git anyway. At
>>> least I find it to be contrary to what I am used to on the Unix command
>>> line.
>>
>> It was evidently liked unilaterally amongst the big whigs in the git
>> community.  Me too, I like it (which says nothing about my hair style).
>> Often it annoys me tremendously that all the other programs like make, ls,
>> etc. do not have this nice "-p" flag.
>
> I love it. It's currently playing merry havoc with my Subversion usage
> at work though.  I've got so used to git never chucking things off the
> top of the screen that I keep forgetting to run 'svn ... | less'.
>
> Also searching in a console isn't anywhere near as easy.

Is that the reason why users of screen get punished by default?

-- 
David Kastrup
