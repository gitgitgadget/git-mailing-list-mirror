From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git+ssh using 'plink' on windows
Date: Mon, 15 Sep 2008 14:41:43 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809151440340.15601@ds9.cixit.se>
References: <262032.88533.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT SCM <git@vger.kernel.org>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 15:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfELu-0007sU-TM
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 15:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYIONlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 09:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbYIONlr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 09:41:47 -0400
Received: from ds9.cixit.se ([193.15.169.228]:52654 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYIONlq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 09:41:46 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8FDfiY1024511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Sep 2008 15:41:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8FDfhQm024505;
	Mon, 15 Sep 2008 15:41:43 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <262032.88533.qm@web95003.mail.in2.yahoo.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 15 Sep 2008 15:41:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95907>

dhruva:

> Since I use git on windows (without cygwin), I am keen to know if
> 'git+ssh' protocol work with Putty's plink? plink is a ssh like
> client on windows with almost similar features.

As long as you actually remember to add the keys to Plink, it works
perfectly fine. I've been using it in the last few releases, which do
ask you whether you want to use OpenSSH or PuTTY already in the
installation program.

-- 
\\// Peter - http://www.softwolves.pp.se/
