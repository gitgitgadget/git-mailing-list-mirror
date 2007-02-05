From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 2)] git-blame.el --- Minor mode for incremental blame for Git
Date: Sun, 04 Feb 2007 17:40:37 -0800
Message-ID: <7vwt2xpeju.fsf@assigned-by-dhcp.cox.net>
References: <200702042114.34922.jnareb@gmail.com>
	<7vfy9lqusg.fsf@assigned-by-dhcp.cox.net>
	<200702050225.45328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 02:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDsqc-0008R1-8v
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 02:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbXBEBkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 20:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbXBEBkj
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 20:40:39 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:47472 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752306AbXBEBki convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Feb 2007 20:40:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205014038.QEUT1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 20:40:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kdgd1W0061kojtg0000000; Sun, 04 Feb 2007 20:40:37 -0500
In-Reply-To: <200702050225.45328.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 5 Feb 2007 02:25:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38717>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Are you Narbski, or Narebski, or are they the same?
>
> I usually avoid using letters outside US-ASCII, approximating Nar=C4=99=
bski=20
> (with eogonek) with Narebski, but with David using aa in his name...

Ahh, sorry, I usually use iso-ascii in an Emacs running on an
ASCII-only term-emu even when I am in X, and I did not see the
<=C4=99> character between r and b in your name (right now I am in
another Emacs I opened only to compose this message).

Junio (aka =E6=BF=B1=E9=87=8E =E7=B4=94)
