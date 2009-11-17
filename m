From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 09:59:33 +0100
Message-ID: <vpqhbstplvu.fsf@bauges.imag.fr>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v3a4enkzt.fsf@alter.siamese.dyndns.org>
	<7vy6m5hci0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAJui-0005wG-J2
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 09:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZKQI7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 03:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbZKQI7j
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 03:59:39 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49068 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298AbZKQI7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 03:59:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAH8wXdo025644
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 09:58:33 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NAJuP-0003Pf-MM; Tue, 17 Nov 2009 09:59:33 +0100
In-Reply-To: <7vy6m5hci0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 16 Nov 2009 22\:49\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Nov 2009 09:58:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAH8wXdo025644
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259053115.53689@hldW0mXve/YLUguPDduveQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133082>

Junio C Hamano <gitster@pobox.com> writes:

> I'd like to squash this to your patch, based on the earlier review
> comments.

Sure. And apologize for the style issues, I knew it, but one hardly
changes his (bad) habits ;-).

I'll resend soon.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
