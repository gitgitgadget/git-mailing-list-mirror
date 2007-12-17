From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 16:30:49 -0500
Message-ID: <20071217213049.GG13515@fieldses.org>
References: <alpine.LFD.0.999999.0712140836140.8467@xanadu.home> <20071214215206.GB7300@mail.oracle.com> <alpine.LFD.0.999999.0712141724260.8467@xanadu.home> <20071214223957.GC7300@mail.oracle.com> <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <20071217211317.GC19816@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NZG-0003Ac-GU
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936219AbXLQVbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936199AbXLQVbZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:31:25 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34645 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936190AbXLQVbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:31:23 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J4NY7-0007xI-2H; Mon, 17 Dec 2007 16:30:55 -0500
Content-Disposition: inline
In-Reply-To: <20071217211317.GC19816@mail.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68629>

On Mon, Dec 17, 2007 at 01:13:18PM -0800, Joel Becker wrote:
> 	Sure, we're not complaining about that.  We complain some about
> the fast pace (at the time he had his problem, 1.4 installs were not
> unusual, and Junio's response suggested that "I use NFS" wasn't strongly
> considered as a use case), but more we complain about the obscurity of
> the reason.  If it's obvious what happened (not the specifics, just
> "please upgrade" or "repository format changed" or something), the user
> moves along.

By the way, just as a data point: I do keep some git repositories on
NFS, and access them from multiple machines with different git versions
(not on purpose--it's just that the machines don't all run the same
distro, so it'd be extra work to give them all the same version).  I
don't use anything older than 1.5.0.  If the repository became unusable
on one of those machines without warning it'd be annoying.

---b.
