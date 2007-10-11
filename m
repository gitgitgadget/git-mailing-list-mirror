From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: [PATCH] cvsserver: added support for update -p
Date: Thu, 11 Oct 2007 18:52:32 +0200
Message-ID: <200710111852.32740.wielemak@science.uva.nl>
References: <200710101316.03633.jan@swi-prolog.org> <1192120573-16765-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Jan Wielemaker <jan@swi-prolog.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 18:53:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig1HW-0005Zg-5s
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 18:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbXJKQw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 12:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753596AbXJKQw4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 12:52:56 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:1579 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbXJKQwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 12:52:55 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9BGqYJ8012677;
	Thu, 11 Oct 2007 18:52:40 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <1192120573-16765-1-git-send-email-frank@lichtenheld.de>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60613>

On Thursday 11 October 2007 18:36, Frank Lichtenheld wrote:
> Based on a patch by Jan Wielemaker <jan@swi-prolog.org>.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>

Thanks. You are a bigger Perl programmer than I :-) Are you also
interested in one that makes "cvs diff -c" work?  It works, but it
does not handle things like "cvs diff -C 5" and I'm a bit lost in
Perl-space ...  If someone knowing more about the server wants to
have a look, I'm happy to post the part I have.

	Cheers --- Jan
