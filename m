From: Zhi Li <lizhi1215@gmail.com>
Subject: how can I push a sub-tree
Date: Thu, 17 Dec 2009 17:50:05 +0800
Message-ID: <2986b3940912170150o17118a07i8f91e785c08e2ac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 10:51:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLCzy-0007Ik-52
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 10:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758245AbZLQJuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 04:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758349AbZLQJuI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 04:50:08 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:37481 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZLQJuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 04:50:06 -0500
Received: by iwn1 with SMTP id 1so1344097iwn.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GFT02psB61XnycnizF271MvDg8CgpYwoXsboO6ffVN0=;
        b=FMHneGXlf9D4pUkBOpuZrGbND+v3TX/Yn6J+87Nn+k3edhwryPO/qMp8kHg5RCf5r8
         J5ul4iaVterVcvQAcziy8cO3smBbOqQBamWtJW0CuJEemXdcR6tlJMGbxkXApg1J7TmR
         1ObD09jcuLVCAMMJgso1ME6LsHgetIGtxqea4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=i4WoY7BearhT+8X5l4IGDSWXs0K0y525a2qlCsyoAmCuCLEfuJAAn/Rg5srTRTC7mI
         7fIFAD8aQ2ZCeFTtmZth9uq9SdB51Z63rD6qDy3rY1xN9Tuijo+x1x93qSWgPSTg2sMx
         hxF6i9EqUkd/41AcIw1JNTN8rPdEZVsVGDI30=
Received: by 10.231.120.90 with SMTP id c26mr569563ibr.1.1261043405322; Thu, 
	17 Dec 2009 01:50:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135364>

Hi,

I tried to find a way to push a sub-tree. In section 6.7 of "Pro Git",
there's a way for pulling a git sub-tree. But I have not found the
opposite: push a git sub-tree. Can someone help me?

BTW, I appologize for not reading archives of this list.

Zhi
