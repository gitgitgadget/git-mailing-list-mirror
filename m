From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/2] git-blame.el: separate git-blame-mode to ease maintenance
Date: Wed, 28 Mar 2007 10:47:18 +0200
Message-ID: <87d52t4uw9.fsf@morpheus.local>
References: <200703262100.l2QL0svB012536@localhost.localdomain>
	<87fy7rrsi2.fsf@morpheus.local>
	<200703271456.l2REumU4007939@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUC2-0007Gx-N3
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbXC1JLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 05:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933330AbXC1JLn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:11:43 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:35368 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbXC1JLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 05:11:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id B93A6200A202;
	Wed, 28 Mar 2007 10:47:24 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30696-01-4; Wed, 28 Mar 2007 10:47:24 +0200 (CEST)
Received: from morpheus (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E8566200A1FC;
	Wed, 28 Mar 2007 10:47:23 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 56373BFF27; Wed, 28 Mar 2007 10:47:18 +0200 (CEST)
In-Reply-To: <200703271456.l2REumU4007939@localhost.localdomain> (Xavier Maillard's message of "Tue, 27 Mar 2007 16:56:48 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43361>

Xavier Maillard <zedek@gnu.org> writes:

> Hi,
>
>    > String displayed on the mode line is now configurable through
>    > `git-blame-mode-line-string` (default to " blame").
>
>    Why do you feel the need for this?  I don't remember seeing any ot=
her
>    minor mode that does this.
>
> Because, I like when I can hide mode line strings for certains
> minor modes or even just shorten it. Here for example, I do not
> feel the need to display "Blame" in the mode line since
> git-blame.el is easily identifiable.

Ok.  I guess it won't do any harm :-)

--=20
David K=C3=A5gedal
