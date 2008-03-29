From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-archive and submodules
Date: Sat, 29 Mar 2008 09:52:02 -0400
Message-ID: <20080329135202.GR4759@spearce.org>
References: <8ec76080803290647h25e86f18k7a86bc4cb2cc3d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 14:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfbUJ-0005Zf-87
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 14:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYC2NwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 09:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbYC2NwI
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 09:52:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55486 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYC2NwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 09:52:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JfbTT-0003Ns-Cb; Sat, 29 Mar 2008 09:51:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9E96F20FBAE; Sat, 29 Mar 2008 09:52:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8ec76080803290647h25e86f18k7a86bc4cb2cc3d38@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78468>

Whit Armstrong <armstrong.whit@gmail.com> wrote:
> Is there a way to ask git-archive to archive the submodules of the
> project as well?
> 
> I have a project that needs it's submoduels distributed with it.

No.

Patches welcome.  :-)
 
We've talked about supporting it, and wouldn't mind having the
tool do it for exactly the reason you mention, but thus far a
patch has not been written to implement that.

-- 
Shawn.
