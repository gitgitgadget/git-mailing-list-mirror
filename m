From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 13:50:33 -0700
Message-ID: <7vd4y5vexy.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?utf-8?Q?Jean-Fran=C3=A7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhd2-0001MY-EP
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbXHBUuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 2 Aug 2007 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbXHBUuh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:50:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37062 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbXHBUug convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 16:50:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802205036.UEEJ11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 16:50:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X8qb1X0061kojtg0000000; Thu, 02 Aug 2007 16:50:35 -0400
In-Reply-To: <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> (=?utf-8?Q?Je?=
 =?utf-8?Q?an-Fran=C3=A7ois?=
	Veillette's message of "Thu, 2 Aug 2007 10:04:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54607>

Jean-Fran=C3=A7ois Veillette <jean_francois_veillette@yahoo.ca>
writes:

> I find comments like this to be counter productive.
> Admin it, git porcelain still has some work to be done.

Yes, but this certainly is not an area that needs changing.
