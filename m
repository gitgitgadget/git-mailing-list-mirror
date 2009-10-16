From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git gui and gitk documentation
Date: Fri, 16 Oct 2009 15:10:37 +0200
Message-ID: <4AD870CD.1040709@drmicha.warpmail.net>
References: <BLU149-W532BC93AF99F2B8D4C90F1E3C50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chris miles <chrismileswales@hotmail.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 15:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mymc0-00011i-ED
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 15:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759105AbZJPNLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 09:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbZJPNLs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 09:11:48 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37378 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754486AbZJPNLr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 09:11:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 056D1B2973;
	Fri, 16 Oct 2009 09:10:46 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 16 Oct 2009 09:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pvTglEcPB9nZt2nLGOIvnrO1o6E=; b=HNS7AaFiKIowrYZGOgbtxVFJ5KsiyyTi8LRE8hcTAsmRh6Gs95oBM27DHXtIzJRSJ5pmu+2EFiCOJTYHB1FizuQJtUlVet9R8R6EKWwxyC2QzZIi+Tk6tmsWhJw7q9baEZKzJAxNnQpelW6VmYSNNBgR+hSDUKp3IqvNDwbiHcE=
X-Sasl-enc: grk5DuclocdH/q0kbjm1H/xDIUSYOxqGqG8P0H/K+o8D 1255698645
Received: from localhost.localdomain (p5DCC18CF.dip0.t-ipconnect.de [93.204.24.207])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2C8919B3F6;
	Fri, 16 Oct 2009 09:10:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091015 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <BLU149-W532BC93AF99F2B8D4C90F1E3C50@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130484>

chris miles venit, vidit, dixit 15.10.2009 22:51:
> 
> Hi
> 
> I'm looking for documentation on gitk and the gui that is distributed with git.
> Could anyone point me in the right direction?

How about

man gitk
man git-gui

The latter is the same as "git help gui". There is no "git help k",
though :)

Cheers,
Michael
