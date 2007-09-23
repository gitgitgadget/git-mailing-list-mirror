From: in-call@gmx.net
Subject: Re: Uninstalling Git
Date: Sun, 23 Sep 2007 21:47:47 +0200
Message-ID: <46F6C2E3.8020405@gmx.net>
References: <46F6B0CC.3040000@gmx.net> <Pine.LNX.4.64.0709232029490.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 21:48:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZXQr-0002Kp-KX
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXIWTrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbXIWTrv
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:47:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:40697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752047AbXIWTru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 15:47:50 -0400
Received: (qmail invoked by alias); 23 Sep 2007 19:47:48 -0000
Received: from unknown (EHLO [192.168.1.3]) [89.128.218.41]
  by mail.gmx.net (mp020) with SMTP; 23 Sep 2007 21:47:48 +0200
X-Authenticated: #11018450
X-Provags-ID: V01U2FsdGVkX1/vX6JsE2PvMxZthYLAvthj6dacCceF2oy414J+v7
	d7m3OHMDytiMWv
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
In-Reply-To: <Pine.LNX.4.64.0709232029490.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58983>

Hello!

Oh! great solution! I didn't know this tool, I'll do that! Thanks a lot!


Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 23 Sep 2007, in-call@gmx.net wrote:
> 
>> $ make configure
>> $ ./configure --prefix=/usr/local
>> $ make all doc
>> $ sudo make install install-doc
>>
>> First, I'd like to uninstall the thing completely, how do I do that?
> 
> I'd use checkinstall to install it (again), and then use the distro's 
> regular tools; in case of Ubuntu, that would be dpkg I believe.
> 
>> Second, what would be the correct procedure to follow if I would like 
>> just to upgrade to a newer version? install over the older perhaps? Is 
>> that always safe in the sense that there won't be any dangling piece of 
>> bin nor doc?
> 
> On Linux this should be safe at all times.
> 
> Hth,
> Dscho
> 
