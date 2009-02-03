From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Tue, 3 Feb 2009 12:47:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031247070.6573@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <alpine.DEB.1.00.0901251622310.14855@racer> <7vwscjceec.fsf@gitster.siamese.dyndns.org> <200901252303.29204.jnareb@gmail.com> <alpine.DEB.1.00.0901260026310.14855@racer>
 <20090203190517.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 12:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUJln-0000ns-OA
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 12:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbZBCLrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 06:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbZBCLrV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 06:47:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:37769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751467AbZBCLrU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 06:47:20 -0500
Received: (qmail invoked by alias); 03 Feb 2009 11:47:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 03 Feb 2009 12:47:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UmQgG3aFUfRKO5wZa937qrE01InP9K9QpYbce1v
	yHclt7FEuN4Z+p
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090203190517.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108179>

Hi,

On Tue, 3 Feb 2009, Nanako Shiraishi wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > Nanako had a script at some stage; I would prefer an subcommand to 
> > "git rerere" which reconstructs the whole merge in-memory, and then 
> > records the conflict's resolution.
> 
> I'm sorry but I'm not sure what script of mine you are referring to.

http://article.gmane.org/gmane.comp.version-control.git/96911

Ciao,
Dscho
