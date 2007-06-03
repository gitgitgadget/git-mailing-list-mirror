From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Sun, 03 Jun 2007 20:41:04 +0200
Message-ID: <87lkf0swxr.fsf@wine.dyndns.org>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at>
	<200706012305.41183.jnareb@gmail.com>
	<7vvee6nguh.fsf@assigned-by-dhcp.cox.net>
	<200706031742.45216.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 20:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huv18-0004Zg-6u
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbXFCSlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbXFCSlY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:41:24 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:58270 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXFCSlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:41:23 -0400
Received: from adsl-89-217-82-99.adslplus.ch ([89.217.82.99] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Huv0l-0000Ws-CL; Sun, 03 Jun 2007 13:41:07 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0A8E14F68B; Sun,  3 Jun 2007 20:41:05 +0200 (CEST)
In-Reply-To: <200706031742.45216.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 3 Jun 2007 17\:42\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49021>

Jakub Narebski <jnareb@gmail.com> writes:

> Alexandre, I hope that the patch attached would solve your problem.

Yes, it works fine for me, thanks!

-- 
Alexandre Julliard
julliard@winehq.org
