From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: git-rev-tree ---stdin -s -p broken
Date: Wed, 25 May 2005 14:49:18 +0200
Message-ID: <20050525124918.GD24325@cip.informatik.uni-erlangen.de>
References: <20050525121738.GC24325@cip.informatik.uni-erlangen.de> <20050525123925.GA1481@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 14:50:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DavJK-0004MH-9R
	for gcvg-git@gmane.org; Wed, 25 May 2005 14:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVEYMtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 08:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVEYMtX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 08:49:23 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:40924 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262332AbVEYMtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 08:49:20 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4PCnJS8012384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 May 2005 12:49:19 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4PCnIUN012383;
	Wed, 25 May 2005 14:49:18 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
Mail-Followup-To: Kay Sievers <kay.sievers@vrfy.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050525123925.GA1481@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Works for me with the latest git.  Does git-rev-list work?  Try
> strace'ing git-diff-tree.

false alert. With git HEAD it works. Strange I thought I had verified
that in the first place. Thanks.

	Thomas
