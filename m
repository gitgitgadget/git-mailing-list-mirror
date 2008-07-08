From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Tue, 8 Jul 2008 15:12:20 +0200
Message-ID: <20080708131220.GF14794@joyeux>
References: <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer> <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux> <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org> <20080708080042.GB3628@joyeux> <alpine.DEB.1.00.0807081320220.4319@eeepc-johanness> <20080708122244.GE14794@joyeux> <alpine.DEB.1.00.0807081358481.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 15:13:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGD0c-0000by-Ar
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 15:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbYGHNM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 09:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755719AbYGHNM0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 09:12:26 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:57387 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112AbYGHNMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 09:12:25 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay08.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KGCzV-0003RZ-VG; Tue, 08 Jul 2008 15:12:22 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807081358481.18205@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]060505
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87760>

> > ... and checkouts the commit registered in the superproject. Therefore 
> > neither git-submodule status nor git-submodule summary can give an idea 
> > of "what's new in submodules"
> 
> Yeah, now I get what you are saying.  So you want a "git submodule peek" 
> or some such.

That is exactly the idea.

Sylvain
