From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: how to move with history?
Date: Mon, 18 Jun 2007 22:36:23 +0200
Message-ID: <20070618203623.GA19725@planck.djpig.de>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home> <20070618202918.GM3037@cs-wsok.swansea.ac.uk> <20070618203116.GK2334@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Oliver Kullmann <O.Kullmann@swansea.ac.uk>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 22:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Nxj-0002y7-2y
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 22:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762455AbXFRUgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762520AbXFRUgc
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 16:36:32 -0400
Received: from planck.djpig.de ([85.10.192.180]:3583 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762336AbXFRUgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 16:36:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id EC62988102;
	Mon, 18 Jun 2007 22:36:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HjA+JbL76X4M; Mon, 18 Jun 2007 22:36:24 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 20F6288105; Mon, 18 Jun 2007 22:36:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070618203116.GK2334@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50408>

On Mon, Jun 18, 2007 at 04:31:16PM -0400, J. Bruce Fields wrote:
> On Mon, Jun 18, 2007 at 09:29:18PM +0100, Oliver Kullmann wrote:
> So if you want to erase all memory of a path from the git history, then
> you have to rebuild it all.  Which is possible--it'd just mean creating
> a new project and writing a script to import every version into the new
> project....

Isn't that what git-filter-branch is for?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
