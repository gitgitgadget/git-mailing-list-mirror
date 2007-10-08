From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Merge problems with git-mingw
Date: Mon, 8 Oct 2007 15:56:26 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se> 
 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com> 
 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>
 <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Oct 08 16:56:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieu2A-0006fP-NJ
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 16:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbXJHO43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 10:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXJHO43
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 10:56:29 -0400
Received: from ds9.cixit.se ([193.15.169.228]:58579 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbXJHO43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 10:56:29 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l98EuQnQ029830
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Oct 2007 16:56:27 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l98EuQEI029825;
	Mon, 8 Oct 2007 16:56:26 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 08 Oct 2007 16:56:27 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60326>

Hi!

> Something is weird with your setup and/or the mingw port, but you can
> probably work around the issue by doing this:
> 
> $ git config user.name "your name"
> $ git config user.email "your email"

Both of those are configured properly, but even after configuring them
locally for the repository only, I get the same error with "git var".
Weird.

-- 
\\// Peter - http://www.softwolves.pp.se/
