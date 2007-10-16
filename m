From: "franky" <yinping@kooxoo.com>
Subject: RE: should git command and git-command be equivalent?
Date: Tue, 16 Oct 2007 16:47:58 +0800
Message-ID: <20071016084800.270917E6F@mail.kooxoo.com>
References: <vpqprzfsdo3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Matthieu Moy'" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihi65-0008Hz-3g
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757698AbXJPIsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbXJPIsF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:48:05 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:48581 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbXJPIsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:48:03 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id 270917E6F;
	Tue, 16 Oct 2007 16:47:59 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <vpqprzfsdo3.fsf@bauges.imag.fr>
Thread-Index: AcgPySOW1rlImQupRM2k1gqzU25s9gAB1QMQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61121>

> Also, you can use aliases (for example, I type "git st" to do "git
> status") with "git whatever", but not with "git-whatever" (unless you
> define the alias in your shell).
I try "git st", but it complains "git: 'st' is not a git-command".
Instead, I use gt-beginning abbreviation for some command frequently used
such as gtci->git-commit, gtco-->git-checkout, gtst-->git-status,
gtdi->git-diff, gtinit->git-init

So it will be wonderful if I can use "gtinit --bare"

> --
> Matthieu
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
