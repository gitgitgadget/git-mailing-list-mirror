From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo
 with git protocol?
Date: Wed, 17 Dec 2008 13:12:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812171312330.28560@intel-tinevez-2-302>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvHu-000545-6k
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbYLQMMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbYLQMMo
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:12:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:38127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750934AbYLQMMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:12:44 -0500
Received: (qmail invoked by alias); 17 Dec 2008 12:12:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 17 Dec 2008 13:12:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+hJtgYR8+nFRxBOOypntRC54xzOA0UVcyq+LMWc
	hkevoNO4Ahx4nu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103338>

Hi,

On Wed, 17 Dec 2008, Emily Ren wrote:

> I created a repository, and I don't want somebody to pull some branch or 
> tag from my repository with git protocol. How can I do ?

Yes, it is easy: do not push it into that repository.

If you already did, delete it in that repository.

Ciao,
Dscho
