From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 14:51:29 +0200
Message-ID: <m3ejtfvwvi.fsf@defiant.localdomain>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
	<7vpsczuxj9.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com>
	<7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net>
	<20061011091411.GA21527@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 14:52:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXdYv-0004xG-Rq
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 14:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWJKMvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWJKMvf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 08:51:35 -0400
Received: from khc.piap.pl ([195.187.100.11]:47314 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751245AbWJKMvb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 08:51:31 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 78964D15A; Wed, 11 Oct 2006 14:51:29 +0200 (CEST)
To: Jeff King <peff@peff.net>
In-Reply-To: <20061011091411.GA21527@coredump.intra.peff.net> (Jeff King's message of "Wed, 11 Oct 2006 05:14:12 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28713>

Jeff King <peff@peff.net> writes:

> +			die "You can't bisect a seeked tree!"

Just to make sure: dictionary.reference.com doesn't know the
"seeked" word (I don't either though that may be normal).

Should it read "sought"? Not sure what does the message talk about.
-- 
Krzysztof Halasa
