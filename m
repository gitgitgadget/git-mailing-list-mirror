From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: exporting a .git file ?
Date: Mon, 27 Aug 2012 17:09:13 +0200
Message-ID: <m2r4qsbcdi.fsf@igel.home>
References: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
	<503B8597.8040701@rktmb.org>
	<CANkmNDd6zPkrL-TueLnGCCyqP6eetxWh5KkL4vLGgUUddZFNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mihamina Rakotomandimby <mihamina@rktmb.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 17:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T60wQ-0008NN-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 17:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab2H0PJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 11:09:20 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46992 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab2H0PJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 11:09:19 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X5Ghq46cPz3hhgm;
	Mon, 27 Aug 2012 17:09:15 +0200 (CEST)
X-Auth-Info: TqlnpDRlWh1cM1ZGrey22hRYXUnzcdTRSfmNLnkw6hI=
Received: from igel.home (ppp-88-217-118-73.dynamic.mnet-online.de [88.217.118.73])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X5Ghq3mvSzbbgR;
	Mon, 27 Aug 2012 17:09:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 967AFCA2A3; Mon, 27 Aug 2012 17:09:14 +0200 (CEST)
X-Yow: Thank god!!..  It's HENNY YOUNGMAN!!
In-Reply-To: <CANkmNDd6zPkrL-TueLnGCCyqP6eetxWh5KkL4vLGgUUddZFNhw@mail.gmail.com>
	(Aaron Gray's message of "Mon, 27 Aug 2012 15:39:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204349>

Aaron Gray <aaronngray.lists@gmail.com> writes:

> I realize that but I wanted to distribute it as a downloadable file
> without having to use a server.

git bundle can create a single file from the object database.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
