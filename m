From: Raimund Bauer <ray007@gmx.net>
Subject: Re: Strange diff behavior?
Date: Thu, 21 Jun 2007 08:47:38 +0200
Message-ID: <1182408458.6159.0.camel@localhost>
References: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
	 <Pine.LNX.4.64.0706210212060.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1GSF-0002LB-HJ
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 08:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbXFUGrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 02:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbXFUGrm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 02:47:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:59504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753237AbXFUGrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 02:47:41 -0400
Received: (qmail invoked by alias); 21 Jun 2007 06:47:39 -0000
Received: from p549897D7.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.151.215]
  by mail.gmx.net (mp021) with SMTP; 21 Jun 2007 08:47:39 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1+HVmZPpi6H0vrilYo4W0IeC08fausYlj8oJOAC8Y
	Nh2106M6t/9Hpg
In-Reply-To: <Pine.LNX.4.64.0706210212060.4059@racer.site>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50600>

On Thu, 2007-06-21 at 02:13 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 20 Jun 2007, Jason Sewall wrote:
> 
> > It seems like every change listed after the first one is meaningless.
> 
> Just a guess: core.autocrlf=true?

My guess: apply.whitespace=strip

> Ciao,
> Dscho

-- 
best regards

  Ray
