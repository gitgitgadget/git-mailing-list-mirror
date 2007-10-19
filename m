From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH resend again] gitk: Do not pick up file names of "copy from" lines
Date: Fri, 19 Oct 2007 04:14:28 -0400
Message-ID: <20071019081428.GP14735@spearce.org>
References: <20071019052823.GI14735@spearce.org> <47185BCC.9010307@viscovery.net> <20071019073253.GM14735@spearce.org> <47186563.3070607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iin0J-0006ZQ-9H
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765015AbXJSIOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765007AbXJSIOf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:14:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51918 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbXJSIOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:14:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iin00-0007Em-Ct; Fri, 19 Oct 2007 04:14:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A734D20FBAE; Fri, 19 Oct 2007 04:14:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47186563.3070607@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61671>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> >I think it is already in Paul's repo:
> 
> No, it's not. I checked both Paul's master and dev, and also your own
> gitk branch. Would you mind cherry-picking from the tip of
> 
> git://repo.or.cz/git/mingw.git mob

Picked. Its now in spearce/gitk.

-- 
Shawn.
