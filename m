From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: thread-safe libgit.a as a GSoC project, was Re: [SoC RFC]
 libsvn-fs-git: A git backend for the subversion filesystem
Date: Sun, 23 Mar 2008 03:10:12 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803230308540.4353@racer.site>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>  <3e8340490803212202r6dbaa9eel544ba2b4b8e8d0c7@mail.gmail.com>  <alpine.LSU.1.00.0803221229410.4124@racer.site> <5d46db230803221834n7c230447r2afffdaae79e4068@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bryan Donlan <bdonlan@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 03:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdFfn-0002dj-D3
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 03:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYCWCKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 22:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYCWCKR
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 22:10:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:33931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752380AbYCWCKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 22:10:16 -0400
Received: (qmail invoked by alias); 23 Mar 2008 02:10:13 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp012) with SMTP; 23 Mar 2008 03:10:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2bIVPaMP2gKeYkmYMKP/fkgjJoKRPmm81rxSta2
	6vIBa+j85TiNwI
X-X-Sender: gene099@racer.site
In-Reply-To: <5d46db230803221834n7c230447r2afffdaae79e4068@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77865>

Hi,

On Sat, 22 Mar 2008, Govind Salinas wrote:

> I would use it for my pyrite work, although it will be some time before 
> I could contribute to such an effort.  I expect it would be useful for 
> anyone who wants to make a language binding that uses native git 
> underneath.
> 
> Just so you know *someone* will use it.

I know people would use it.  My point was: those people that want to use 
it have the best starting point to make it happen, because they (should) 
actually care about libification.

Ciao,
Dscho
