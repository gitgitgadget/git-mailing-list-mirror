From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 00:02:17 +0200
Message-ID: <20080725220217.GE13539@leksak.fem-net>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVNo-0005fO-AY
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 00:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYGYWC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbYGYWC2
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 18:02:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:46663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751611AbYGYWC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 18:02:27 -0400
Received: (qmail invoked by alias); 25 Jul 2008 22:02:26 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp001) with SMTP; 26 Jul 2008 00:02:26 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19WQnVqeaFWUtIP4GthNjogeIQfrVvGL6TmGkqv4N
	jwUQs8+GkdV/FD
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMVMf-0001x8-EY; Sat, 26 Jul 2008 00:02:17 +0200
Content-Disposition: inline
In-Reply-To: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90127>

Hi,

Just a very short note: I like it ;-)
Amusing picture.

You perhaps should switch the page encoding to utf-8, since many
names of contributors are broken without.
I've just taken a view at the XHTML. You have:
	<?xml version="1.0" encoding="iso-8859-1" ?>
But:
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

And the HTTP server does not set an encoding, as it seems, which is ok.
So please change the first line to
	<?xml version="1.0" encoding="UTF-8"?>

Thanks,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
