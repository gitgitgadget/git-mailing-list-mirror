From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: about git server & permissions
Date: Tue, 16 Aug 2005 18:17:18 +0800
Message-ID: <4b3406f050816031720cbaf4c@mail.gmail.com>
References: <20050729082941.GD32263@mythryan2.michonline.com>
	 <20050815045546.GA7001@mythryan2.michonline.com>
	 <7vr7cv7p61.fsf@assigned-by-dhcp.cox.net>
	 <20050815065833.GE7001@mythryan2.michonline.com>
	 <7v7jen6545.fsf@assigned-by-dhcp.cox.net>
	 <20050815080218.GG7001@mythryan2.michonline.com>
	 <7vhddr397g.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0508151453100.21501@iabervon.org>
	 <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0508161158400.3026@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 16 12:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4yVV-0000aL-TK
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 12:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVHPKRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 06:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVHPKRT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 06:17:19 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:47338 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965193AbVHPKRS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 06:17:18 -0400
Received: by zproxy.gmail.com with SMTP id r28so880430nza
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 03:17:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TOf4bGGrY4yfUgSjDAkhru7boH0bVBTLq1wmi0KIaeoMSreP8KE4K0Zg1hD3tJn6hnzuLop/scyn1TDlhIFRkOzRLWDO8KTYneCZqFiCsK+neGQRBzO5ZyE1yncaL2KookF0m8R3xQUBioav228+FiDjKr81p1r5MrRmfWVvXe0=
Received: by 10.36.115.20 with SMTP id n20mr6057357nzc;
        Tue, 16 Aug 2005 03:17:18 -0700 (PDT)
Received: by 10.37.18.66 with HTTP; Tue, 16 Aug 2005 03:17:18 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508161158400.3026@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Is there any guide or advise for deploy git server ? Especially
http/https/ssh server.

How do I set repository permissions correctly?

cauchy
