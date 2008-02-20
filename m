From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Wed, 20 Feb 2008 02:14:46 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0802200214140.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com> <alpine.LNX.1.00.0802191127080.19024@iabervon.org> <7vy79ghbob.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802191856420.19024@iabervon.org>
 <alpine.LSU.1.00.0802200156560.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vve4ke8up.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jon Loeliger <jdl@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdYS-00026a-MM
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbYBTBOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756340AbYBTBOt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:14:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:46490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756159AbYBTBOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:14:48 -0500
Received: (qmail invoked by alias); 20 Feb 2008 01:14:47 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp042) with SMTP; 20 Feb 2008 02:14:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Jbjof0htJlnyFg4OMdwIxeaBtIQBclQSOafNBG7
	0+ugbXYFTXitvg
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vve4ke8up.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74495>

Hi,

On Tue, 19 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ...  If in doubt, consult get_extended_base_var() in config.c.
> 
> Perhaps it is time for Documentation/technical/api-config.txt ;-)?

*winces* I try to find the time...

Sorry,
Dscho
