From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 0/5]
Date: Wed, 25 Apr 2007 16:36:16 -0300
Organization: Mandriva
Message-ID: <20070425163616.7acc3258@localhost>
References: <1177437675887-git-send-email-lcapitulino@mandriva.com.br>
	<20070424175224.5afcf827@localhost>
	<7vhcr55w5w.fsf@assigned-by-dhcp.cox.net>
	<20070425110435.2d222979@localhost>
	<7vlkggxolb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hermes Trismegisto <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:37:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgnIm-0004ex-6k
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030974AbXDYTg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031136AbXDYTgZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:36:25 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:34383 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030974AbXDYTgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:36:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id F00A517BAD;
	Wed, 25 Apr 2007 16:36:22 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 0lbmHy+FcsWp; Wed, 25 Apr 2007 16:36:18 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id F41AE17BAC;
	Wed, 25 Apr 2007 16:36:17 -0300 (BRT)
In-Reply-To: <7vlkggxolb.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45550>

Em Wed, 25 Apr 2007 12:04:32 -0700
Hermes Trismegisto <junkio@cox.net> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
| writes:
| 
| > Em Tue, 24 Apr 2007 13:56:11 -0700
| > Junio C Hamano <junkio@cox.net> escreveu:
| >
| > | I suspect that you need to quote your human readable name, as it
| > | has a full-stop in it ("N.").  Maybe git-send-email should be
| > | taught about it.
| >
| >  It worked when I tested it sending the series to me and CC'ing
| > my gmail address.
| 
| Hmmm.  Maybe vger and my ISP have stricter filter based on set
| of addresses that appear on To/Cc lines than the way you receive
| mails?

 Maybe, but I've alreays used quilt send to submit patches and it
works quite well (not sure whether I've submitted more than five
patches to LKML though).

| In git-send-email, I notice that $author_name address on From:
| line is quoted in dq pairs (in sub send_message) but none of the
| addresses in @cc taken from the Signed-off-by lines are not
| inspected nor quoted.  I do not know what is being done to To:
| recipients offhand and I am too lazy to check.

 Heh, I can't check either.

| >  Will send this series by hand and figure out a better way to
| > do this...
| 
| Thanks.  They look reasonable, at least from my cursory look.

 You're welcome.

-- 
Luiz Fernando N. Capitulino
