From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: core.autocrlf and merge conflict output
Date: Mon, 23 Jun 2008 03:00:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806230259140.6439@racer>
References: <g3miho$se5$1@ger.gmane.org> <7vy74xj7ww.fsf@gitster.siamese.dyndns.org> <g3mvbh$mmj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 04:02:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAbOL-0006t6-Di
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 04:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYFWCBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 22:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYFWCBe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 22:01:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:41054 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752564AbYFWCBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 22:01:33 -0400
Received: (qmail invoked by alias); 23 Jun 2008 02:01:31 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp010) with SMTP; 23 Jun 2008 04:01:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tPtgsVkytCkVnj4auMt7fuhh3qYOAW/nmEHEvBN
	idA8KDLbZgp69B
X-X-Sender: gene099@racer
In-Reply-To: <g3mvbh$mmj$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85828>

Hi,

On Sun, 22 Jun 2008, Edward Z. Yang wrote:

> Junio C Hamano wrote:
> > Is this an old news before 249c61a (merge-recursive: respect 
> > core.autocrlf when writing out the result, 2008-06-09) happened?
> 
> Apparently, yes. :o) Thus are the perils of working off a "downstream" 
> branch. I'll go bug the git/mingw/4msysgit.git maintainers to get this 
> change merged in. Thanks!

Funny.  And I thought 1.5.6 contained that patch...  Because 1.5.6 was 
merged by Steffen recently, and announced on both the msysgit list as well 
as this one.

Ciao,
Dscho
