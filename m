From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 06 Sep 2008 08:36:40 -0700 (PDT)
Message-ID: <m38wu5p9q4.fsf@localhost.localdomain>
References: <20080906150723.GA31540@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 17:37:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbzrC-0002Bm-Bm
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 17:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbYIFPgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 11:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbYIFPgn
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 11:36:43 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:56172 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYIFPgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 11:36:42 -0400
Received: by mu-out-0910.google.com with SMTP id g7so708858muf.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=7WlZwarul2qSrH/9IIXCIWirt2Fie+GAfbcqRz41MwM=;
        b=S7N3oLqkkm/5faiOilhrg7pDBPe7YsHqhy0WvWU2jukiA0GrP7sSS4szUP70Pz+68E
         NsDoYXywd4QChxVBQZfmXHqFaIQylrOTwhp/mlVK69I1mQCmJTiU2zBPpanB+YFhGL08
         4/7u9kps2RuylwNQ4PgaeeFiVDtA7dchX16a8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=BvoCWXyLXyfL/7160c+PKkw18LThF0Mt2SLbsAKCbQUkVuJS1Fzg9rWhldvDL2S0m8
         PLrO4+PnIp/+070640WwbDLF3NDNUnQjHmHQoNFGXRjUl9wtzVPuQ8oP0yE8Fx1K7Wff
         IbeFiqgEOmzwNDqBj5pu7dPZJdf6sNRHrXajk=
Received: by 10.103.20.7 with SMTP id x7mr8827522mui.75.1220715400859;
        Sat, 06 Sep 2008 08:36:40 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.234.117])
        by mx.google.com with ESMTPS id y6sm7706562mug.7.2008.09.06.08.36.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 08:36:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m86Fabfv003931;
	Sat, 6 Sep 2008 17:36:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m86FaawU003928;
	Sat, 6 Sep 2008 17:36:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080906150723.GA31540@dervierte>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95077>

Steven Walter <stevenrwalter@gmail.com> writes:

> After starting yap several weeks ago, I feel it has reached a level of
> maturity that makes it suitable for public consumption.  yap is three
> things, in increasing order of relevance:
> 
>     1) A git porcelain implemented in python
>     2) A git porcelain with a friendlier, more orthogonal interface
>     3) A extensible git porcelain

A question, and a request.

First, a question: how your yap porcelain differs from efforts of
EasyGit (eg) and Pyrite?

And a request: could you add (short) information about your work to
Git Wiki: http://git.or.cz/gitwiki/InterfacesFrontendsAndTools,
of course in the "Version Control Interface layers" section? 

TIA.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
