From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 19:57:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191956420.7826@racer.site>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>  <20080219063937.GB3819@glandium.org>  <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>  <alpine.LSU.1.00.0802191115440.30505@racer.site> 
 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>  <47BB1EC0.601@freescale.com>  <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>  <alpine.LSU.1.00.0802191916020.7797@racer.site>  <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>
  <alpine.LSU.1.00.0802191940260.7826@racer.site> <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:58:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRYbT-0007vp-FK
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbYBST5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYBST5g
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:57:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:53727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752414AbYBST5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:57:35 -0500
Received: (qmail invoked by alias); 19 Feb 2008 19:57:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 19 Feb 2008 20:57:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IOQN5MHKIERfHv14MEtrDgu9iC2piHhzhrJtGCH
	+LWtaLk7cy47jZ
X-X-Sender: gene099@racer.site
In-Reply-To: <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74450>

Hi,

On Tue, 19 Feb 2008, Anatoly Yakovenko wrote:

> $ git-clone http://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
> Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

Maybe run "git update-server-info" in that directory?

Hth,
Dscho
