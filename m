From: David Kastrup <dak@gnu.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 14:38:09 +0200
Organization: Organization?!?
Message-ID: <8563s9ftce.fsf@lola.goethe.zz>
References: <20080616110113.GA22945@elte.hu> <20080616112709.GG12260@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 14:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8DzP-0001e2-7v
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 14:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbYFPMiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 08:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbYFPMiU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 08:38:20 -0400
Received: from main.gmane.org ([80.91.229.2]:39812 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbYFPMiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 08:38:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K8DyS-0002U3-Jo
	for git@vger.kernel.org; Mon, 16 Jun 2008 12:38:17 +0000
Received: from dslb-084-061-063-029.pools.arcor-ip.net ([84.61.63.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 12:38:16 +0000
Received: from dak by dslb-084-061-063-029.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 12:38:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-063-029.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:eSXJU0RTmCOnO54L1m1qeZEtaBU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85187>

Theodore Tso <tytso@mit.edu> writes:

> On Mon, Jun 16, 2008 at 01:01:13PM +0200, Ingo Molnar wrote:
>>    ( Also, it's a GPL nitpicky issue: the conflict resolution database 
>>      can be argued to be part of "source code" and as such it should be 
>>      shared with everyone who asks. With trivial merges the data is
>>      probably not copyrightable hence probably falls outside the scope 
>>      of the GPL, but with a complex topic tree like -tip with dozens of 
>>      conflict resolutions, the boundary is perhaps more blurred. )
>
> For a more complex merge resolution, granted that it rises to the
> level of being "copyrightable", but I think it would be a huge stretch
> to call the rr-cache the "preferred form for modifications"!  :-)

The GPL just calls for all "corresponding" source code, not all
"interesting" source code.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
