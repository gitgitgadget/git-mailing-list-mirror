From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 14:51:48 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmujc4.sf.sitaramc@sitaramc.homelinux.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
 <alpine.DEB.1.00.0901151429440.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 15:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTb7-0005jB-5R
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765685AbZAOOwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765567AbZAOOwE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:52:04 -0500
Received: from main.gmane.org ([80.91.229.2]:60120 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765167AbZAOOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:52:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LNTZd-0002co-JX
	for git@vger.kernel.org; Thu, 15 Jan 2009 14:51:57 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:51:57 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:51:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105825>

On 2009-01-15, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I turned this into a proper test case (to show what would be most helpful 
> if you report bugs like this in the future).

Thanks.  I'll keep that in mind.

What is the significance of test_tick?  I can see what it is
doing, but am trying to understand why.

Regards,

Sitaram
