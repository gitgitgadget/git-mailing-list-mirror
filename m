From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix whitespace in "Format of STDIN stream" of fast-import
Date: Mon, 16 Jul 2007 01:39:19 -0400
Message-ID: <20070716053919.GD32566@spearce.org>
References: <20070715085740.GB2568@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJIv-00040F-9u
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbXGPFjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbXGPFjY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:39:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47972 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbXGPFjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 01:39:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAJIn-0007y3-7m; Mon, 16 Jul 2007 01:39:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1AFF220FBAE; Mon, 16 Jul 2007 01:39:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070715085740.GB2568@steel.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52642>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Something probably assumed that HT indentation is 4 characters.

Yea, my f*!&!(@*& text editor.  Thanks for the fix.  Applied.

-- 
Shawn.
