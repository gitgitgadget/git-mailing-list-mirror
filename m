From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] INSTALL: git-p4 doesn't support Python 3
Date: Sat, 19 Jan 2013 09:23:39 -0500
Message-ID: <20130119142339.GA15314@padd.com>
References: <20130119120158.GH31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jan 19 15:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwZJS-0003NH-El
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 15:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab3ASOWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 09:22:04 -0500
Received: from honk.padd.com ([74.3.171.149]:54599 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab3ASOWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 09:22:03 -0500
Received: from tic.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id C2E3720B7;
	Sat, 19 Jan 2013 06:22:01 -0800 (PST)
Received: by tic.padd.com (Postfix, from userid 1000)
	id 17A8310072A; Sat, 19 Jan 2013 09:23:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130119120158.GH31172@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213978>

john@keeping.me.uk wrote on Sat, 19 Jan 2013 12:01 +0000:
> git-p4 supports Python 2.6 and later versions of Python 2.  Since Pyhton
> 2.8 will never exist [1], it is most concise to just list the supported
> versions.
> 
> [1] http://www.python.org/dev/peps/pep-0404/
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
[..]
> -	- Python version 2.6 or later is needed to use the git-p4
> +	- Python version 2.6 or 2.7 is needed to use the git-p4

This is indeed more accurate.

Acked-by: Pete Wyckoff <pw@padd.com>
