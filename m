From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Fri, 3 Oct 2008 07:09:52 -0700
Message-ID: <20081003140951.GU21310@spearce.org>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se> <20081001220604.GB18058@coredump.intra.peff.net> <20081001223125.GA25267@coredump.intra.peff.net> <48E45ECC.8070104@op5.se> <20081002211309.GB29480@coredump.intra.peff.net> <20081003001556.GS21310@spearce.org> <20081003042405.GB1839@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 03 16:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KllNA-0000xM-Oa
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 16:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYJCOJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 10:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbYJCOJ4
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 10:09:56 -0400
Received: from george.spearce.org ([209.20.77.23]:33384 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbYJCOJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 10:09:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 21A143835F; Fri,  3 Oct 2008 14:09:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081003042405.GB1839@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97426>

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 02, 2008 at 05:15:56PM -0700, Shawn O. Pearce wrote:
> 
> > I think painting is over for now.  Time to let the paint dry.
> > I applied Jeff's patch:
> > 
> >   [jk/bikeshed] created bd8098f: "reformat informational commit message"
> 
> Woo! Victory by attrition!

I think the hard part now is to get the user docs updated to reflect
the new format.  We need to get that done before this can merge
over to master.

-- 
Shawn.
