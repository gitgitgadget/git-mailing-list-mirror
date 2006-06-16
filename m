From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: Security problem
Date: Fri, 16 Jun 2006 15:18:46 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606161518.47149.lan@academsoft.ru>
References: <200606151709.22752.lan@academsoft.ru> <200606161237.21997.lan@academsoft.ru> <Pine.LNX.4.64.0606152300460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 10:19:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr9Xu-0005z6-SQ
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 10:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWFPITB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 04:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFPITA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 04:19:00 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:22406 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1751143AbWFPITA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 04:19:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 0B3D6BDD4; Fri, 16 Jun 2006 15:18:59 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30634-09; Fri, 16 Jun 2006 15:18:49 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id E228FBDC8; Fri, 16 Jun 2006 15:18:49 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id DE8748DA2841; Fri, 16 Jun 2006 15:18:49 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 8574A8DA2840;
	Fri, 16 Jun 2006 15:18:47 +0700 (NOVST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0606152300460.5498@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21935>

> So git certainly gives you the option to be really anal, and doesn't even
> make it needlessly hard or expensive, even with large repositories.

Thanks for detailed description. Now I can sleep without any worry about my 
repo :-)
