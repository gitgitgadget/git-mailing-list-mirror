From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Multi-ancestor read-tree notes
Date: Thu, 08 Sep 2005 12:16:05 -0500
Message-ID: <1126199765.3984.1.camel@localhost.localdomain>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 22:10:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDSir-0008Jf-7L
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 22:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVIHUKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVIHUKI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 16:10:08 -0400
Received: from zealot.progeny.com ([216.37.46.162]:63655 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S964979AbVIHUKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 16:10:07 -0400
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id E8B69636AB; Thu,  8 Sep 2005 15:10:05 -0500 (EST)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8214>

On Mon, 2005-09-05 at 01:41 -0400, Daniel Barkalow wrote:
> I've got a version of read-tree which accepts multiple ancestors and does 
> a merge using information from all of them.

Do the multiple ancestors have to share a common parent? More to the
point, is this read-tree any more friendly to baseless merges?

--
Darrin
