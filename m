From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH svnrdump-standalone] Sync with upstream
Date: Fri, 6 Aug 2010 21:30:26 -0500
Message-ID: <20100807023026.GA3111@burratino>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
 <20100715105527.GC22574@debian>
 <20100806175709.GA2683@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 04:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhZCm-00083y-IO
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 04:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab0HGCbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 22:31:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44638 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0HGCby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 22:31:54 -0400
Received: by gyg10 with SMTP id 10so3043677gyg.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=426Vw7kuzDICf1Dj9htXG/1gx8sN7qsxZG5+XbvKTGw=;
        b=IfDLjZaulPQclAD5ismzSBju7yAXa3EeitYBCLp8pIeJbSOn/U81jvOQ1vn1rTWWh+
         t0dOgWy0fOrlTFT73cK6ZG7gkkjHqErD17DD/gxmm15E1BEn65v/e/7LCclSaTzwYpIQ
         5xZ5C8ZOIx9odBBKc+8woRbU9Qjcsqgy/yiUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KQJvU96yaViEZPQGcqWSafIDJrhhwwYngtSOEv+JlZ8pKcxS108FtzrPoydOVgErKZ
         BtvGwC8aOp1/bet0IfSCUeifY2LXGhvvbw7aqv7qNExIIRJ0CoWlMHRvHtbJ+1pl0MHj
         Yk4C3v+2CVdD7Y6CZBSZIE2uXK9TywQO6LZc0=
Received: by 10.151.130.20 with SMTP id h20mr14650521ybn.308.1281148313344;
        Fri, 06 Aug 2010 19:31:53 -0700 (PDT)
Received: from burratino ([64.134.175.203])
        by mx.google.com with ESMTPS id v7sm225096ybe.19.2010.08.06.19.31.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 19:31:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806175709.GA2683@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152834>

Jonathan Nieder wrote:

> Caveats: Most load tests do not pass.

They pass now.  Thanks for the help!

You can

  git clone git://repo.or.cz/svnrdump/jrn.git

for the tree.  The todo branch documents how to revive the
git-svn branches.

Have fun,
Jonathan
