From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Packing on kernel.org
Date: Sat, 01 Oct 2005 07:21:39 -0700
Message-ID: <433E9B73.3040807@zytor.com>
References: <Pine.LNX.4.64.0509302320560.3378@g5.osdl.org> <068ea79fc648433faa44a6d4cc287614@cream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, users@kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 16:22:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELiFo-000848-8o
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 16:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVJAOV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 10:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVJAOV5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 10:21:57 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:905 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1750705AbVJAOV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 10:21:56 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j91ELdJv012208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Oct 2005 07:21:40 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Martin Coxall <quasi@cream.org>
In-Reply-To: <068ea79fc648433faa44a6d4cc287614@cream.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9597>

Martin Coxall wrote:
> Was there an cron process or kernel.org that should be repacking the 
> public repositories periodically?

No, too many people complained.

> The git/cogito/sparse/linux-2.6 repositories all now have several 
> thousand unpacked objects a piece, and it takes so long to do an http 
> clone it's not even funny.

HARP: Please pack your repositories periodically.  PLEASE.  It matters 
especially now when kernel.org is down one server.

If your username is high on this list, it's imperative that you pack 
your trees:

brodo                 197469
wim                   184343
marcelo                68442
jgarzik                59860
lm                     39680
mpm                    38995
pavel                  37624
lenb                   36406
hch                    34037
davem                  27671
jejb                   23553
willy                  21626
pasky                  17019
sfrench                15912
smurf                  15236
acme                   12504
torvalds                8834
aegl                    7369
ericvh                  6750
roland                  6296
airlied                 6053
chrisw                  5619
axboe                   5221
dwmw2                   4101
gregkh                  3659
dtor                    3537
hpa                     3350
paulus                  2074
perex                   1999
bart                    1955
cvaroqui                1537
kay                     1250
junio                   1119
sam                     1073
kkeil                   1050

	-hpa
