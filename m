From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Tue, 12 Feb 2008 01:43:23 -0600
Message-ID: <20080212074323.GD27535@lavos.net>
References: <20080209162234.GA25533@fieldses.org> <alpine.LNX.1.00.0802091251430.13593@iabervon.org> <20080209185038.GB25533@fieldses.org> <7vr6fletkl.fsf@gitster.siamese.dyndns.org> <7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 08:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOpoC-0002MP-Gy
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 08:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759772AbYBLHn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 02:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759825AbYBLHn1
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 02:43:27 -0500
Received: from mxsf04.insightbb.com ([74.128.0.74]:24059 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759772AbYBLHnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 02:43:25 -0500
X-IronPort-AV: E=Sophos;i="4.25,339,1199682000"; 
   d="scan'208";a="224668744"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf04.insightbb.com with ESMTP; 12 Feb 2008 02:43:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAIfdsEdKhvkY/2dsb2JhbACBWalk
X-IronPort-AV: E=Sophos;i="4.25,339,1199682000"; 
   d="scan'208";a="116332759"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 12 Feb 2008 02:43:24 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 190FB309F21; Tue, 12 Feb 2008 01:43:24 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73634>

On Sun, Feb 10, 2008 at 02:52:50AM -0800, Junio C Hamano wrote:
>  - It is Ok to indent with all spaces the Python and Elisp
>    sources in the contrib/ area.

Should contrib simply be exempt from all rules?  Certainly with my
contribution to contrib (contrib/stats/packinfo.pl) I made no effort to
conform to the Git style because I thought contribs were auxiliary to
Git.  (It contains indention with all spaces, which is my personal
default style.)

-bcd
