From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 14:40:22 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-14-14-40-22+trackit+sam@rfc1149.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net> <2008-03-13-18-14-36+trackit+sam@rfc1149.net> <20080314132949.GC2932@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 14:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaA9q-0003ja-Hy
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752405AbYCNNkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 09:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYCNNkb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:40:31 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:36274 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbYCNNkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:40:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id A44CFE0481;
	Fri, 14 Mar 2008 14:40:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stqATXqh8Tq7; Fri, 14 Mar 2008 14:40:23 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTP id CF116E049C;
	Fri, 14 Mar 2008 14:40:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 02E01C408D;
	Fri, 14 Mar 2008 14:40:23 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oGoXSnMTOh3; Fri, 14 Mar 2008 14:40:22 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id D1E88C40B8; Fri, 14 Mar 2008 14:40:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080314132949.GC2932@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77223>

On 14/03, Jeff King wrote:

| Sorry, I don't have that commit. What repo is it in?

Junio's "next" branch.

| So I assume there is some bug in git that is being triggered by the
| commit you mention.

Maybe, that's why I'd be interested by the behaviour you get with it.
