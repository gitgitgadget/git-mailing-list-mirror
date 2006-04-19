From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Wed, 19 Apr 2006 15:51:47 +1200
Message-ID: <46a038f90604182051n4a16ee9atd2577d658befc335@mail.gmail.com>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
	 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
	 <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 05:51:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW3jM-0006gY-0S
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 05:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDSDvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 23:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDSDvt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 23:51:49 -0400
Received: from wproxy.gmail.com ([64.233.184.225]:51891 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbWDSDvs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 23:51:48 -0400
Received: by wproxy.gmail.com with SMTP id i12so84630wra
        for <git@vger.kernel.org>; Tue, 18 Apr 2006 20:51:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lINXj+3qWHFSnaXFmeZhJw99FZ/Q7YHQ8iTBtLibeGo9FAfpsSDqyHDTfcvlWe1Nh/I4tTCwvlwY1BpbevWMJcSJj1tG7+9iKgEEia2toeWlmc+DYebyyENnaBAuEbYLZAAlYLUXhVu/ZtLpcCCnMtG9eZSZMtKEwhh7YGTetEA=
Received: by 10.54.82.2 with SMTP id f2mr3921768wrb;
        Tue, 18 Apr 2006 20:51:47 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Tue, 18 Apr 2006 20:51:47 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18902>

<wishlist>
  What about support for diffing a subtree?

      git diff v2.2:net/appletalk v2.9:net/appletalk-ng

</whishlist>

cheers,


martin
