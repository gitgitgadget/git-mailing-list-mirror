From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Status of the svn remote helper project (Nov, 2010)
Date: Sun, 7 Nov 2010 23:06:18 +1100
Message-ID: <6A74D35D-A065-44B7-8DA4-6CA78DE067CF@cordelta.com>
References: <20101107112129.GA30042@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 13:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF411-0006co-Ea
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 13:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab0KGMG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 07:06:26 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:55268
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab0KGMGZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 07:06:25 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EADIl1kzLWHsF/2dsb2JhbACiAQhxsCKIUYVIBA
X-IronPort-AV: E=Sophos;i="4.58,309,1286110800"; 
   d="scan'208";a="274382824"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 07 Nov 2010 23:06:19 +1100
Received: (qmail 12715 invoked from network); 7 Nov 2010 23:06:19 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 7 Nov 2010 23:06:19 +1100
In-Reply-To: <20101107112129.GA30042@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160878>

Hi all,

> [Cooking]
> * jn/svndiff0 (2010-11-06) 24 commits

[...]

> An SVN-format delta applier.  Seems okay, but it has not been heavily
> exercised with real-world deltas.

I'm testing this version against the original ASF dump that I used previously.
Maybe one day we can try against the KDE repo - which is epic in proportions.
