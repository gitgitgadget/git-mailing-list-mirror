From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 2)] git-blame.el --- Minor mode for incremental blame for Git
Date: Sun, 04 Feb 2007 17:04:31 -0800
Message-ID: <7vfy9lqusg.fsf@assigned-by-dhcp.cox.net>
References: <200702042114.34922.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Kagedal <davidk@lysator.liu.se>,
	Alexandre Julliard <julliard@winehq.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 02:04:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDsHb-0000wU-S3
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 02:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbXBEBEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 20:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbXBEBEd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 20:04:33 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:39213 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752630AbXBEBEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Feb 2007 20:04:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205010432.NYSM1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 20:04:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kd4X1W00M1kojtg0000000; Sun, 04 Feb 2007 20:04:32 -0500
In-Reply-To: <200702042114.34922.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 4 Feb 2007 21:14:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38714>

Jakub Narebski <jnareb@gmail.com> writes:

> Here is an Emacs implementation of incremental git-blame.  When you

Missing "From: " in-body header?

> turn it on while viewing a file, the editor buffer will be updated by
> setting the background of individual lines to a color that reflects
> which commit it comes from.  And when you move around the buffer, a
> one-line summary will be shown in the echo area.
>
> Created by David K=C3=A5gedal, header and comments added by Jakub Nar=
=C4=99bski.

Are you Narbski, or Narebski, or are they the same?

> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>

I do not think David meant to go proprietary, but I did not see
his sign-off.

David, is this patch Ok with you?  I'll fix up to have "author"
line point fingers at you if it is, or you can send in your own
corrections/improvements (or a Nak) yourself.
