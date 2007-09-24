From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [rfc] git submodules howto
Date: Mon, 24 Sep 2007 09:11:35 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070924071135.GB3278@informatik.uni-freiburg.de>
References: <20070918105538.GL19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 09:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZi6l-0008CG-8h
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 09:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbXIXHLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2007 03:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbXIXHLs
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 03:11:48 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34057 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123AbXIXHLr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 03:11:47 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IZi6c-00026T-AM; Mon, 24 Sep 2007 09:11:46 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l8O7BjNm004656;
	Mon, 24 Sep 2007 09:11:45 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l8O7BZPD004655;
	Mon, 24 Sep 2007 09:11:35 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070918105538.GL19019@genesis.frugalware.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59024>

Hello,

Miklos Vajna wrote:
> $ mkdir lib
> $ cd lib
> $ git init
> Initialized empty Git repository in .git/
> $ echo "libmakefile" > Makefile
> $ dg add Makefile
>
> [...]
>
> 1) is this correct? :) i use it and it seem to do what i except, but
> maybe it's not correct

I get=20

	bash: dg: command not found

:-)  Probably s/dg/git/

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dhalf+a+cup+in+teaspoons
