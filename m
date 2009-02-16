From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH] 1/2: Externalizable items
Date: Mon, 16 Feb 2009 17:59:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161758030.6289@intel-tinevez-2-302>
References: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6qc-0002VX-UC
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbZBPQ77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZBPQ77
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:59:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:52515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751064AbZBPQ77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:59:59 -0500
Received: (qmail invoked by alias); 16 Feb 2009 16:59:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 16 Feb 2009 17:59:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+zqZUO1t+YiGRfIT030AfJlkW3kc7qfuYmOQtdd
	U1MP2o3VyV9AuG
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110210>

Hi,

On Mon, 16 Feb 2009, Nigel Magnay wrote:

> Make parts of jgit externalizable, so that they can be marshalled over
> the wire or onto disk,
> using formats from git mailing list.

Hmm.  I have to be honest and admit that I have no idea what you mean by 
externalizable.  From the "marshalling" comment, I'd have assumed that you 
mean Serializable, but then I still do not understand what "formats from 
git mailing list" are.  And that being a regular of said list for quite 
some time...

Care to enlighten me?

Ciao,
Dscho
