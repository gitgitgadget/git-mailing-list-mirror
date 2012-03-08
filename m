From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 11:42:01 +0100
Message-ID: <1331203321.21444.13.camel@beez.lab.cmartin.tk>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
	 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
	 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5anR-0003Qh-Vs
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab2CHKmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:42:05 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:36417 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029Ab2CHKmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:42:04 -0500
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 971BE46082;
	Thu,  8 Mar 2012 11:41:54 +0100 (CET)
In-Reply-To: <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192554>

On Thu, 2012-03-08 at 10:38 +0000, Jeremy Morton wrote:
> But 'push --force' WILL try to push your (probably outdated) master
> upstream, killing any changes there made since you last updated.  That
> alone is so dangerous it seems like reason enough to avoid it by
> default.

Then don't use --force without specifying exactly what you want.
Anything with that option needs to be used carefully.

   cmn
