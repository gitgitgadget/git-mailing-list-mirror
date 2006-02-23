From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PATCH: simplify calls to git programs in git-fmt-merge-msg
Date: Thu, 23 Feb 2006 13:36:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602231335420.3726@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCFi3-00005k-F7
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 13:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWBWMg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 07:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWBWMg0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 07:36:26 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40403 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751121AbWBWMgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 07:36:25 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 6500A1216;
	Thu, 23 Feb 2006 13:36:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 56CA15DDE;
	Thu, 23 Feb 2006 13:36:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 387769E6;
	Thu, 23 Feb 2006 13:36:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16643>

Hi,

On Thu, 23 Feb 2006, Alex Riesen wrote:

> It also makes it work on ActiveState Perl.

Thank you for teaching me this very valuable construct: qx{ ... }.

Ciao,
Dscho
