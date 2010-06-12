From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] t/README: document --root option
Date: Sat, 12 Jun 2010 09:58:08 +0200
Message-ID: <201006120958.08607.trast@student.ethz.ch>
References: <c5efa5c15498fe562af98b9b16165127bc1690c2.1276193888.git.trast@student.ethz.ch> <7vpqzxgusl.fsf@alter.siamese.dyndns.org> <20100612013019.GA27604@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 10:00:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONLdz-0008LR-HR
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 10:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab0FLH6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 03:58:13 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:7812 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab0FLH6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 03:58:13 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 09:58:09 +0200
Received: from thomas.localnet (129.132.208.223) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 09:58:10 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <20100612013019.GA27604@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148996>

Jeff King wrote:
> On Fri, Jun 11, 2010 at 01:48:26PM -0700, Junio C Hamano wrote:
> > 
> > Then...
> > 
> > 	Create "trash" directories used to store all temporary data during
> > 	testing under <directory>, instead of the t/ directory.
> 
> Yeah, that is much better, IMHO.

I see you already picked that up.  Thanks!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
