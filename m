From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Wed, 26 Aug 2009 17:12:07 -0700
Message-ID: <20090827001207.GS1033@spearce.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org> <20090826234903.GR1033@spearce.org> <fabb9a1e0908261710l2a957basff5eb5d7225ce099@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 02:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgSbE-0000lI-Up
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 02:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbZH0AMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 20:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbZH0AMG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 20:12:06 -0400
Received: from george.spearce.org ([209.20.77.23]:47827 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZH0AMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 20:12:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 64010381FD; Thu, 27 Aug 2009 00:12:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908261710l2a957basff5eb5d7225ce099@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127124>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Aug 26, 2009 at 16:49, Shawn O. Pearce<spearce@spearce.org> wrote:
> > In that thread we have decided to slightly
> > change this grammar and this series needs to be respun.
> 
> Speaking of which, do you want me to add the feature command to the
> grammar and rebase this on top of that? I got the impression we were
> far enough discussing that for at least an RPC patch?

RFC patch.  And yes, because I think we already agreed in that
thread that the date-format option is actually a feature command,
and not an option command.  The other feature commands being kicked
around can be held for another series.

-- 
Shawn.
