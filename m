From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 14:23:19 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Nov 13 14:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0cBS-0006Bm-BA
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 14:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYKMNXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 08:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYKMNXK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 08:23:10 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:39864 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYKMNXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 08:23:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 271DB10EAE3;
	Thu, 13 Nov 2008 14:23:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4vJ8U3u32lsD; Thu, 13 Nov 2008 14:23:04 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id D36FE10F4B2;
	Thu, 13 Nov 2008 14:23:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 92698C40BC;
	Thu, 13 Nov 2008 14:23:19 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRuIzQvsuNJf; Thu, 13 Nov 2008 14:23:19 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 6E83CC40BE; Thu, 13 Nov 2008 14:23:19 +0100 (CET)
In-Reply-To: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk> (Anders Melchiorsen's message of "Thu\, 13 Nov 2008 10\:22\:14 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100873>

>>>>> "Anders" == Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

Anders> I have tested the script with Git 1.6.0.2, but the real
Anders> scenario that made this appear seems to also fail with master
Anders> and next from git.git.

I confirm that your test case also fails with the current "next".

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
