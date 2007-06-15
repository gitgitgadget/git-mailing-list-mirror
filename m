From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Documentation/gitmodules: fix asciidoc
Date: Thu, 14 Jun 2007 23:49:15 -0400
Message-ID: <20070615034915.GE18491@spearce.org>
References: <11818789512948-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2oR-0007wE-JE
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbXFODtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbXFODtV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:49:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33689 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbXFODtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:49:20 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hz2o5-0001jh-4D; Thu, 14 Jun 2007 23:49:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B003720FBAE; Thu, 14 Jun 2007 23:49:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11818789512948-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50238>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> ---
>   I was getting documentation build errors without this

Yea, I got doc build errors today too from `next` but did not have
time to track down what was causing them.  Something about the XML
not matching the DocBook DTD.

-- 
Shawn.
