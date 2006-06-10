From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 20:16:35 -0400
Message-ID: <9e4733910606091716q67d4c5f9ra807b712d871e562@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
	 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
	 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
	 <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
	 <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606091640200.5498@g5.osdl.org>
	 <9e4733910606091700s49018cd5p3b66f8ef51b22d2e@mail.gmail.com>
	 <Pine.LNX.4.64.0606091710560.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 02:16:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1For9c-0007Mr-BT
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWFJAQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWFJAQh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:16:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:24031 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932604AbWFJAQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 20:16:36 -0400
Received: by nz-out-0102.google.com with SMTP id i1so757155nzh
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 17:16:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQAc7PnFW47z2nu3QmVEREmSX1E4qZNQ8GbLEJdAK1CMJH0mSiGMFsnYWgkRJ9zwq3CFZ5o5nd0YsNuwzAPp90NnQsXETWG1NosF3x97bBzAN4CAbnRctewE/bXJUO0NWAjixoU0Sg1oEzSqbAbeChwwr2s8VShL7h1DRUfyZ+M=
Received: by 10.37.15.76 with SMTP id s76mr4975747nzi;
        Fri, 09 Jun 2006 17:16:35 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 17:16:35 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091710560.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21572>

I'll apply and give it a test.

They look like this for most of them.

WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/KeyPairAlgorithm.java:1.5=before.
Treated as 'before'
WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/KeyPairGenerator.java:1.5=before.
Treated as 'before'
WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/KeyPairGeneratorSpi.java:1.3=before.
Treated as 'before'
WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/KeyWrapAlgorithm.java:1.8=before.
Treated as 'before'
WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/KeyWrapper.java:1.8=before.
Treated as 'before'
WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/Makefile:1.2=before. Treated as
'before'
WARNING: Invalid PatchSet 151492, Tag JSS_4_0_RTM:
    security/coreconf/HP-UX.mk:1.8=after,
security/jss/org/mozilla/jss/crypto/NoSuchItemOnTokenException.java:1.3=before.
Treated as 'before'



-- 
Jon Smirl
jonsmirl@gmail.com
