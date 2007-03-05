From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Begin SubmittingPatches with a check list
Date: Tue, 6 Mar 2007 00:14:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060013460.13683@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703050823.l258NgT9008266@localhost.localdomain>
 <20070305095101.GA792@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051554240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305150418.GD3481@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051631350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <86B5B6C7-F53E-4272-95F8-90DEA33430BA@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMOR-0008NL-L1
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbXCEXO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXCEXO4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:14:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:43700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751926AbXCEXOz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:14:55 -0500
Received: (qmail invoked by alias); 05 Mar 2007 23:14:53 -0000
X-Provags-ID: V01U2FsdGVkX19NPZ8S8HRNqUWE3Nv3ZsMk9fJKYyfP7r0hDwCeRL
	+0Dww75WypSxTB
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <86B5B6C7-F53E-4272-95F8-90DEA33430BA@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41501>

Hi,

On Mon, 5 Mar 2007, Brian Gernhardt wrote:

> On Mar 5, 2007, at 10:37 AM, Johannes Schindelin wrote:
> 
> > +	- use "git format-patch -M" to create the patch
> 
> The docco for git-format-patch doesn't list -M as one of it's options.  
> Is this one of the diff-options, and does it take all of the options 
> git-diff does?  If so, this should be mentioned in the documentation.

Actually, it is described briefly in the synopsis. But not in the options 
section. Care to provide a patch (see git-log.txt for an example how to 
include the diff options)?

Ciao,
Dscho
