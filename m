From: Jeff King <peff@peff.net>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 18:13:41 -0400
Message-ID: <20070322221340.GA13867@segfault.peff.net>
References: <200702281036.30539.litvinov2004@gmail.com> <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org> <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com> <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703221257020.18328@xanadu.home> <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 23:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUVXB-00020g-5N
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 23:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbXCVWNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 18:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbXCVWNT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 18:13:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4595 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161137AbXCVWNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 18:13:17 -0400
Received: (qmail 13952 invoked by uid 1000); 22 Mar 2007 18:13:41 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42886>

On Thu, Mar 22, 2007 at 10:10:24AM -0700, Linus Torvalds wrote:

> Ahh,that gets me further, but then it bombs out on the added error 
> messages. Is there something for that braindamage too?

Try EF_DISABLE_BANNER=1

-Peff
