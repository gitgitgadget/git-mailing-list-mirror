From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 05:25:16 -0500
Message-ID: <20070110102516.GF30765@spearce.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <200701100904.32077.andyparkins@gmail.com> <7vbql7cjk8.fsf@assigned-by-dhcp.cox.net> <200701101010.46269.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 10 11:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ae7-0008MQ-4w
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 11:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbXAJKZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 05:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbXAJKZX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 05:25:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51175 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837AbXAJKZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 05:25:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4adx-0003EM-G8; Wed, 10 Jan 2007 05:25:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 625BF20FBAE; Wed, 10 Jan 2007 05:25:17 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701101010.46269.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36497>

Andy Parkins <andyparkins@gmail.com> wrote:
> Of course I could still be misunderstanding.  If Linus meant "refuse to switch 
> AWAY from a detached HEAD unless the hash of the detached head exactly 
> matches some other ref", I would be less confused.

I believe that's what Linus meant.  As otherwise you are right,
it doesn't make much sense.  :-)

-- 
Shawn.
