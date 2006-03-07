From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: git-status too verbose?
Date: Tue, 7 Mar 2006 11:05:47 +0530
Message-ID: <20060307053547.GK6346@always.joy.eth.net>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com> <7vacc36r4v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 06:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGUiV-00032N-OU
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 06:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWCGF0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 00:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWCGF0h
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 00:26:37 -0500
Received: from proof.pobox.com ([207.106.133.28]:31142 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1751188AbWCGF0g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 00:26:36 -0500
Received: from proof (localhost [127.0.0.1])
	by proof.pobox.com (Postfix) with ESMTP id EFC368F9D8;
	Tue,  7 Mar 2006 00:26:35 -0500 (EST)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by proof.sasl.smtp.pobox.com (Postfix) with ESMTP id 353C023566;
	Tue,  7 Mar 2006 00:26:32 -0500 (EST)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Tue, 7 Mar 2006 11:05:47 +0530
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacc36r4v.fsf@assigned-by-dhcp.cox.net>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17320>

On Mon, Mar 06, 2006 at 04:21:52PM -0800, Junio C Hamano wrote:
> 			HEAD->index	index->files
> 	------------------------------------------------
> 	hello.c		unmodified      modified
>         world.c		modified	unmodified
> 	frotz.c		new		unmodified
>         ...
> 	garbage.c~	???		n/a

For what it's worth, this chart immediately made sense to me and I would
prefer it to the current git-status output.
