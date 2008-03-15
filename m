From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: remove spurious "fuzzy" attributes in po/it.po
Date: Sat, 15 Mar 2008 01:00:40 -0400
Message-ID: <20080315050040.GE8410@spearce.org>
References: <20080313052713.GU8410@spearce.org> <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se> <20080314063817.GW8410@spearce.org> <200803142159.52633.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 06:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaOWK-0000dE-CE
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 06:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbYCOFAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 01:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYCOFAp
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 01:00:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58068 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYCOFAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 01:00:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JaOVd-0007zs-Le; Sat, 15 Mar 2008 01:00:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9492120FBAE; Sat, 15 Mar 2008 01:00:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803142159.52633.barra_cuda@katamail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77309>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
> 
> On Friday 14 March 2008, Shawn O. Pearce wrote:
> >     MSGFMT    po/it.msg 388 translated, 2 fuzzy, 1 untranslated.
> 
> These "2 fuzzy" are bogus: those lines weren't changed between my last
> translation and Peter's regeneration, and were not fuzzy before. Strange.

Odd indeed.  Thank you for taking care of it so quickly.
 
-- 
Shawn.
