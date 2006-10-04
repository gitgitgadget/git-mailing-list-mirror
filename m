From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 3/3] gitweb: gitweb.perl: mode change 0755->0644
Date: Wed, 4 Oct 2006 09:46:58 +0200
Message-ID: <20061004074658.GA29964@moooo.ath.cx>
References: <20061004071414.88341.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 09:47:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV1TE-0006KZ-5k
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 09:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWJDHrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 03:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWJDHrI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 03:47:08 -0400
Received: from moooo.ath.cx ([85.116.203.178]:17794 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161124AbWJDHrF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Oct 2006 03:47:05 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
Mail-Followup-To: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061004071414.88341.qmail@web31812.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28321>

Luben Tuikov <ltuikov@yahoo.com> wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> old mode 100755
What is the reason to do this?  gitweb.perl is a valid perl script and
can be executed without modification (setting environment variables
makes this useful).
