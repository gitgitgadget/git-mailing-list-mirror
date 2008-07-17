From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/RelNotes-1.6.0.txt: Expand on the
	incompatible packfiles
Date: Thu, 17 Jul 2008 19:45:53 +0200
Message-ID: <20080717174553.GF10151@machine.or.cz>
References: <20080717170118.14083.87086.stgit@localhost> <g5nue6$3ek$1@ger.gmane.org> <20080717172051.GY32184@machine.or.cz> <200807171940.06288.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:47:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJXZI-0000vp-K4
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbYGQRp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbYGQRp5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:45:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47016 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543AbYGQRp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:45:56 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E7BDA393B5FA; Thu, 17 Jul 2008 19:45:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807171940.06288.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88892>

On Thu, Jul 17, 2008 at 07:40:06PM +0200, Jakub Narebski wrote:
> Petr Baudis wrote:
> > I'm unclear about the 'or'-'and' question, though. 
> 
> If you want to be backwards compatibile with pre v1.4.4.5 clients,
> do you have to set either option, or both options, or what?  The
> same with pre v1.5.2 client...

If you want to be backwards compatible with _either_ pre-v1.4.4 or
pre-v1.5.2, you will set _either_ (a) or (b). Setting (a) implies you
want to set (b) too, though. :-)

				Petr "Pasky" Baudis
