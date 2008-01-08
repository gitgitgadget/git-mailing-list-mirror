From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 16:20:09 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801081618311.25629@ds9.cixit.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> 
 <200801071947.28586.robin.rosenberg.lists@dewire.com> 
 <alpine.LSU.1.00.0801071915470.10101@racer.site> 
 <200801072203.23938.robin.rosenberg.lists@dewire.com>  <20080107224204.55539c31@jaiman>
  <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
 <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Harris <peter@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 16:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCGGN-0003wy-BO
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 16:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759290AbYAHPUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 10:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbYAHPUP
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 10:20:15 -0500
Received: from ds9.cixit.se ([193.15.169.228]:38458 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247AbYAHPUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 10:20:14 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m08FKAZZ021856
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Jan 2008 16:20:10 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m08FK9Xs021851;
	Tue, 8 Jan 2008 16:20:09 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 08 Jan 2008 16:20:10 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69885>

Peter Harris:

> Actually, Subversion does the Right Thing, and treats everything as a
> binary file until and unless you explicitly set the svn:eol-style
> property on each file that you want it to mangle.
> 
> Maybe you set up Subversion auto-props and forgot about it? That would
> be almost (but not really) like setting autocrlf=true in your global
> git config.

Actually, I've never actively set up a Subversion server myself, nor
created any projects in Subversion (I have checked out some Subversion
repos, though). I started using RCS and CVS, and now I'm migrating at
least parts of that to Git (not all). Since Git is better than CVS in
many ways, I would like it to be better than CVS in this one as well.

-- 
\\// Peter - http://www.softwolves.pp.se/
