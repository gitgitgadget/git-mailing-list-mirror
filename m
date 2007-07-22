From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix support for legacy gitweb config for snapshots
Date: Sun, 22 Jul 2007 16:35:57 -0700
Message-ID: <7vwswsovtu.fsf@assigned-by-dhcp.cox.net>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
	<7vd4ylt3eh.fsf@assigned-by-dhcp.cox.net>
	<3bbc18d20707220805hd95c4ccsc48f140888403391@mail.gmail.com>
	<200707222341.21538.jnareb@gmail.com>
	<3bbc18d20707221610q757536eet213a6d08b810b280@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Matt McCutchen" <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:36:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICky5-0007rJ-NE
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760682AbXGVXgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758822AbXGVXgA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:36:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41428 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbXGVXf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:35:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722233600.KEYR1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 19:36:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Snbx1X00D1kojtg0000000; Sun, 22 Jul 2007 19:35:59 -0400
In-Reply-To: <3bbc18d20707221610q757536eet213a6d08b810b280@mail.gmail.com>
	(Matt McCutchen's message of "Sun, 22 Jul 2007 19:10:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53367>

Thanks, both.
