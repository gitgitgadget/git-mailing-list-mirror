From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Fri, 16 Feb 2007 13:14:45 -0800
Message-ID: <7v4ppl4xfe.fsf@assigned-by-dhcp.cox.net>
References: <874ppmplw7.fsf@gmail.com>
	<7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
	<8aa486160702160040t3f42b5a0xbd12f333805ad4d7@mail.gmail.com>
	<7vd54950ed.fsf@assigned-by-dhcp.cox.net>
	<8aa486160702161230r6f5825a2v861315c1aa52520e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 22:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIAPp-00046L-AN
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 22:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946247AbXBPVOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946250AbXBPVOr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 16:14:47 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33829 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946247AbXBPVOq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Feb 2007 16:14:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216211446.JAWQ1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 16:14:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QMEl1W01P1kojtg0000000; Fri, 16 Feb 2007 16:14:46 -0500
In-Reply-To: <8aa486160702161230r6f5825a2v861315c1aa52520e@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Fri, 16 Feb 2007 21:30:25
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39950>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> This sounds like a good justification, also :-)

What I said was an example.  I do not think your code churning
actually would make it easier.
