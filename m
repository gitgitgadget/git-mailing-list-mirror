From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Tue, 04 Mar 2008 09:14:38 -0800 (PST)
Message-ID: <m3bq5uif7h.fsf@localhost.localdomain>
References: <20080304051149.GS8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 18:15:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWaje-0007n0-72
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 18:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbYCDROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYCDROo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 12:14:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:19404 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbYCDROn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 12:14:43 -0500
Received: by nf-out-0910.google.com with SMTP id g13so535275nfb.21
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=wI2WvNTNp8ZVmc3d01CsAmUU7d85jg6s/ba32Nd4JtI=;
        b=dbyxJjBW3fs5bhcK9bJ0YjivVot1Ky4wWnW7gETD+fUJdtalmKr/Rnt7IElAZvByDMdwfFHfBdRJuwcYd9z9PXoGMoNi1+r+49UrXc0RmsXwR8NNTDAIAaLiXko0OFi1K7q6iWkugJ3+/cTcVFARC26EW0BdQS3xpvw6/LZaY44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=OK4FGYyyTimWkXmEHL0z73nyCWqqp9duXRHc9yigmrujOjsi4y8hTBJg+//PwQW8pfiCgvX2ZQzP8olsA+ptYAhcAtHdYyr5/LiURt3DPaZTcod7eQkfImlE6aph0o6zUkpR6K6ZVMviO0edD0/uZL+InxoigftulX+S+mroPxM=
Received: by 10.78.192.20 with SMTP id p20mr3809983huf.5.1204650881576;
        Tue, 04 Mar 2008 09:14:41 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id b30sm2229423ika.11.2008.03.04.09.14.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 09:14:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24HEi2n013748;
	Tue, 4 Mar 2008 18:14:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24HEgBs013745;
	Tue, 4 Mar 2008 18:14:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080304051149.GS8410@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76120>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> That is only a starting list of possible projects.  At present Dscho
> and myself are listed as possible mentors for a vast majority of
> these projects.  I'd love to get some more members of the community
> involved this year.

I could be co-mentor for adding caching support to mainline gitweb.
I think I wouldn't have enough time for being full mentor;
additionally I don't know enough about HTTP / web caching to help.
I know gitweb fairly well, though.

I have CC-ed John 'Warthog9' Hawley (wrote caching for kernel.org's
gitweb), as a best candidate for mentor for this project, but I'm not
sure if he wouldn't be too busy for mentoring.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
