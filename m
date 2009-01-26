From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Translations [of Documentation] in Git release?
Date: Mon, 26 Jan 2009 14:27:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
 <m3hc3mxn9d.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dill <sarpulhu@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 14:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRRWK-0003vA-Gp
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 14:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbZAZN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 08:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZAZN11
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 08:27:27 -0500
Received: from ds9.cixit.se ([193.15.169.228]:49188 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbZAZN10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 08:27:26 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0QDRIac025335
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Jan 2009 14:27:18 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0QDRHdm025328;
	Mon, 26 Jan 2009 14:27:17 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <m3hc3mxn9d.fsf@localhost.localdomain>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 26 Jan 2009 14:27:18 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107209>

Jakub Narebski:

> With GUI translations we just use gettext conventions. I don't know
> any such convention for docs:

There is a lot of documentation being translated using PO files. po4a -
http://po4a.alioth.debian.org/ - is a nice starting point for that.

-- 
\\// Peter - http://www.softwolves.pp.se/
