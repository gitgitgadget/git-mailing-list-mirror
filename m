From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 23:14:37 +0200
Message-ID: <20060605211436.GA58708@dspnet.fr.eu.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org> <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org> <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 23:14:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMPJ-0007O6-Ip
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWFEVOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFEVOi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:14:38 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:50949 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750871AbWFEVOh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 17:14:37 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 105F7A360B; Mon,  5 Jun 2006 23:14:37 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21342>

On Mon, Jun 05, 2006 at 12:03:31PM -0700, Linus Torvalds wrote:
> Comments?

Why don't you just sort the full path+filename with a strcmp variant
that starts by the end of the string for comparison?  May at least be
simpler to understand.

  OG.
