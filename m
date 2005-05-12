From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 20:20:32 -0400 (EDT)
Message-ID: <3090.10.10.10.24.1115857232.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx>  <428291CD.7010701@zytor.com>  
     <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
    <3004.10.10.10.24.1115855130.squirrel@linux1>
    <42829D9F.3010403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 02:13:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1KN-00060B-Mt
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVELAUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVELAUl
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:20:41 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:28654 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261236AbVELAUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:20:36 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512002032.QLKZ11463.simmts6-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 20:20:32 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4C0KVAd004924;
	Wed, 11 May 2005 20:20:31 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 20:20:32 -0400 (EDT)
In-Reply-To: <42829D9F.3010403@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 8:04 pm, H. Peter Anvin said:
> Sean wrote:
>>
>> Amongst other issues and complexity this will introduce.   This is
>> really a solution in search of a problem anyway.
>>
> You mean repoid?

Hey Peter,

   Yes, it will create just as many problems as it sets out to solve. 
Actually, I still don't know what problem is being addressed by the
current proposal.

Sean


