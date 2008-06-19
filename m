From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Thu, 19 Jun 2008 16:10:22 +0200
Message-ID: <FCE0735F-3CF9-4F7D-AA1B-FA9D8EA8C593@ai.rug.nl>
References: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0806191459150.6439@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 19 16:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9KrG-0006G7-G5
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYFSOK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 10:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYFSOK3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:10:29 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:28363 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbYFSOK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 10:10:28 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6203.online.nl (SMTP Server) with ESMTP id EC6441C00051;
	Thu, 19 Jun 2008 16:10:26 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6203.online.nl (SMTP Server) with ESMTP id B32611C00043;
	Thu, 19 Jun 2008 16:10:22 +0200 (CEST)
X-ME-UUID: 20080619141024733.B32611C00043@mwinf6203.online.nl
In-Reply-To: <alpine.DEB.1.00.0806191459150.6439@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85476>


On 19 jun 2008, at 16:00, Johannes Schindelin wrote:

> How about "--rebasing"?  I would scratch my head a bit how a new  
> branch
> and a rebase would go together.

Perhaps even --auto-rebase then? I agree it sounds confusing

- Pieter
