From: Raimund Bauer <ray007@gmx.net>
Subject: Re: problem pushing repository
Date: Sat, 23 Jun 2007 12:12:16 +0200
Message-ID: <1182593536.5937.14.camel@localhost>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
	 <20070622022426.GA2961@bowser.ruder> <1182496916.6207.11.camel@localhost>
	 <Pine.LNX.4.64.0706221224310.4059@racer.site>
	 <1182519484.6207.38.camel@localhost>  <20070622224712.GI17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Ruder <andy@aeruder.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 12:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I22bP-0006Md-UO
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 12:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXFWKMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 06:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXFWKMW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 06:12:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:46344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751750AbXFWKMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 06:12:21 -0400
Received: (qmail invoked by alias); 23 Jun 2007 10:12:19 -0000
Received: from p54989D30.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.157.48]
  by mail.gmx.net (mp056) with SMTP; 23 Jun 2007 12:12:19 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1+MXipk/neM6v/Cp3MaipEW+c5hs2+DdJoTxR7qFk
	ayrcthIAZNABP5
In-Reply-To: <20070622224712.GI17393@spearce.org>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50725>

Hi,

On Fri, 2007-06-22 at 18:47 -0400, Shawn O. Pearce wrote:
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks a lot, your patch makes my life easier.
Since you obviously know what you're doing here, maybe I can wish for
something too?

It would be really cool if completion also worked when I started the
branchname with a '+' to force the push ...

-- 
best regards

  Ray
