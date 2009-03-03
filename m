From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: First round of UGFWIINI results
Date: Tue, 03 Mar 2009 02:30:36 -0800 (PST)
Message-ID: <m3myc2ucfb.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:32:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRv7-0001eO-F6
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 11:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbZCCKal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 05:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbZCCKal
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 05:30:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:55850 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZCCKak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 05:30:40 -0500
Received: by nf-out-0910.google.com with SMTP id d21so550295nfb.21
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=8ZoGqmJ9VEggIxjFCRtp6oXg4lXXNgvutcYG1aVEFsE=;
        b=WPYWADgwWEIvyZDgZDdACO25P5JxmG03S40FtMSWI5lWvZZ2CIHi1lOT5DoDputrRg
         O6G1PGQ2LLDsijpHIoQYObibXB3OEwJn2pTYf3Kaa2yEnsDruClvzD3hjXOMpNDuyPu8
         f3Rp8u7Ft8ih1JlmmdpAaI2GLxCTcWwK0G3cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AouK1SrlYUjhbFTOSIfJryGoL5A2cNey7nVuVcmamm+5p73TKjrG6uDo22RIFMO6dj
         zKfoC0zUfVBDkCXj7LrJOvwSNIRCNiwgveyQUjlqYlIM++pCWrFLMZMrt35lQgE85eBs
         oS46Fk+6OWRPecj129n/38AWk6PObF3mBcAAI=
Received: by 10.216.20.72 with SMTP id o50mr108433weo.187.1236076237405;
        Tue, 03 Mar 2009 02:30:37 -0800 (PST)
Received: from localhost.localdomain (abwq47.neoplus.adsl.tpnet.pl [83.8.240.47])
        by mx.google.com with ESMTPS id p10sm16443673gvf.1.2009.03.03.02.30.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Mar 2009 02:30:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n23AU2GB019040;
	Tue, 3 Mar 2009 11:30:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n23ATjlL019030;
	Tue, 3 Mar 2009 11:29:45 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112049>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Dear fans of Git,
> 
> a while ago I announced the UGFWIINI contest, a glorious battle of ideas
> how to
> 
> 	Use Git For What It Is Not Indended
> 
> As most of you probably did not find my blog yet, this may come as a
> surprise to you, but it will not be the only surprise in this email.

Errr... URL (of a blog), please?


Another candidate for UGFWIINI contest: Gitorial. Here is explanation

  ...this presentation was captured in the Git revision control
  system. Every commit has a commit message that explains the 'next
  slide' of the presentation. People can then view diffs between
  commits to quickly see what changed.

Well, it uses GitHub, not only Git, but...

http://github.com/blog/367-clojure-gitorial
http://larrytheliquid.com/2009/03/02/presenting-clojure-with-a-gitorial

........................................................................

And similar thing: Homoiconic. Here is explanation

  Homoiconic is an experiment in publishing code and words about code
  on a small scale.

  When I write, I will add files to the homoiconic git repository,
  organized by date. Code will be included in the posts and also in
  the folder with the posts that discuss them, so it's easy to
  download what you like. You can even download the entire thing as an
  archive if you want.

http://github.com/raganwald/homoiconic
-- 
Jakub Narebski
Poland
ShadeHawk on #git
