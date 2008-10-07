From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GitTogether topics status (4th of October)
Date: Tue, 7 Oct 2008 07:46:43 -0700
Message-ID: <20081007144643.GK8203@spearce.org>
References: <200810041816.41026.chriscool@tuxfamily.org> <20081007031509.GA6031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Petr Baudis <pasky@suse.cz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:50:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDr4-0005PE-Qw
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYJGOqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbYJGOqo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:46:44 -0400
Received: from george.spearce.org ([209.20.77.23]:42622 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYJGOqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:46:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 29E823835F; Tue,  7 Oct 2008 14:46:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081007031509.GA6031@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97713>

Jeff King <peff@peff.net> wrote:
> I just added two proposed half-hour meetings, both of which I intend to
> be a few minutes of me talking followed by group discussion. The topics
> are:
> 
>   1. Helping new developers join the git community

Oh, this is a good idea.  Yesterday I myself had trouble with
a new contributor not being familiar with the patching process.
Partly also my fault of still being a green maintainer.  ;-)
 
>   2. What needs refactoring?
> 
>      I occasionally run up against parts of the code that just make my
>      eyes bleed everytime I touch them. I think we've made significant
>      progress in maintanability and bug-avoidance with things like the
>      strbuf library, refactoring of remote and transport handling, etc.
>      What areas might still benefit from such refactoring?

Also a good idea.  I imagine Junio may have some interest in this.
I certainly do.  Some of the code is just bloodly aweful to work
with.  I guess those are the parts that make your eyes bleed.

-- 
Shawn.
