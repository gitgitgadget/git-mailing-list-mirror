From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc
 warning
Date: Thu, 09 Dec 2010 18:17:20 +0000
Message-ID: <4D011D30.4070405@ramsay1.demon.co.uk>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk> <20101204205206.GB3170@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 19:17:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQl3r-0000jR-Tm
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 19:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab0LISRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 13:17:25 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48977 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756836Ab0LISRZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 13:17:25 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PQl3T-0001u6-os; Thu, 09 Dec 2010 18:17:24 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20101204205206.GB3170@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163302>

Jonathan Nieder wrote:
> 
> Just for the record (I assume you are already aware of this):
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/133278/focus=133422
>  http://thread.gmane.org/gmane.comp.version-control.git/124676/focus=124803

Yes

> I personally feel lukewarm about this kind of change.  

OK.

Junio, could you please drop patches 5-14 from the series; the first four patches
are the important ones and I'd rather they didn't get held up. Thanks!

ATB,
Ramsay Jones
