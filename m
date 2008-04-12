From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Make core.sharedRepository more generic
Date: Sun, 13 Apr 2008 00:20:34 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-04-13-00-20-34+trackit+sam@rfc1149.net>
References: <20080412185105.GA14331@zakalwe.fi>
	<2008-04-12-21-15-04+trackit+sam@rfc1149.net>
	<20080412195046.GH31039@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Sun Apr 13 00:21:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jko6F-0001wp-8j
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 00:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYDLWUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYDLWUn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 18:20:43 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:33100 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYDLWUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 18:20:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 2C537E29C1;
	Sun, 13 Apr 2008 00:20:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuC9dWZWAsAG; Sun, 13 Apr 2008 00:20:35 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 6E61AE3044;
	Sun, 13 Apr 2008 00:20:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 72E23C408D;
	Sun, 13 Apr 2008 00:20:34 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eizQ8tQ5DwSc; Sun, 13 Apr 2008 00:20:34 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 4017BC40B9; Sun, 13 Apr 2008 00:20:34 +0200 (CEST)
In-Reply-To: <20080412195046.GH31039@zakalwe.fi> (Heikki Orsila's message of "Sat\, 12 Apr 2008 22\:50\:46 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79385>

>>>>> "Heikki" == Heikki Orsila <shdl@zakalwe.fi> writes:

Heikki> Are there script files in the .git/ directory that we want to
Heikki> set executable flag for?

Probably not.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
