From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add core.quotepath configuration variable.
Date: Sun, 24 Jun 2007 15:30:28 -0700
Message-ID: <7vhcoxouij.fsf@assigned-by-dhcp.cox.net>
References: <7v1wg1q9i2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 00:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2abL-0004Rd-RE
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXFXWaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXFXWaa
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:30:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39229 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbXFXWaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:30:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624223030.HMUD3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 18:30:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FaWV1X0011kojtg0000000; Sun, 24 Jun 2007 18:30:29 -0400
In-Reply-To: <7v1wg1q9i2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 24 Jun 2007 15:21:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50837>

OOPS.

Sorry about the gotcha.  Because I did not force the MUA to use
UTF-8, it silently converted the patch to ISO-2022.  Too
friendly to be useful crap...
