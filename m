From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFD] socklen_t needs to be defined and libssl to be linked on
 old Mac OS X
Date: Fri, 29 Jul 2005 12:27:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507291225000.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507281649230.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vfytyqrhq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 12:29:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyS77-0006nw-Mf
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 12:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVG2K2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 06:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVG2K2j
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 06:28:39 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:55014 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262568AbVG2K1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 06:27:01 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6D6FFE25C8; Fri, 29 Jul 2005 12:27:00 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D780A8704; Fri, 29 Jul 2005 12:27:00 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3091558E51; Fri, 29 Jul 2005 12:27:00 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0F4BEE25C8; Fri, 29 Jul 2005 12:27:00 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfytyqrhq.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Junio C Hamano wrote:

> I'll keep this in the proposed updates queue until somebody
> comes up with a bit cleaner solution.

Agreed. That's why I put in "RFD", not "PATCH"

> By the way, Johannes, what mailer do you use?  Many of your
> patches seem to be whitespace damaged.

Why, I use pine! The whitespace could be the consequence of a very tired
yours truly doing copy and paste. Anyway, this was not really meant as a
patch, but rather as documentation of my thoughts.

Ciao,
Dscho
