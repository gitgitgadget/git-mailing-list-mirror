From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 17:53:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOYZ-0007Pc-Gd
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbZBCQyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbZBCQx7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:53:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:38626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751981AbZBCQx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:53:58 -0500
Received: (qmail invoked by alias); 03 Feb 2009 16:53:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 03 Feb 2009 17:53:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182YSUFHr02SZZzejbjRTzEgW9Pt0CnJLn3L8JDb8
	7jqyikBEuZU+gq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108212>

Hi,

On Tue, 3 Feb 2009, Brian Gernhardt wrote:

> This change appears to have been forgotten, but does fix the problems I 
> was having.  Junio, can this make it into the official repo instead of 
> floating around in my local?  I'd send in a patch, but it was your code 
> and I don't want to take credit for it.



Top-poster!


Besides, I think that my latest comment still stands there: testing is not 
good enough, code inspection is required if something expects the file 
names as they used to be.

Ciao,
Dscho
