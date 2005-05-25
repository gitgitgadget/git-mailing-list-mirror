From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 21:17:21 +0200
Message-ID: <20050525191721.GC22213@cip.informatik.uni-erlangen.de>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org> <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org> <20050525090616.GB27025@elte.hu> <7vpsvfktiw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 25 21:17:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1Ly-0001zu-VR
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVEYTRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVEYTRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:17:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:32429 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261532AbVEYTRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:17:22 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4PJHLS8008817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 25 May 2005 19:17:21 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4PJHLYo008816
	for git@vger.kernel.org; Wed, 25 May 2005 21:17:21 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vpsvfktiw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

>     return !!some_function();

I actually wanted to send a diff to get rid of this thing from
sha_file.c :-)

	Thomas
