From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: current repository hash
Date: Tue, 17 Jun 2008 10:51:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171050440.6439@racer>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8XtC-0000Q3-JD
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 11:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbYFQJxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 05:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754450AbYFQJxL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 05:53:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:44445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754357AbYFQJxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 05:53:10 -0400
Received: (qmail invoked by alias); 17 Jun 2008 09:53:08 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp015) with SMTP; 17 Jun 2008 11:53:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZEzgUM1JZOxWR8uatzSldeb1ZNysMcDvWlyY4jU
	HCQ3AluYqtxWZR
X-X-Sender: gene099@racer
In-Reply-To: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85282>

Hi,

On Mon, 16 Jun 2008, Alf Clement wrote:

> I want to compile the current repository hash id into my program, to be 
> able to checkout later this id an see the exact files for the compile.

If this program is meant for source-distribution, you might be interested 
in the "export-subst" attribute.  See Documentation/gitattributes.txt for 
details.

Ciao,
Dscho
