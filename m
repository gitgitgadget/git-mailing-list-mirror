From: Sam Vilain <sam@vilain.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 10:57:40 -0700
Message-ID: <1225389460.19891.31.camel@maia.lan>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	 <1225343538.10803.9.camel@maia.lan>
	 <18697.41702.241183.408377@lisa.zopyra.com>
	 <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se>
	 <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se>
	 <2008-10-30-15-23-16+trackit+sam@rfc1149.net>  <4909CABD.1040708@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Samuel Tardieu <sam@rfc1149.net>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:59:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvbnX-0007LO-GO
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbYJ3R5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYJ3R5x
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:57:53 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:38848 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbYJ3R5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:57:52 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 2626621C83C; Fri, 31 Oct 2008 06:57:51 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id CA62A21C469;
	Fri, 31 Oct 2008 06:57:42 +1300 (NZDT)
In-Reply-To: <4909CABD.1040708@op5.se>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99512>

On Thu, 2008-10-30 at 15:54 +0100, Andreas Ericsson wrote:
> > I am curious of what other people workflows are. Do you often push
> > multiple branches at the same time?
> 
> Quite often, yes.
> 
> > More often than one at a time?
> 
> No.
> 
> > Many times a day?
> > 
> 
> Define "many". Perhaps as often as 2-3 times per day. Not very often,
> but frequent enough that I definitely want some short sweet way of
> doing it.

I think your use case is the unusual one, not the common one.  Most
users will want the moral equivalent of "push = HEAD" by default, and
those who prefer the existing behaviour can configure it.

Sam.
