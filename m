From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Wed, 7 Feb 2007 16:26:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071625341.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C9EB54.3040406@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 07 16:27:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEohT-0004wu-Sx
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 16:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbXBGP1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 10:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbXBGP1E
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 10:27:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:60637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030626AbXBGP05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 10:26:57 -0500
Received: (qmail invoked by alias); 07 Feb 2007 15:26:55 -0000
X-Provags-ID: V01U2FsdGVkX18dGxss6u0d2wl4v4WmQTPdM6D6utlpbHNcBouYMZ
	bQaQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C9EB54.3040406@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38931>

Hi,

On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
>
> > Also, many scripts rely on bash and/or perl, so you'd have to include 
> > them, too.
> 
> Indeed: for now, this is intended for people clueful enough to install 
> bash and perl on their own.  Adding bash itself should be easy, but I 
> have no idea how to make cmd open the scripts with bash automatically.

Would be nice to include them, though. In this case, you can add a 
shortcut to bash, named "Git shell" ;-)

> The thought of x-compiling perl makes me shudder. 

You don't want to tell me that you x-compile Python when bundling 
LilyPond, do you?

Ciao,
Dscho
