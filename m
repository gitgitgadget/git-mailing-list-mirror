From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] clone: add --perm option to clone an shared repository
Date: Mon, 22 Jun 2009 11:34:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906221134090.4168@intel-tinevez-2-302>
References: <1245586672-10894-1-git-send-email-roylee17@gmail.com> <4A3F3E08.10602@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roy Lee <roylee17@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 11:34:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIfvQ-0003em-1L
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 11:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbZFVJem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 05:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbZFVJel
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 05:34:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:55753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbZFVJek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 05:34:40 -0400
Received: (qmail invoked by alias); 22 Jun 2009 09:34:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 22 Jun 2009 11:34:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18W2QYBOZMWzeWELYPwfO0/NevF+zbuUqkP9jqsPp
	UcLTO6fNXKP3jy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A3F3E08.10602@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122023>

Hi,

On Mon, 22 Jun 2009, Paolo Bonzini wrote:

> Roy Lee wrote:
> > The term 'shared' used here is in the same context with git init.
> > Unfortunately the 'shared' option has been taken, so I took the "perm"
> > as a place holder in this patch. Any comments?
> 
> I think it would make sense to add "perm" to git-init too (and possibly
> deprecate --shared).

Agreed.  After we teach everybody on this planet that "perm" means 
"shared", and "shared" does not.

Ciao,
Dscho
