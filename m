From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 12:58:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Saurabh Gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 12:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhN56-0001Bj-5Q
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 12:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbZCKL5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 07:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZCKL5I
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 07:57:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:52761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752743AbZCKL5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 07:57:07 -0400
Received: (qmail invoked by alias); 11 Mar 2009 11:57:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 11 Mar 2009 12:57:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dP5tnLwZdN9QvRCoSrCeqqfDXRsbWzaW8snpUOy
	dPG5cgDhm6Tfrj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49B74373.3090609@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112914>

Hi,

Welcome, Saurabh!

On Wed, 11 Mar 2009, Saurabh Gupta wrote:

> /*About GSoC GIT ideas; */Here are the ideas which I found to be 
> interested in. Although, I would like to discuss any other idea than 
> these in GIT organization.
> 
> *1) Domain specific merge helpers* Intelligence in the merger can be put 
> which modifies the source file according the format. Different file 
> formats can be put in the merger to support.

You said that you are interested in this project, but from your mails I do 
not see what are the specific reasons why.

IMHO this project can only fly if you have a specific file format that you 
absolutely want to be able to merge; otherwise, it will be an uphill 
fight.

Personally, I would _love_ to see a good graphical tool (maybe written 
in Tcl/Tk) to help merging conflicts in LaTeX files, but I just do not 
have the time...

Ciao,
Dscho
