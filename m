From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Initial Chinese translation
Date: Sat, 21 Jul 2007 17:35:15 -0700
Message-ID: <7vhcnxtgvw.fsf@assigned-by-dhcp.cox.net>
References: <11850629362012-git-send-email-xudong.guan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Christian Stimming <stimming@tuhh.de>
To: Xudong Guan <xudong.guan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 02:35:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICPPu-0002fs-HH
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 02:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbXGVAfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbXGVAfT
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 20:35:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63147 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbXGVAfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 20:35:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722003517.GDQR1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 20:35:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SQbF1X00N1kojtg0000000; Sat, 21 Jul 2007 20:35:16 -0400
In-Reply-To: <11850629362012-git-send-email-xudong.guan@gmail.com> (Xudong
	Guan's message of "Sun, 22 Jul 2007 01:08:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53204>

Xudong Guan <xudong.guan@gmail.com> writes:

> Simplified Chinese, in UTF-8 encoding.
>
> Signed-off-by: Xudong Guan <xudong.guan@gmail.com>
> ---
>  po/zh.po |  250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 250 insertions(+), 0 deletions(-)

This raises another point in the current i18n scheme.  How would
we allow zh_CN and zh_TW to coexist?
