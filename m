From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 16:48:51 +0100
Message-ID: <20070323154851.GA22517@diana.vm.bytemark.co.uk>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk> <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070323152102.GA4818@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:49:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUm16-0001oT-7A
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992474AbXCWPtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 11:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992476AbXCWPtT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:49:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2082 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992474AbXCWPtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:49:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HUm0Z-0005sN-00; Fri, 23 Mar 2007 15:48:51 +0000
Content-Disposition: inline
In-Reply-To: <20070323152102.GA4818@c3sl.ufpr.br>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42943>

On 2007-03-23 12:21:02 -0300, Bruno Cesar Ribas wrote:

> On Fri, Mar 23, 2007 at 11:34:26AM +0100, Karl Hasselstr=F6m wrote:
>
> > Maybe the pragmatic solution would be to have built-in handling of
> > a few properties such as svn:executable and svn:ignore that have
> > git equivalents, and just emulate all other properties with files.
>
> My idea is to write the git-svnserver!!! I think it will be easier.

Umm ... what I said was intended as a possible way to do the mapping
between svn and git concepts. I was under the impresson that
git-svnserver would need to use such a mapping.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
