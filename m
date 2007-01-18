From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 03:06:13 -0500
Message-ID: <20070118080613.GE23124@spearce.org>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> <87ps9d7j6t.fsf@morpheus.local> <7vejptsglj.fsf@assigned-by-dhcp.cox.net> <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net> <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Josh Boyer <jwboyer@gmail.com>,
	git@vger.kernel.org, davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 09:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7SHt-0006jB-L0
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 09:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXARIGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 03:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXARIGT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 03:06:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37521 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbXARIGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 03:06:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7SHm-0004nU-GA; Thu, 18 Jan 2007 03:06:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A4E720FBAE; Thu, 18 Jan 2007 03:06:13 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37065>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Also, how many mail clients know that .patch is actually
> a text and not application/binary? It'll make patch
> reviewing harder for some (not sure if I'd like a review
> of such a person, though).

Patches intended for review should be sent inline, not attached.
Thus the file extension has no impact on how the mail client should
treat it.

Don't count people out just because they cannot read a *.patch file
All constructive feedback is valuable, no matter its source.  Of
course I did qualify that with "constructive"... ;-)

-- 
Shawn.
