From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Bash v4 on msysgit?
Date: Fri, 09 May 2014 11:37:13 +0200
Message-ID: <536CA1C9.1090201@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 11:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WihF6-0007eg-4I
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbaEIJhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 05:37:19 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59701 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752652AbaEIJhS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 05:37:18 -0400
Received: from p5ddc3d47.dip0.t-ipconnect.de ([93.220.61.71] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WihEy-0008E3-V1; Fri, 09 May 2014 11:37:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1399628238;85e4b9c3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248544>

> How can I get Bash v4 for msysgit 1.9.2? I need it for 'globstar'
> shopt support. Thanks in advance.

Unfortunately you can't.
Newer bash versions don't work with the current msys layer.

See http://mingw.5.n7.nabble.com/bash-4-x-for-MSYS-td5605.html for a
more in depth discussion.
