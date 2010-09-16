From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 14:03:23 -0500
Message-ID: <20100916190323.GL5785@bowser.ece.utexas.edu>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
 <4C922112.404@drmicha.warpmail.net>
 <4C9222A9.4070801@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonas Fonseca <fonseca@diku.dk>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 21:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwJk2-000178-QD
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 21:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0IPTDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 15:03:25 -0400
Received: from irongate.mail.utexas.edu ([146.6.25.6]:51734 "EHLO
	irongate.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab0IPTDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 15:03:24 -0400
X-IronPort-MID: 55232640
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAEoGkkyAU36M/2dsb2JhbACiDHHFYYVBBIRLhWQ
Received: from wb4-a.mail.utexas.edu ([128.83.126.140])
  by irongate.mail.utexas.edu with ESMTP; 16 Sep 2010 14:03:24 -0500
Received: (qmail 67865 invoked from network); 16 Sep 2010 19:03:24 -0000
Received: from bowser.ece.utexas.edu (a.kumar@146.6.33.245)
  by wb4.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSSA; 16 Sep 2010 19:03:24 -0000
Content-Disposition: inline
In-Reply-To: <4C9222A9.4070801@atlas-elektronik.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156346>

On Thu, Sep 16, 2010 at 03:59:05PM +0200, Stefan Naewe wrote:
> On 9/16/2010 3:52 PM, Michael J Gruber wrote:
> > It seems that since that tig commit, "tig show <commit>" shows HEAD
> > rather than <commit>. OTOH, "tig <commit>" does navigate to <commit>.
> 
> Oops...how true.
> 
> I tested 'tig show <commit>' and noticed it showed something but
> didn't look close enough 8-|

Ah, maybe I should have been more explicit and specified that it shows
me the wrong commit. :-)

I did attempt to fix the code myself, but I require a more thorough
understanding of the code to be able to fix it myself.

Thanks.

Kumar
