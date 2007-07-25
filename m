From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix error in generating snapshot
Date: Wed, 25 Jul 2007 15:47:30 -0700
Message-ID: <7vwswocd8d.fsf@assigned-by-dhcp.cox.net>
References: <30e4a070707250627l29ce4794x97d03b8232352cae@mail.gmail.com>
	<11854018464134-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpdz-0001GF-6F
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759370AbXGYWrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 18:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758333AbXGYWrd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:47:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41488 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225AbXGYWrc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:47:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725224732.XRJX1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 18:47:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TynX1X0041kojtg0000000; Wed, 25 Jul 2007 18:47:31 -0400
In-Reply-To: <11854018464134-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 26 Jul 2007 00:17:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53730>

Heh, I was working on that and had the identical fix committed
;-).

Thanks.
