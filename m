From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Sat, 7 Jun 2008 00:06:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806070006150.1783@racer>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>  <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org>  <alpine.DEB.1.00.0806061911300.1783@racer>  <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil>
 <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Cedric Vivier <cedricv@neonux.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4l3s-0006V3-UX
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbYFFXIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbYFFXHz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:07:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:47632 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752439AbYFFXHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:07:55 -0400
Received: (qmail invoked by alias); 06 Jun 2008 23:07:52 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 07 Jun 2008 01:07:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8mIQpxxm8SBzMo3It9xRTfcxspat7hKFzcKE6r5
	U+QKQwunc4OVmk
X-X-Sender: gene099@racer
In-Reply-To: <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84132>

Hi,

On Fri, 6 Jun 2008, Cedric Vivier wrote:

> On Fri, Jun 6, 2008 at 11:04 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> > But can't that be just as easily done by piping through sort? (I 
> > understand there is a platform which lacks the sort utility, boohoo)
> 
> Yes, but sort does not have a natural sort option afaik.

sort -n

Hth,
Dscho
