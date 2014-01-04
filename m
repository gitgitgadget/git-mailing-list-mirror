From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Documentation/gitmodules: Only 'update' and 'url' are
 required
Date: Sat, 4 Jan 2014 23:17:54 +0100
Message-ID: <20140104221754.GB5697@book-mint>
References: <c22c81472bb8b8943d34bdf1ac9ef61f5a489a16.1388773808.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Jan 04 23:18:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzZXq-0007du-30
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 23:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbaADWSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 17:18:08 -0500
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:55993 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbaADWSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 17:18:07 -0500
Received: from [77.20.146.74] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzZXb-0003eH-8u; Sat, 04 Jan 2014 23:17:59 +0100
Content-Disposition: inline
In-Reply-To: <c22c81472bb8b8943d34bdf1ac9ef61f5a489a16.1388773808.git.wking@tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239949>

On Fri, Jan 03, 2014 at 10:31:22AM -0800, W. Trevor King wrote:
> From: "W. Trevor King" <wking@tremily.us>
> 
> Before this commit, all the settings fell under the initial "Each
> submodule section also contains the following required keys:".  The
> example shows sections with just 'update' and 'url' entries, but we

You mean:

	...with just 'path' and 'url' entries...

?

Other than that, the patch looks good to me.

Cheers Heiko
