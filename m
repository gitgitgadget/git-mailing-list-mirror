From: David Kastrup <dak@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 14:59:30 +0200
Message-ID: <86odezjjv1.fsf@lola.quinscape.zz>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org> <Pine.LNX.4.64.0710161324490.25221@racer.site> <E1IhlvV-0002qv-1K@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 15:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmCx-0003EY-6s
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbXJPNL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbXJPNL3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:11:29 -0400
Received: from main.gmane.org ([80.91.229.2]:49731 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757337AbXJPNL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:11:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ihm8X-0006Zg-Gd
	for git@vger.kernel.org; Tue, 16 Oct 2007 13:07:05 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 13:07:05 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 13:07:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:xefHx/I6X87tFDHkSnAz0sIXq3k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61163>

Eli Zaretskii <eliz@gnu.org> writes:

>> Date: Tue, 16 Oct 2007 13:29:41 +0100 (BST)
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> 
>> On Linux, I would have hit Control-C already.  Such an operation
>> typically takes less than 0.1 seconds.
>
> We were not comparing Linux with Windows, we were talking about
> Windows user experience.  On Windows 4 seconds is not too long.

If it is accompanied by some animation of papers winging across the
screen or a progress bar or similar.  Otherwise people might think
that Windows crashed and reboot.

Anyway, the problem is that 4 seconds for 32K files means 40 seconds
(at least) for 320K files.  At some point of time, things become
really unpleasant.

-- 
David Kastrup
