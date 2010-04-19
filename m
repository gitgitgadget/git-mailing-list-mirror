From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 2/3] gitk: do not parse "  >" context as submodule
 change
Date: Mon, 19 Apr 2010 11:08:19 +1000
Message-ID: <20100419010819.GA4386@brick.ozlabs.ibm.com>
References: <cover.1271260308.git.trast@student.ethz.ch>
 <5531510bfb94997f729a894a0b5a3158177a9add.1271260308.git.trast@student.ethz.ch>
 <20100417063320.GA6681@brick.ozlabs.ibm.com>
 <201004171420.55737.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 19 03:10:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3fVg-0003OO-Ae
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 03:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab0DSBKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 21:10:42 -0400
Received: from ozlabs.org ([203.10.76.45]:54287 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab0DSBKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 21:10:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A90F9B7D0F; Mon, 19 Apr 2010 11:10:39 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <201004171420.55737.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145262>

On Sat, Apr 17, 2010 at 02:20:55PM +0200, Thomas Rast wrote:

> Whoops, sorry:
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Thanks, but now that I have applied Jens Lehmann's patch that also
touches this area, your patch doesn't apply.  Could you rebase it and
send it again?

Thanks,
Paul.
