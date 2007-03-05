From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Mon, 05 Mar 2007 00:37:34 -0800
Message-ID: <7vk5xw13xt.fsf@assigned-by-dhcp.cox.net>
References: <87ps7oslwk.fsf@gmail.com> <87abyskt6k.fsf@gmail.com>
	<7vslck14ly.fsf@assigned-by-dhcp.cox.net>
	<20070305082846.GC12104@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Joshua N Pritikin <jpritikin@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8hO-0006Cn-S6
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbXCEIhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 03:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXCEIhg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:37:36 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61809 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbXCEIhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 03:37:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305083736.JACC24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:37:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wwda1W00F1kojtg0000000; Mon, 05 Mar 2007 03:37:35 -0500
In-Reply-To: <20070305082846.GC12104@always.joy.eth.net> (Joshua N. Pritikin's
	message of "Mon, 5 Mar 2007 13:58:46 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41422>

Joshua N Pritikin <jpritikin@pobox.com> writes:

> On Mon, Mar 05, 2007 at 12:23:05AM -0800, Junio C Hamano wrote:
>> Santi B=C3=A9jar <sbejar@gmail.com> writes:
>> > P.D.: When sended this way the From: must be quoted or in UTF-8?
>>=20
>> Absolutely not.
>
> I think Junio meant that UTF-8 is OK. At least it is okay here in mut=
t.

Correct.  Sorry to be too terse.  It is my bad habit I cannot
shake off.  My apologies to Santi and you for clarifying.

When you override the author name with an in-body From: line,
that line is just part of the body text and you do not have to
(and you shouldn't) quote as in the real From: header.
