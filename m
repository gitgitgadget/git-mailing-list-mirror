From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Translations [of Documentation] in Git release?
Date: Tue, 27 Jan 2009 08:01:53 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0901270800100.26770@ds9.cixit.se>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com> 
 <m3hc3mxn9d.fsf@localhost.localdomain>  <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se>
  <200901261631.18157.jnareb@gmail.com>  <20090126162351.GA8911@glandium.org>
 <bd6139dc0901261130ic64f767gddc960ebe3dfecf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Jakub Narebski <jnareb@gmail.com>,
	Dill <sarpulhu@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 08:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRhzE-0006sY-1d
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 08:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbZA0HC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 02:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZA0HC0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 02:02:26 -0500
Received: from ds9.cixit.se ([193.15.169.228]:48498 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbZA0HC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 02:02:26 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0R71vac028352
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Jan 2009 08:01:57 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0R71r0B028340;
	Tue, 27 Jan 2009 08:01:57 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <bd6139dc0901261130ic64f767gddc960ebe3dfecf2@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 27 Jan 2009 08:01:57 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107320>

Sverre Rabbelier:

> Perhaps the basics can be translated at least, the documents that do
> not require much change because they represent stable concepts?

I usually start out translating the program output, then manual pages,
and then, time permitting, documentation.

Git is a bit special in that regard since "--help" gets hardwired to
display the manual page, so one can't just translate the help screen.

-- 
\\// Peter - http://www.softwolves.pp.se/
