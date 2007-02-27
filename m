From: Sam Vilain <sam@vilain.net>
Subject: Re: Worrisome bug trend
Date: Wed, 28 Feb 2007 09:25:55 +1300
Message-ID: <45E493D3.7060407@vilain.net>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8wW-0002cJ-HX
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbXB0U0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXB0U0m
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:26:42 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:55881 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbXB0U01 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:26:27 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8248A13A384; Wed, 28 Feb 2007 09:26:23 +1300 (NZDT)
Received: from [192.168.1.4] (unknown [203.110.28.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id BA5E513A342;
	Wed, 28 Feb 2007 09:26:12 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40787>

Junio C Hamano wrote:
> I take that as a sign that git hasn't been exercised well and
> yet more ancient bugs are sleeping, waiting to be triggered, not
> as a sign that we are very careful and adding only small number
> of risky new code in the releases.
>   

No! It's a sign that there aren't enough tests :)

Maybe investigate the coverage of the test suite?

Sam.
