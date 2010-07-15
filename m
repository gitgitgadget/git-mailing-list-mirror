From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] gitmodules.5: url can be a relative path
Date: Thu, 15 Jul 2010 11:32:40 +0200
Message-ID: <201007151132.40617.johan@herland.net>
References: <4C3DD7EF.6010805@panasas.com>
 <alpine.DEB.2.00.1007150745340.13735@perkele.intern.softwolves.pp.se>
 <20100715074155.GA22244@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 11:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZKoE-0001y2-FO
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 11:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890Ab0GOJco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 05:32:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49714 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab0GOJcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 05:32:43 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5L00J9DEIHLT90@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Jul 2010 11:32:41 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8FF141EEF456_C3ED5B9B	for <git@vger.kernel.org>; Thu,
 15 Jul 2010 09:32:41 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 806791EEC26B_C3ED5B9F	for <git@vger.kernel.org>; Thu,
 15 Jul 2010 09:32:41 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5L0045OEIH2820@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Jul 2010 11:32:41 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <20100715074155.GA22244@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151069>

On Thursday 15 July 2010, Jonathan Nieder wrote:
> There is already excellent documentation for this facility in
> git-submodule.1, but it is not so discoverable.
> 
> Relative paths in .gitmodules can be useful for serving the
> same repository over multiple protocols, for example.
> Thanks to Peter for pointing this out.
> 
> Cc: Peter Krefting <peter@softwolves.pp.se>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
