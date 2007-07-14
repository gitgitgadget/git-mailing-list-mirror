From: Jeff King <peff@peff.net>
Subject: Re: Possible to make a totally empty repository for remote access?
Date: Fri, 13 Jul 2007 22:59:42 -0400
Message-ID: <20070714025942.GB22559@coredump.intra.peff.net>
References: <54C69B03-C589-480E-80D3-75166DBF2D29@wincent.com> <7vtzs8lzgk.fsf@assigned-by-dhcp.cox.net> <95A1FBFA-DCB7-4767-B857-89660822C6E6@wincent.com> <20070714025819.GA22559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 04:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9XrH-0001sB-0z
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 04:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762994AbXGNC7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 22:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762920AbXGNC7o
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 22:59:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2939 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762787AbXGNC7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 22:59:44 -0400
Received: (qmail 23003 invoked from network); 14 Jul 2007 03:00:09 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jul 2007 03:00:09 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2007 22:59:42 -0400
Content-Disposition: inline
In-Reply-To: <20070714025819.GA22559@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52435>

On Fri, Jul 13, 2007 at 10:58:19PM -0400, Jeff King wrote:

>   $ git-remote origin server:/pub/git/test.git

Sorry, this should be:

  git-remote add origin server:/pub/git/test.git

-Peff
