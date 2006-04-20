From: Jon Loeliger <jdl@freescale.com>
Subject: Re: n-heads and patch dependency chains
Date: Thu, 20 Apr 2006 13:08:25 -0500
Message-ID: <1145556505.5314.149.camel@cashmere.sps.mot.com>
References: <4430D352.4010707@vilain.net>
	 <7vsloucuxk.fsf@assigned-by-dhcp.cox.net> <4431B60E.3030008@vilain.net>
	 <44323C52.2030803@op5.se> <e0tjpk$ktu$1@sea.gmane.org>
	 <44325CDB.2000101@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 20:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWddO-0002nJ-EY
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 20:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWDTSMD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 14:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDTSMD
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 14:12:03 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:54182 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751216AbWDTSMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 14:12:01 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k3KIR4gA006243;
	Thu, 20 Apr 2006 11:27:04 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k3KIMxRs010030;
	Thu, 20 Apr 2006 13:23:00 -0500 (CDT)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44325CDB.2000101@op5.se>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18987>

On Tue, 2006-04-04 at 06:47, Andreas Ericsson wrote:

> No, I mean that this would commit both to the testing branch (being the 
> result of several merged topic-branches) and to the topic-branch merged 
> in. Commit as in regular commit, with a commit-message and a patch. The 
> resulting repository would be the exact same as if the change was 
> committed only to the topic-branch and then cherry-picked on to the 
> testing-branch.

I am your number one fan!  If I finish reading these 600+
messages, will I find out you have already implemented it,
it's committed, and you just need me to test it now? :-)

jdl
