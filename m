From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Change encoding of RSS feed to latin-1
Date: Sat, 19 Nov 2005 21:56:22 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511192156.23259.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 19 20:57:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdYp7-00048c-Un
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 20:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKST4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 14:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKST4b
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 14:56:31 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:44206 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750768AbVKST4a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 14:56:30 -0500
Received: from [85.101.239.128] (unknown [85.101.239.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 04F64AB67B
	for <git@vger.kernel.org>; Sat, 19 Nov 2005 21:56:23 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.92
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12349>

Ok,

As the other thread grew into merits of using UTF-8 I think best fix for now 
is putting encoding=latin-1 into RSS feed so everyone is happy. After all its 
latin-1 encoded data not utf-8. Anyone disagrees? Can we now please 
fix/change gitweb so xml parsers can parse it without workarounding?

Regards,
ismail
