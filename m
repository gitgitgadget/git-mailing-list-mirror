From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Which freedesktop.org "design flaws" in git are still relevant?
Date: Fri, 29 Feb 2008 17:52:20 -0500
Message-ID: <76718490802291452x7b9c91adlb48c55f5737a1a33@mail.gmail.com>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>
	 <m3hcfrjwnk.fsf@localhost.localdomain>
	 <alpine.LNX.1.00.0802291614230.19665@iabervon.org>
	 <76718490802291440x60896c93i26d8d0c2cf5678b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Elijah Newren" <newren@gmail.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:53:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVE6B-0006pp-Jm
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760259AbYB2Ww0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbYB2WwZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:52:25 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:14040 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbYB2WwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:52:25 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1928618gve.37
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5Hj5O+RyK+HGzp6JZxgOzo3e2ZMbzZrC0hLKImBub/I=;
        b=wDXdBna7v7pxEqinHyJL4AaGGSaiQCRcGoaDMyuLdnPhOKyeFP2NQEdL5/rB45UVr6tC15CK/Y7tGXck7Ot8k1lHxCpEF/7IYDIBo080M/QfB4tMg46ZMY+GZFmm/d8fLuy9faopUb98fg9uGUHQIWQ0tegdZCCTEfqjqimeqpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YU/jrw3iE6JzVnDpaDYi8KdiNEpqWIvNXrI8nbrLjqTpHWRxvcN1oFo5m9wNEl5CpP2BUgS7s8TVj34OucYiw61iGNQz/jKE9CeTlJ1CBp0Zn56hl4v57pYcwwdyk+aIvE3vsV/nz0WNZiH26xHcP2X/lIuIp6/8ywSTWCmjY8Q=
Received: by 10.115.78.1 with SMTP id f1mr6967697wal.100.1204325541485;
        Fri, 29 Feb 2008 14:52:21 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Fri, 29 Feb 2008 14:52:20 -0800 (PST)
In-Reply-To: <76718490802291440x60896c93i26d8d0c2cf5678b2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75583>

On Fri, Feb 29, 2008 at 5:40 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
>     fetch = refs/heads/pu:/refs/heads/pu-readonly

Obviously missing a '+', though I'm not sure why anyone would do
this anyway.

j.
