From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Sat, 4 Sep 2010 23:46:11 +0200
Organization: SUSE Labs
Message-ID: <201009042346.11787.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <201009042333.51419.agruen@suse.de> <20100904214527.GA20444@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bug-patch@gnu.org,
	"Uwe =?iso-8859-1?q?Kleine-K=F6nig?=" 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Jean-Christophe PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
X-From: linux-sh-owner@vger.kernel.org Sat Sep 04 23:52:21 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1Os0er-0005E2-BP
	for glps-linuxsh-dev@lo.gmane.org; Sat, 04 Sep 2010 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0IDVwC (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Sat, 4 Sep 2010 17:52:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:48529 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab0IDVwC (ORCPT <rfc822;linux-sh@vger.kernel.org>);
	Sat, 4 Sep 2010 17:52:02 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D608B94393;
	Sat,  4 Sep 2010 23:52:00 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.31.12-0.2-desktop; KDE/4.3.5; i686; ; )
In-Reply-To: <20100904214527.GA20444@n2100.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155364>

On Saturday 04 September 2010 23:45:27 Russell King - ARM Linux wrote:
> It also makes them incompatible with GNU patch, whether or not GNU patch
> understands the GIT headers.

Aha?  Then why do you think GNU patch tries to understand the GIt patch 
headers?  So that it can be incompatible with GIT?

Andreas
