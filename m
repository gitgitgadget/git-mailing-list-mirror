From: Belmar-Letelier <luis@itaapy.com>
Subject: git-clone and cg-clone
Date: Thu, 06 Apr 2006 20:10:00 +0200
Message-ID: <44355978.3080205@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 06 20:10:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRYw1-00058N-TZ
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 20:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWDFSKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 14:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDFSKM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 14:10:12 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:49926 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932219AbWDFSKK
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 14:10:10 -0400
Received: from [192.168.0.42] (itaapy-255-90.cnt.nerim.net [195.5.255.90])
	by mallaury.nerim.net (Postfix) with ESMTP id C5EB44F3AA;
	Thu,  6 Apr 2006 20:09:49 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: fr, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18476>

Hello

I'm a cogito users,

Since 0.17 to take benefit of cg-switch

I use:

$ git-clone  xxx
$ cg-branch-add origin xxx

instead of

$ cg-clone xxx

becauce cg-clone did not fetch all the heads.

Is there a better way to do this ?

-- 
Luis Belmar-Letelier
