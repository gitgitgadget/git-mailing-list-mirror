From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull-fetch-param.txt
Date: Thu, 12 Jul 2007 14:58:08 -0700
Message-ID: <7vvecps2rz.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
	<452211C2.8020402@s5r6.in-berlin.de>
	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
	<45222B18.1090305@s5r6.in-berlin.de>
	<20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I96fw-0008GN-RP
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbXGLV6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 17:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbXGLV6L
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 17:58:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37893 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761638AbXGLV6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 17:58:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712215808.DFQN1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 17:58:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nly81X00h1kojtg0000000; Thu, 12 Jul 2007 17:58:09 -0400
In-Reply-To: <20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 12 Jul 2007 13:06:31 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52338>

Gerrit Pape <pape@smarden.org> writes:

> Hi, this still is a problem, at least on Debian/unstable; with asciidoc
> 8.2.1, the git-push(1) and git-fetch(1) man pages have this 'broken'
> refspec description[0].

Quick question.  Is the build done with "make
ASCIIDOC8=YesPlease"?
