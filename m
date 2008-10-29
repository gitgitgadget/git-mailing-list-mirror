From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] diff: support making output friendlier for fine,
 grand users
Date: Wed, 29 Oct 2008 16:28:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810291628050.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225257832-29086-1-git-send-email-pasky@suse.cz> <20081029150731.GA9942@linode.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>, Jeff King <peff@peff.net>,
	"J.H." <warthog19@eaglescrag.net>, Sam Vilain <sam@vilain.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:22:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvCsN-0002w1-Ba
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYJ2PVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYJ2PVO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:21:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:39574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752904AbYJ2PVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:21:13 -0400
Received: (qmail invoked by alias); 29 Oct 2008 15:21:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 29 Oct 2008 16:21:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jHD5l/SJjvNBWMUUX33hr/hwiuWR6UjDgHP0TNg
	ZCVzcx+e4EkLDn
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081029150731.GA9942@linode.davidb.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99371>

Hi,

On Wed, 29 Oct 2008, David Brown wrote:

> On Tue, Oct 28, 2008 at 10:23:52PM -0700, Petr Baudis wrote:
> 
> >+	}
> >+	else if (!strcmp(arg, "--pirate")) {
> >+		printf("Arrrr!  These be yer fine changes, me 'earty!!\n");
> 
> We need to wait until Sept 19 to apply this patch, however.

We could back-date it, of course.

Ciao,
Dscho
