From: J-S-B <John-S-Brumbelow@hotmail.com>
Subject: Re: encrypted repositories?
Date: Thu, 2 Aug 2012 07:52:52 -0700 (PDT)
Message-ID: <1343919172934-7564308.post@n2.nabble.com>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 16:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swwlm-0007Hl-FH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 16:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab2HBOwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 10:52:54 -0400
Received: from sam.nabble.com ([216.139.236.26]:37943 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab2HBOwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 10:52:53 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <John-S-Brumbelow@hotmail.com>)
	id 1Swwlg-0002pH-UX
	for git@vger.kernel.org; Thu, 02 Aug 2012 07:52:52 -0700
In-Reply-To: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202782>

To Matthias.

My name is John Brumbelow, and I know how to solve your issue. Its requires
client-driven-encryption, such that the server never gets the data
un-encrypted, ever, and thus can never decrypt it, but yet, on behalf of the
client, and other clients, users can still search, partially search,
wild-char-search, document-reference-search, and most important, sort data
stored on the server, that the server (and its administrators) can never
"see" cause it never left the client making/editing it, un-encrypted.

Note the key phrase is client-driven-encryption, not, client-encryption.
That is, the client drives the encryption process in conjunction with the
server(s).

This makes it so the data can never be stolen from the server, even if a
villan showed up at the server and held the administrators hostage, or at
any point beyond the client.

There is more...

I also know how to further obfuscate the data, as it is being made, to
protect the end user, so if the villan showed up at the client, and held
them hostage and/or hacked their computer(s), their data would still be
protected. This is not just a simple, extra-hash over the data, but
something that gives the villan fake/false data, which could be
traced/tracked, by the server/authorities.

Please email me at John-S-Brumbelow@hotmail.com





--
View this message in context: http://git.661346.n2.nabble.com/encrypted-repositories-tp3275970p7564308.html
Sent from the git mailing list archive at Nabble.com.
