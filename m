From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/5]
Date: Tue, 24 Apr 2007 13:56:11 -0700
Message-ID: <7vhcr55w5w.fsf@assigned-by-dhcp.cox.net>
References: <1177437675887-git-send-email-lcapitulino@mandriva.com.br>
	<20070424175224.5afcf827@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Tue Apr 24 22:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgS3o-0003hM-QZ
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 22:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423107AbXDXU4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423102AbXDXU4O
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 16:56:14 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34870 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423107AbXDXU4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 16:56:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424205612.ITJQ1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 16:56:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id r8wA1W00M1kojtg0000000; Tue, 24 Apr 2007 16:56:11 -0400
In-Reply-To: <20070424175224.5afcf827@localhost> (Luiz Fernando
	N. Capitulino's message of "Tue, 24 Apr 2007 17:52:24 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45490>

I suspect that you need to quote your human readable name, as it
has a full-stop in it ("N.").  Maybe git-send-email should be
taught about it.
