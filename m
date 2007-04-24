From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix tail option problem in test
Date: Mon, 23 Apr 2007 22:02:55 -0700
Message-ID: <7v8xcibc00.fsf@assigned-by-dhcp.cox.net>
References: <462D47CA.7010806@gmail.com>
	<7v4pn6d459.fsf@assigned-by-dhcp.cox.net> <462D4F5D.7010605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 24 07:04:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgDC6-0003CA-Gt
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 07:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbXDXFC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 01:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbXDXFC7
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 01:02:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37687 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbXDXFC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 01:02:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424050257.QYOK1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 01:02:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qt2v1W00N1kojtg0000000; Tue, 24 Apr 2007 01:02:56 -0400
In-Reply-To: <462D4F5D.7010605@gmail.com> (A. Large Angry's message of "Mon,
	23 Apr 2007 20:29:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45409>

A Large Angry SCM <gitzilla@gmail.com> writes:

> It's not as easy to get the last X bytes of a file with dd.

Fair enough.
