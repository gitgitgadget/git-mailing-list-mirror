From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 20:19:22 +0200
Message-ID: <20060615181922.GA36286@dspnet.fr.eu.org>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth> <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org> <20060615174833.GA32247@dspnet.fr.eu.org> <e6s7eb$78h$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 15 20:19:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqwRJ-0002br-V6
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 20:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWFOSTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWFOSTb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 14:19:31 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:50446 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030365AbWFOSTa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 14:19:30 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id C7CA6A4986; Thu, 15 Jun 2006 20:19:22 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e6s7eb$78h$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21900>

On Thu, Jun 15, 2006 at 08:03:56PM +0200, Jakub Narebski wrote:
> Does autoconf generate configure script in POSIX shell, or in bash?

It seems that it still generates bare /bin/sh compatible scripts.
ICBvery easilyW, though.

  OG.
