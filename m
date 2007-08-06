From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Some ideas for StGIT
Date: Mon, 6 Aug 2007 11:01:09 +0100
Message-ID: <b0943d9e0708060301q33b013efwc28d1c28d31ceb80@mail.gmail.com>
References: <1186163410.26110.55.camel@dv>
	 <200708031914.04344.andyparkins@gmail.com>
	 <1186206085.28481.33.camel@dv>
	 <20070804080801.GD30277@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 12:01:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHzOl-0007U4-CO
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 12:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761592AbXHFKBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 06:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761608AbXHFKBM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 06:01:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15036 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbXHFKBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 06:01:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so613009ugf
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 03:01:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPpuOdeNuqTFx+tMqDp/q2fT9TW08uepaT7FB48+dPr1eK96Bf2BJs4KTDdwHFtPeW0DBHTG6y8q2ilBHxtxdIHfVfM0fbc85nW8LvSIdUmJROER21fJwFhpIfjK23NQ9ZK3kqd7omzEdMQCZkxhLhcNRYqLJTwHAbMY7eCDIhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O0ppUAl2XFFtLMklpWeg6FAojDPZXvsaBBGSmcIYYg9ytuAk0FLIjy3bxAxt0Nd8bxvlnG6F0+Ue9qeo14qVtPvycKuCi4vrFHVgG5qT4JHnFZE6ctFi8b003dfqMBG/4yhcj+zkSQLtqIXxpQ5h/w/+ZpS8HvJ62kYDhn4jzBM=
Received: by 10.66.221.6 with SMTP id t6mr5088925ugg.1186394469463;
        Mon, 06 Aug 2007 03:01:09 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Mon, 6 Aug 2007 03:01:09 -0700 (PDT)
In-Reply-To: <20070804080801.GD30277@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55134>

On 04/08/2007, Yann Dirson <ydirson@altern.org> wrote:
> FWIW, I have written a couple of scripts to help moving stuff around
> between patches.  Those are not yet integrated in stgit proper, and it
> happens that the 0.13 tarball does not contain them, they are only
> available from the git tree (better use my tree[1], since I updated them
> recently).

That's probably because I haven't updated the MANIFEST.in file (I
don't look in the contrib directory much :-)).

-- 
Catalin
