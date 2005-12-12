From: Darrin Thompson <darrint@progeny.com>
Subject: Re: [PATCH 2/2] diff-delta.c: allow delta with empty blob.
Date: Mon, 12 Dec 2005 16:12:51 -0500
Message-ID: <1134421972.5928.48.camel@localhost.localdomain>
References: <1134404990.5928.4.camel@localhost.localdomain>
	 <7vacf6hwwc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 22:14:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eluyb-0000qx-UN
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 22:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVLLVMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 16:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVLLVMv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 16:12:51 -0500
Received: from zealot.progeny.com ([216.37.46.162]:18338 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1751284AbVLLVMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 16:12:50 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id E4F52636AE; Mon, 12 Dec 2005 16:12:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacf6hwwc.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13541>

On Mon, 2005-12-12 at 12:40 -0800, Junio C Hamano wrote:
>  Could you try this patch?  It is marked as 2/2 but 1/2 is a
>  test script to reproduce the problem with the current code,
>  which this patch is supposed to fix, and this should be the
>  only fix you need.

I'm almost out of time for today. Possibly tomorrow I can get to it.

--
Darrin
