From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 00:51:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080051010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45CA42C2.4090908@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwZg-0005BU-BL
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbXBGXvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbXBGXvh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:51:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:33743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422796AbXBGXvf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:51:35 -0500
Received: (qmail invoked by alias); 07 Feb 2007 23:51:34 -0000
X-Provags-ID: V01U2FsdGVkX1/4LnQOHbL4cpoYilseymxNoR99I1gmvFjDdP3O5Y
	Tziw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45CA42C2.4090908@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39004>

Hi,

On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > I played a little with it. IMHO it makes no sense to use it without a 
> > bash, and without less. For example,
> > 
> > 	$ git init
> > 	$ git add git.exe
> > 	$ git status
> > 	$ git commit -a -m initial
> > 	$ git show HEAD
> > 
> > do not produce any output when issued in cmd.
> 
> Can you confirm to me that these do actually work? 

Apart from commit, which is a shell script, they appear to work. Only no 
uoutput :-)

Ciao,
Dscho
