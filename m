From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] use -h for synopsis and --help for manpage consistently
Date: Wed, 5 Oct 2011 08:33:45 +0200
Message-ID: <20111005063344.GA1564@ecki>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <20111003182136.GA6136@ecki.lan>
 <7vhb3penqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 08:33:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBL2b-0008N2-3K
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 08:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414Ab1JEGdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 02:33:13 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47508 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756193Ab1JEGdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 02:33:12 -0400
Received: from localhost (p5B22F0BC.dip.t-dialin.net [91.34.240.188])
	by bsmtp.bon.at (Postfix) with ESMTP id 3A046130064;
	Wed,  5 Oct 2011 08:33:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhb3penqw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182828>

On Mon, Oct 03, 2011 at 03:03:51PM -0700, Junio C Hamano wrote:
> >  
> > -my @opts = ( 'help|h|H', 'version|V',
> > +my @opts = ( 'h', 'version|V',
> 
> I am a bit skeptical about the removal of 'H' here (also in git-svn).

I see. I'm ok with your fixup.

Clemens
