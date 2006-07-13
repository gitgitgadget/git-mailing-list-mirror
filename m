From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: As long as you're hacking on git-daemon...
Date: Thu, 13 Jul 2006 22:19:19 +0200
Message-ID: <E1G17eZ-0006qh-PV@moooo.ath.cx>
References: <20060713201248.25353.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 22:19:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G17ek-0002do-Ky
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 22:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWGMUTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWGMUTX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 16:19:23 -0400
Received: from moooo.ath.cx ([85.116.203.178]:39844 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030357AbWGMUTW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 16:19:22 -0400
To: linux@horizon.com
Mail-Followup-To: linux@horizon.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060713201248.25353.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23848>

linux@horizon.com <linux@horizon.com> wrote:
> Is it possible to make it capable of running from /etc/inetd.conf?
It is, see man git-daemon, --inetd :)
