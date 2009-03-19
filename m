From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 14:53:31 -0700
Message-ID: <20090319215331.GW23521@spearce.org>
References: <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com> <20090319201405.GD17028@coredump.intra.peff.net> <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com> <20090319214317.GU23521@spearce.org> <20090319214432.GV23521@spearce.org> <9b18b3110903191451u56bbee7biac3a1fee4a36b71d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQCe-0008Im-NL
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbZCSVxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbZCSVxe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:53:34 -0400
Received: from george.spearce.org ([209.20.77.23]:58628 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZCSVxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:53:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0789438221; Thu, 19 Mar 2009 21:53:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9b18b3110903191451u56bbee7biac3a1fee4a36b71d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113840>

demerphq <demerphq@gmail.com> wrote:
> 2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> >
> > git log -g branch@{now}
> 
> Ah! Much nicer! Thanks.
> 
> Is there by any chance any way to set the date format it uses to
> something more suitable for machine processing?

I don't think so.  If you want to machine process it, why not
just read the reflog directly?  Its a really simple format.

-- 
Shawn.
