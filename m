From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: fix typo in lib/spellcheck.tcl
Date: Fri, 22 Feb 2008 01:33:58 -0500
Message-ID: <20080222063358.GB8410@spearce.org>
References: <200802211538.56190.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 07:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSRUY-0000ko-Gz
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 07:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYBVGeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 01:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbYBVGeE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 01:34:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42471 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYBVGeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 01:34:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JSRTr-0002ZX-AZ; Fri, 22 Feb 2008 01:33:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9DB6320FBAE; Fri, 22 Feb 2008 01:33:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200802211538.56190.barra_cuda@katamail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74693>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
>  		} else {
> -			error_popup [mc "Spell checker sliently failed on startup"]
> +			error_popup [mc "Spell checker silently failed on startup"]

Wow.  Thanks.  That was a very embarssing speeeling eror.  ;-)

I'll push it out in a few minutes.

-- 
Shawn.
