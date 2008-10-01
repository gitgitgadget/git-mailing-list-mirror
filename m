From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 1 Oct 2008 08:44:25 -0700
Message-ID: <20081001154425.GE21310@spearce.org>
References: <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net> <48E3312E.4090601@op5.se> <20081001151011.GA21310@spearce.org> <20081001152546.GB4962@coredump.intra.peff.net> <20081001153637.GC21310@spearce.org> <20081001154205.GD4962@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:46:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3u2-0000u3-2w
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYJAPo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbYJAPo0
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:44:26 -0400
Received: from george.spearce.org ([209.20.77.23]:39425 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYJAPo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:44:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 340043835F; Wed,  1 Oct 2008 15:44:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081001154205.GD4962@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97241>

Jeff King <peff@peff.net> wrote:
> On Wed, Oct 01, 2008 at 08:36:37AM -0700, Shawn O. Pearce wrote:
> 
> > *sigh*  And I just took up the #@*#@!&!*!@ paintbrush myself.
> > Dammit.  I'm putting it down now.  Really.  :-)
> 
> Heh. I don't want to stir up trouble or drag you into a discussion you
> don't want to be in. But it seems like you are saying "OK, this is
> silly, let's just go with what is in next." But I think Andreas raised a
> good point about "stuff the user should check should go on the left"
> which is not consistent with what is in next. So I just want to confirm
> that you either disagree with that, or simply think it is not important
> enough to keep the discussion going.

I agree with "important stuff on the left".  So as much as I'd like
to just move on, I guess I'm willing to look at a 3rd patch that
moves the branch name onto the left side.

-- 
Shawn.
