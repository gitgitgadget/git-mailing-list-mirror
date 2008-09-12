From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 09:08:54 -0700
Message-ID: <20080912160854.GL22960@spearce.org>
References: <19449377.post@talk.nabble.com> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com> <20080912145804.GF10544@machine.or.cz> <200809121754.30277.jnareb@gmail.com> <20080912160538.GB10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBDf-0005Oy-Ju
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbYILQIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993AbYILQIz
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:08:55 -0400
Received: from george.spearce.org ([209.20.77.23]:39952 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbYILQIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:08:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 85C2D3835C; Fri, 12 Sep 2008 16:08:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080912160538.GB10360@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95746>

Petr Baudis <pasky@suse.cz> wrote:
> On Fri, Sep 12, 2008 at 05:54:29PM +0200, Jakub Narebski wrote:
> 
> > P.S. Could you please gather some statistics to compare the period
> > before and after installing "smart" HTTP server (and after smart
> > clients became widespread).
> 
> What kind of statistics?

Disk IO and network IO consumed probably.  The kernel.org folks are
hoping the smart HTTP server can lower their loads a bit by being
more careful about what we send to the client.

-- 
Shawn.
