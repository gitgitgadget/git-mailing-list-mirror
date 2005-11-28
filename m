From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 28 Nov 2005 17:33:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511281731490.11362@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051127125945.GD22159@pasky.or.cz> <Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051128135915.GR22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 17:34:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eglwi-0006u1-03
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVK1Qdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVK1Qdh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:33:37 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62876 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751241AbVK1Qdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 11:33:36 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E18BE13FEC7; Mon, 28 Nov 2005 17:33:35 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C787C9F46E; Mon, 28 Nov 2005 17:33:35 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B41789DB02; Mon, 28 Nov 2005 17:33:35 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8A12113FEC7; Mon, 28 Nov 2005 17:33:35 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051128135915.GR22159@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12892>

Hi,

On Mon, 28 Nov 2005, Petr Baudis wrote:

> As I said, I don't care much if this moves to the git configuration
> file, but please don't merge it with the remotes.

As you have made quite clear, it is for *you* to decide if you want to 
move .git/branches/ anywhere. I wrote the automatic conversion only to 
demonstrate how I thought how a migration *could* be done painlessly, if 
the information goes into .git/config.

Hth,
Dscho
