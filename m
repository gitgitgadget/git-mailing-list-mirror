From: Dave Jones <davej@redhat.com>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 15:31:02 -0500
Message-ID: <20060226203102.GI7851@redhat.com>
References: <20060225174047.0e9a6d29.akpm@osdl.org> <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net> <20060225210712.29b30f59.akpm@osdl.org> <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org> <20060226103604.2d97696c.akpm@osdl.org> <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org> <20060226202617.GH7851@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 21:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSY8-0004HG-UR
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWBZUbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBZUbW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:31:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751162AbWBZUbW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 15:31:22 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1QKVHcp000505;
	Sun, 26 Feb 2006 15:31:17 -0500
Received: from nwo.kernelslacker.org (vpn83-121.boston.redhat.com [172.16.83.121])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1QKV6129156;
	Sun, 26 Feb 2006 15:31:07 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k1QKV2pj018603;
	Sun, 26 Feb 2006 15:31:02 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1QKV2EH018602;
	Sun, 26 Feb 2006 15:31:02 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060226202617.GH7851@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16796>

On Sun, Feb 26, 2006 at 03:26:17PM -0500, Dave Jones wrote:

 > in my .vimrc, which highlights this (and other trailing whitespace) as
 > a big red blob.  I do this in part for the same reason Andrew does,
 > so that when someone sends me a diff with a zillion spaces at the EOL,
 > it screams at me, I spot them, and chop them out.

(seconds later, I find my .vimrc on master.k.o hasn't had this turned
 on so I find a billion instances of this mess in agp/cpufreq -- Bah).

		Dave
