From: David Kastrup <dak@gnu.org>
Subject: Re: Buffer overflows
Date: Sun, 02 Sep 2007 17:19:49 +0200
Message-ID: <85veatqelm.fsf@lola.goethe.zz>
References: <1188502009.29782.874.camel@hurina>
	<3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
	<7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
	<200709021542.31100.johan@herland.net>
	<3f4fd2640709020811r4ea8f01fw775257859e26af29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>, "Timo Sirainen" <tss@iki.fi>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 17:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRrEz-0008A2-Nr
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 17:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbXIBPTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbXIBPTx
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 11:19:53 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:53638 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257AbXIBPTx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 11:19:53 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 602F42D2AAD;
	Sun,  2 Sep 2007 17:19:52 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 4DA89201001;
	Sun,  2 Sep 2007 17:19:52 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-061.pools.arcor-ip.net [84.61.38.61])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 30C631C3326;
	Sun,  2 Sep 2007 17:19:52 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D8A4A1C15372; Sun,  2 Sep 2007 17:19:49 +0200 (CEST)
In-Reply-To: <3f4fd2640709020811r4ea8f01fw775257859e26af29@mail.gmail.com> (Reece Dunn's message of "Sun\, 2 Sep 2007 16\:11\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4132/Sun Sep  2 16:25:59 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57339>

"Reece Dunn" <msclrhd@googlemail.com> writes:

> Which is good, as this means that along with the tests in the
> library, it will be more stable and less likely to be buggy than
> something that is written from scratch.

Remember git's history.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
