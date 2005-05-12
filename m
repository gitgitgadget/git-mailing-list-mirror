From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] git tracker online
Date: Thu, 12 May 2005 21:58:25 +0200
Organization: linutronix
Message-ID: <1115927905.11872.48.camel@tglx>
References: <1115794878.22180.27.camel@tglx>
	 <20050512190433.GB8176@lug-owl.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:51:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJhB-0000wp-AO
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVELT5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVELT5p
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:57:45 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21900
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261368AbVELT5g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 15:57:36 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 5B2E265C065;
	Thu, 12 May 2005 21:57:31 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 88BD22829A;
	Thu, 12 May 2005 21:57:30 +0200 (CEST)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050512190433.GB8176@lug-owl.de>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 21:04 +0200, Jan-Benedict Glaw wrote:

> 	- Browsing the Cogito repository doesn't work. Could you fix
> 	  that?

Sure

> 	- When the {repository,diff against} drop-down box is changed,
> 	  it would be nice to fire off a onchange="submit()" so that (if
> 	  your browser is wacked with JavaScript) you don't need to
> 	  press the submit button.
> 

I thought about that already. I'm currently cleaning up the code and fix
the heuristic guessing a bit and then I will put the code online, so you
can fix yourself if I have not managed to do it until then :)

tglx


