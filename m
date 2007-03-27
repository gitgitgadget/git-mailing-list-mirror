From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Tue, 27 Mar 2007 10:47:59 +0400
Message-ID: <20070327064759.GA51155@codelabs.ru>
References: <20070326073502.GD44578@codelabs.ru> <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net> <20070326083617.GG13247@spearce.org> <7v8xdkxukt.fsf@assigned-by-dhcp.cox.net> <20070326100857.GW14837@codelabs.ru> <20070326190304.GB31844@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5TZ-000642-S4
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbXC0GsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 02:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbXC0GsK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:48:10 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:57601 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965194AbXC0GsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 02:48:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=E3cBMHaC0MdNNsdSide8MVcC8yvUMvgjsaTCLtYJZxFLeMvOli7jmU+6mDwwAoW8GZx/CkISyIdlBLpIIV82XnZUK6mSbzG+BPcz2zGGpClH/VeYWdF59Ao8Z9IDkgy45wr1LNSacYMpUOYt+g5mneMDLjPvs5c0jojOfS5B8QU=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW5TP-000DJr-W0; Tue, 27 Mar 2007 10:48:04 +0400
Content-Disposition: inline
In-Reply-To: <20070326190304.GB31844@coredump.intra.peff.net>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43233>

Jeff, good day.

Mon, Mar 26, 2007 at 03:03:04PM -0400, Jeff King wrote:
> On Mon, Mar 26, 2007 at 02:08:57PM +0400, Eygene Ryabinkin wrote:
> 
> > I do not like the left/right keys: it is wery hard to get the
> > right typing speed if we're using the arrow keys. But it is just
> > my habit since I learned to 10 fingers typing.
> 
> You might try:
> 
> cat >>$HOME/.lesskey <<'EOF'
> h left-scroll
> l right-scroll
> EOF
> lesskey

Very good, thanks!
-- 
Eygene
