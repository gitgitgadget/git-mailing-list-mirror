From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Fri, 16 Feb 2007 00:22:56 -0800
Message-ID: <7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
References: <874ppmplw7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHyMv-00009e-9z
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966201AbXBPIW6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 03:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966203AbXBPIW6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:22:58 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58222 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966201AbXBPIW5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Feb 2007 03:22:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216082258.MDBP1300.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 03:22:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q8Nw1W00G1kojtg0000000; Fri, 16 Feb 2007 03:22:57 -0500
In-Reply-To: <874ppmplw7.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 16
	Feb 2007 09:06:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39904>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> This series implements the split of the fetch and merge logic.

That's a description of what it does, but could you describe
what problem it solves, please?

The approach of presentation to introduce the test and showing
the behavior change in a later patch is very good, though.
