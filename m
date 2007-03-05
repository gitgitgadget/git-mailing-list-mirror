From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Mon, 05 Mar 2007 00:23:05 -0800
Message-ID: <7vslck14ly.fsf@assigned-by-dhcp.cox.net>
References: <87ps7oslwk.fsf@gmail.com> <87abyskt6k.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Junio C. Hamano" <junkio@cox.net>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8UB-0000D2-CZ
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbXCEIXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 03:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbXCEIXJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:23:09 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:65440 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbXCEIXI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 03:23:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305082307.YMCZ1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 03:23:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WwP61W0031kojtg0000000; Mon, 05 Mar 2007 03:23:06 -0500
In-Reply-To: <87abyskt6k.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Mon, 05
	Mar 2007 09:09:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41415>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> P.D.: When sended this way the From: must be quoted or in UTF-8?

Absolutely not.
