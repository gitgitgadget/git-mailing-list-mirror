From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 18:21:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711131819490.4362@racer.site>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
 <87ve86889o.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711131600590.4362@racer.site>
 <87prye832v.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is0OZ-0001vM-2l
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbXKMSVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 13:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbXKMSVj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:21:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:43361 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752102AbXKMSVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 13:21:38 -0500
Received: (qmail invoked by alias); 13 Nov 2007 18:21:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 13 Nov 2007 19:21:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e4hkHz7AeYrNqKUw5QoJ4vGzwt21GiLYWZezX5b
	4lDUixLERIfYx9
X-X-Sender: gene099@racer.site
In-Reply-To: <87prye832v.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64822>

Hi,

On Tue, 13 Nov 2007, Sergei Organov wrote:

> Sorry, but *I* didn't *explicitly* fetch it _again_!
> 
> 1. I cloned git.git repo making no custom steps.

Which means that you wanted to track that repository.  Yes, the complete 
repository.  Not a single branch.  Not all branches except a single one.

> 2. I decided I don't need to track some of branches.

The you should have done that.  But that is different from "I decided to 
delete the tracking _branch_".

Ciao,
Dscho
