From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 02:46:11 +0200
Organization: www.grml.org
Message-ID: <feud8j$kdg$1@ger.gmane.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home>
Cc: make-w32@gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 03:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhEwT-0006jp-MY
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 03:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbXJOBkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 21:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXJOBkP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 21:40:15 -0400
Received: from main.gmane.org ([80.91.229.2]:57528 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbXJOBkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 21:40:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IhEw7-0001PC-If
	for git@vger.kernel.org; Mon, 15 Oct 2007 01:40:05 +0000
Received: from 83-65-235-226.dynamic.xdsl-line.inode.at ([83.65.235.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 01:40:03 +0000
Received: from gebi by 83-65-235-226.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 01:40:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 83-65-235-226.dynamic.xdsl-line.inode.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60935>

["Followup-To:" header set to gmane.comp.version-control.git.]

> - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
>   can be not the same, depending on what current "drive" is) and
>   multi-cwd, which hasn't had formed itself into a problem yet, but
>   surely will

Thats true for linux too.
/a/b/c and /a/b/c can be 2 totally different files depending on the vfs
namespace you are one.

cu,
michael
-- 
It's already too late!
