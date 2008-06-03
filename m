From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: Re: git remote rename, why dosen't it exists?
Date: Tue, 03 Jun 2008 11:34:01 -0300
Message-ID: <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>
	 <alpine.DEB.1.00.0806031449010.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 16:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3XbI-0006GT-Kx
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 16:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbYFCOeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYFCOeH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 10:34:07 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:56848 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750866AbYFCOeH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 10:34:07 -0400
Received: from [127.0.0.1] (unknown [139.82.86.2])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id C23927F9F;
	Tue,  3 Jun 2008 07:34:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806031449010.13507@racer.site.net>
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83666>

I don't mind trying. :P Pointers would help me, I already found that the
git-remote source is on the file builtin-remote.c, bu I have not yet
found the main function of it.

On Tue, 2008-06-03 at 14:49 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 3 Jun 2008, Victor Bogado da Silva Lins wrote:
> 
> > Well, that's about it, I need to rename my remotes. Mainly to move the 
> > origin to another repository and I miss the feature. Since many time 
> > there is a reason for a missing feature, I fought that maybe I should 
> > ask here, before nosing around the sources... :)
> 
> The reason is easy to find: nobody cared enough about this feature to 
> implement it.
> 
> Just tell me if you want to do it, I'll provide you with the necessary 
> details.
> 
> Ciao,
> Dscho
> 
