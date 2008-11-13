From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 18:06:52 +0100 (CET)
Message-ID: <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
    <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
    <20081113140323.GA10267@neumann>
    <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
    <20081113145325.GD29274@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ffs-0000Bd-4t
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 18:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYKMRGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 12:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYKMRGx
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 12:06:53 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:49116 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbYKMRGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 12:06:52 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id BCB7014068;
	Thu, 13 Nov 2008 18:06:52 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 7427C14062;
	Thu, 13 Nov 2008 18:06:52 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
In-Reply-To: <20081113145325.GD29274@neumann>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100887>

SZEDER G=E1bor wrote:

> It doesn't matter.  The test script errors out at the merge, and not
> at the checkout.  Furthermore, it doesn't matter, whether HEAD~,
> HEAD~, or HEAD^ is checked out, the results are the same.

Just to be sure, I tried reverting the commit that you bisected -- and =
my
test case still fails.


Anders.
