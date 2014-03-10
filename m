From: Dennis Luehring <dl.soluz@gmx.net>
Subject: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 11:07:21 +0100
Message-ID: <531D8ED9.7040305@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 11:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMx7I-0002SM-2m
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 11:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbaCJKHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 06:07:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:58877 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbaCJKHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 06:07:23 -0400
Received: from [192.168.178.20] ([94.218.43.92]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LuKHz-1XLgQ33NyR-011gOr for <git@vger.kernel.org>;
 Mon, 10 Mar 2014 11:07:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Provags-ID: V03:K0:eK8oZ8qZMJB5Z8qhTzxU0Ig2geN0x6WhUHA9r32AhPWF7LAnD+A
 /jCm24dSSu4dafU8FgBHDmZhI/newooJydDoRrK/IZqnILm5Y2vSG8C+kGcUQfN4APg6gGN
 Msx5FL6RlFXczagS1FOUZ4Ugc09lU7QFIMqkteiFEkqrwGDVW6EZM187N4l3mksYRHMP8vp
 CsgKBq4+f126B8yDG9vCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243723>

according to these blog posts

http://www.infoq.com/news/2014/01/facebook-scaling-hg
https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/

mercurial "can" be faster then git

but i don't found any reply from the git community if it is a real problem
or if there a ongoing (maybe git 2.0) changes to compete better in this case
