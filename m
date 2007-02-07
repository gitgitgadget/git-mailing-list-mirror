From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Wed, 7 Feb 2007 18:10:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071808320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C9EB54.3040406@xs4all.nl> <Pine.LNX.4.63.0702071625341.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C9F184.1060300@xs4all.nl> <Pine.LNX.4.63.0702071713190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45CA06E7.3050704@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqJE-0006YD-7E
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161389AbXBGRKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161402AbXBGRKI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:10:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:49283 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161389AbXBGRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:10:06 -0500
Received: (qmail invoked by alias); 07 Feb 2007 17:10:05 -0000
X-Provags-ID: V01U2FsdGVkX19m39k7cM5mu01kbcxF1WgFTGuYo5RPd2XVW2Te4F
	hLOA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45CA06E7.3050704@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38941>

Hi,

On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> 
> > BTW do you have side branches in that darcs gub repository? If not, I'll 
> > try to leech it into a git repo with tailor (I do not want to install 
> > darcs on all my machines, just to play with gub).
> 
> No, but I have a conversion running here.  I'll publish it once it's done.

Thank you very much!

Just out of curiosity: What do you use to convert it? Tailor all branches, 
then stitch them together? (With tailor, stitching is possible as long as 
you did not merge branches: the commit objects _will_ be identical, since 
even the commit timestamps are derived from the source repository.)

Ciao,
Dscho
