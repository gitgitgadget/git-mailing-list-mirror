From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 13:17:23 +0200
Message-ID: <200610181317.24408.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <845b6e870610180228m39829c49nf37e07e76e744250@mail.gmail.com> <20061018110841.GS20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik B?gfors <zindar@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 13:17:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga9Pu-0004vK-EL
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 13:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWJRLQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Oct 2006 07:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWJRLQv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 07:16:51 -0400
Received: from qb-out-0506.google.com ([72.14.204.233]:22977 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030224AbWJRLQu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 07:16:50 -0400
Received: by qb-out-0506.google.com with SMTP id p36so677041qba
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 04:16:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jMNUJB7JXiouWKurdSsoy2hy/nc0iCl8XlS4kgmB1G8pjEVU37sfwnL3y7AXdGZmvF3xzfy06fvLDlEaHGIL2nXQDWBkF8yJ0NanXbirYApiFzd2kPiPYGADy6+WJXQCYExXjQ2xjWghqMQT5pFw462fBZslLs9oFWHlXRGpTMY=
Received: by 10.67.117.2 with SMTP id u2mr11514002ugm;
        Wed, 18 Oct 2006 04:16:49 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id j2sm794881ugf.2006.10.18.04.16.48;
        Wed, 18 Oct 2006 04:16:48 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061018110841.GS20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29224>

Petr Baudis wrote:
> But somewhere else in the thread it's been said that bundles can also
> contain merges. Does that means that bundles can look like:
>
> =A0 =A01
> =A0 / \
> =A02 =A0 4
> =A0| =A0 | _
> =A03 =A0 5 =A0|
> =A0 \ / =A0 | a bundle
> =A0 =A06 =A0 =A0|
> =A0 =A0 =A0 =A0~
>
> In that case [merge bundle], against what the big diff from 6 is done=
?
> 2? 4? Or even 1?=20

Or do you use equivalent of git combined diff format?
http://www.kernel.org/pub/software/scm/git/docs/git-diff-tree.html
--=20
Jakub Narebski
Poland
