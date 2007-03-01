From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 16:20:31 +0300
Message-ID: <20070301132030.GK57456@codelabs.ru>
References: <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <200703011040.35971.andyparkins@gmail.com> <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <20070301120042.GD63606@codelabs.ru> <7vr6s9qi8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Andy Parkins <andyparkins@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 14:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMlDK-0004E3-Bf
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 14:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbXCANUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 08:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbXCANUp
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 08:20:45 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:64016 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965043AbXCANUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 08:20:44 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMlD7-000GyZ-2j; Thu, 01 Mar 2007 16:20:41 +0300
Content-Disposition: inline
In-Reply-To: <7vr6s9qi8b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41095>

> In case it was unclear, I was saying that "attachment was more
> annoying" than "diff output that does not follow the established
> convention to be applied with patch -p1".  Both I can handle,
> but dealing with the former is more work for me.

Ah, sorry, got it.
-- 
Eygene
