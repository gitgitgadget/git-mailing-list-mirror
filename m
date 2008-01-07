From: "Peter Klavins" <klavins@netspace.net.au>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 15:14:21 +0100
Message-ID: <fltc4g$6m8$1@ger.gmane.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <flsu0r$m9p$1@ger.gmane.org> <Pine.LNX.4.64.0801071447320.1864@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 15:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBsl6-0001Db-DA
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 15:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbYAGOOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 09:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbYAGOOw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 09:14:52 -0500
Received: from main.gmane.org ([80.91.229.2]:36703 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbYAGOOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 09:14:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JBskb-0002DP-On
	for git@vger.kernel.org; Mon, 07 Jan 2008 14:14:49 +0000
Received: from host74-244-static.104-82-b.business.telecomitalia.it ([82.104.244.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 14:14:49 +0000
Received: from klavins by host74-244-static.104-82-b.business.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 14:14:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host74-244-static.104-82-b.business.telecomitalia.it
In-Reply-To: <Pine.LNX.4.64.0801071447320.1864@ds9.cixit.se>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16545
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69792>

> So apparently my repository is a bit broken at the moment with LF on
> some files and CRLF on some. That's bad. I just assumed everything
> worked, it used to "just work" for CVS (except for when you actually
> tried to add binary files, of course).

LOL. Exactly. That's my only gripe with git, there's still some way to go 
before it's as usable as CVS in this regard, but of course in every other 
feature it's way superior.

If you follow the steps I listed, you will have new .sln and .vcproj files 
that you can commit over the top of the ones already there, and everything 
will be fixed! I checked out your project and it built fine.

------------------------------------------------------------------------
 Peter Klavins 
