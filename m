From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Status of the svn remote helper project (Jan 2011, #1)
Date: Sat, 8 Jan 2011 01:00:31 +1100
Message-ID: <1AE003AD-CEA1-4187-9778-769B38842597@cordelta.com>
References: <20101107112129.GA30042@burratino> <20101121063149.GA15449@burratino> <20101205113717.GH4332@burratino> <20110105233915.GB22975@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 15:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbCrw-00088M-Fz
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 15:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab1AGOAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 09:00:34 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:50296
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482Ab1AGOAe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 09:00:34 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAGurJk3LWHsF/2dsb2JhbACkHwhztkSFaoVMBA
X-IronPort-AV: E=Sophos;i="4.60,289,1291554000"; 
   d="scan'208";a="314728248"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 08 Jan 2011 01:00:32 +1100
Received: (qmail 18898 invoked from network); 8 Jan 2011 01:00:31 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 8 Jan 2011 01:00:31 +1100
In-Reply-To: <20110105233915.GB22975@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164712>

Hi,

Jonathan wrote:
> Let's get svn-fe3 polished so when the next merge window comes around
> it is ready to be merged quickly.  

In short, I have tested the latest rollup and see no regressions when testing
against the ASF and KDE repos.

Thank you Jonathan for the hard work, the outstanding patches are
becoming quite numerous.

--
David Barr.
