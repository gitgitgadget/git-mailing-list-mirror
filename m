From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Tue, 16 Aug 2005 22:41:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508162240060.19656@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200508161941.j7GJfpI3023107@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 22:42:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58FB-0003z9-Bt
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 22:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVHPUlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 16:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVHPUlG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 16:41:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12753 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932434AbVHPUlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 16:41:05 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B6D0CE25C0; Tue, 16 Aug 2005 22:41:04 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9C75899BEF; Tue, 16 Aug 2005 22:41:04 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 88F5A99B94; Tue, 16 Aug 2005 22:41:04 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 93EFBE25C0; Tue, 16 Aug 2005 22:41:00 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200508161941.j7GJfpI3023107@laptop11.inf.utfsm.cl>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 16 Aug 2005, Horst von Brand wrote:

> And teach make(1) about checking out files from git... or just create a
> co(1) command for git.

How about "git-checkout-script", optionally with the "-f" flag to ignore 
changes since the last checkout/checkin?

Ciao,
Dscho
