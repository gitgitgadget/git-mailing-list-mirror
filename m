From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 08 May 2014 22:48:26 +0200
Message-ID: <536BED9A.6020100@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: dturner@twopensource.com, GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 08 22:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVF3-0005wU-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbaEHUs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:48:29 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:37668 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754658AbaEHUs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2014 16:48:29 -0400
Received: from p5ddc3d47.dip0.t-ipconnect.de ([93.220.61.71] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WiVEx-0004Ql-B9; Thu, 08 May 2014 22:48:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1399582109;972371ed;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248444>

> I also have not tried on Windows.  I put in an email to the one
> Windows-using friend I can think of to ask her to give Windows Explorer
> (or whatever it's called these days) a try.  My guess (based on a quick
> Google search) would be is that it works without error, but I will send
> an update if I hear otherwise.

A case-only changing rename in the windows explorer in Win7 works
perfectly without any problems.
