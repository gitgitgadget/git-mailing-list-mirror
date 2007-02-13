From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gitk save and restore window pane position on Linux and Cygwin.
Date: Mon, 12 Feb 2007 17:15:53 -0800
Message-ID: <7vbqjy7t86.fsf@assigned-by-dhcp.cox.net>
References: <11713259742627-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Feb 13 02:16:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmH6-00011N-FU
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454AbXBMBPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965447AbXBMBPz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:15:55 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34620 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965454AbXBMBPy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:15:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213011554.WQKN22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 20:15:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NpFt1W00X1kojtg0000000; Mon, 12 Feb 2007 20:15:54 -0500
In-Reply-To: <11713259742627-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Mon, 12 Feb 2007 19:19:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39473>

This looks sane to me, although a bit twisted (and again it is
not Mark's fault).  Sergey, Ack?
