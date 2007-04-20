From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Contribute a fairly paranoid update hook
Date: Fri, 20 Apr 2007 03:45:20 -0700
Message-ID: <7vmz131fzz.fsf@assigned-by-dhcp.cox.net>
References: <20070420060847.GA8255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 12:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeqcM-0007VG-Tx
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 12:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767055AbXDTKpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 06:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767058AbXDTKpY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 06:45:24 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37500 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767055AbXDTKpV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 06:45:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420104522.DHHG1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 06:45:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pNlL1W00R1kojtg0000000; Fri, 20 Apr 2007 06:45:21 -0400
In-Reply-To: <20070420060847.GA8255@spearce.org> (Shawn O. Pearce's message of
	"Fri, 20 Apr 2007 02:08:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45082>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +$ENV{PATH}     = '/opt/git/bin';

This caught my attention ;-).
