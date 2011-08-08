From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Mon, 08 Aug 2011 09:37:51 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <878vr46kao.fsf@lifelogs.com>
References: <20110718074642.GA11678@sigill.intra.peff.net>
	<20110718075232.GJ12341@sigill.intra.peff.net>
	<7vr55k4mxn.fsf@alter.siamese.dyndns.org>
	<20110722204749.GC11922@sigill.intra.peff.net>
	<7vbowmx9da.fsf@alter.siamese.dyndns.org>
	<20110722221337.GA15753@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 16:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqQy7-0000MT-A6
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 16:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1HHOiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 10:38:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:57887 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab1HHOiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 10:38:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QqQxx-0000Gu-Ey
	for git@vger.kernel.org; Mon, 08 Aug 2011 16:38:05 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 16:38:05 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 16:38:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:ExQskF2EJHRFKKRXyCTXjHuFd0g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178958>

On Fri, 22 Jul 2011 16:13:38 -0600 Jeff King <peff@peff.net> wrote: 

JK> I admit I don't have any data beyond my own experiences. GitHub tends
JK> towards the concept of a single identity, and it has some group
JK> management. I don't know about other sites, though. Do you have any
JK> specific examples in mind?

I have not yet needed multiple user names on a single Git server, so I
think it's OK to make that case less convenient to favor the more common
single user name case.

Ted
