From: Tim Visher <tim.visher@gmail.com>
Subject: Make a non-bare repo bare.
Date: Wed, 15 Jul 2009 17:43:54 -0400
Message-ID: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 23:46:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRCGh-0000LV-D7
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 23:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbZGOVnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbZGOVnz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 17:43:55 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:39375 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbZGOVny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 17:43:54 -0400
Received: by yxe14 with SMTP id 14so5917391yxe.33
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=lVpu1Ez0fH/Dt0xlRyDDcmv/4Av3ljmv29R4u4Slokk=;
        b=wu5gILVzTqEBuD5wQky1IpvryO3eeOSAsMYFkk48qXWQWCxVUnJz7W9vNF6ugOxoNg
         /bQeamReRJ+2kjC8cBqBRIYwOHUjquwfg/hEBKlEWNFRdFtKsHqdum7HqIsOIL0jYS0C
         EXjNN6tEVaDZ/dWQzeJN/EFQVZL7Mip9+GxZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Ra4vlIjey/dETMQ1OsAI6ESB8yXMKkGoT+YM5ZLOqKGVT0zxah7kiCGXVcGoa216A7
         naJQHVsLSCXOROTPwvtvpwHJOfUyO1G7VC18PYPelHDZw+LAS0bOes3c778hK1i0X78d
         cXYZEYd2VUo1YluVRYb5kPDpnuosBlf1oPL+E=
Received: by 10.100.241.8 with SMTP id o8mr10812563anh.102.1247694234176; Wed, 
	15 Jul 2009 14:43:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123335>

Hello Everyone,

I recently had occasion to make a previously non-bare repo bare.  Is
there any way to do this?  It will not allow me to delete a branch
that I'm on so I wasn't sure how to proceed.

Thanks!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
