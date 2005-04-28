From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: Cogito nit: cg-update should default to "origin".
Date: Thu, 28 Apr 2005 10:22:57 +0200
Message-ID: <d4q66k$gv9$1@sea.gmane.org>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <42702F20.3050200@dwheeler.com> <20050428005337.GA3422@pasky.ji.cz> <42705F3C.1000208@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 28 10:20:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR4FU-0000X3-MX
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 10:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVD1IZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 04:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVD1IZD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 04:25:03 -0400
Received: from main.gmane.org ([80.91.229.2]:48029 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261329AbVD1IY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 04:24:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DR4EI-0000N9-AD
	for git@vger.kernel.org; Thu, 28 Apr 2005 10:18:38 +0200
Received: from 217-211-177-12-o871.telia.com ([217.211.177.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 10:18:38 +0200
Received: from holmsand by 217-211-177-12-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 10:18:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217-211-177-12-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <42705F3C.1000208@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David A. Wheeler wrote:
> So, how about this:
> 
> cg-revert [FILE...] or
> cg-revert [-d|--deleted]|[-a|--all]
>   Reverts some/all files back to the HEAD's state, eliminating changes

That's very good (and much better than my idea).

/dan

