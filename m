From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 08:21:36 -0700 (PDT)
Message-ID: <m3d4l0vfgk.fsf@localhost.localdomain>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	<20080726015314.GU32184@machine.or.cz>
	<20080726020951.GV32184@machine.or.cz>
	<7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
	<d411cc4a0807252343n2b9ade68veaebb68664f0a3d7@mail.gmail.com>
	<7vtzedktmi.fsf@gitster.siamese.dyndns.org>
	<d411cc4a0807260027t4b9c3b08x1f865ec75d976ef6@mail.gmail.com>
	<488B394F.9000300@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlbV-0006n5-BU
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYGZPVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYGZPVl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:21:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:42454 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYGZPVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:21:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so65688ugf.16
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=qZPMnB/RKlktuE/dw9UI2Ud5GFoRLdi1XraDTGbWyfo=;
        b=kiIj6tNm1QzqIkSKUi5Q5HIhxZZbFdVbDEn0V0/UEH4Izz/wixzzXx6GYIv+DBddje
         GiVz0TXYhfLfVJ2jdA5FKRqXhUImrJ8Hpxm1sjih5aJyfD6mBiWzQtvuAO9SFwW7r+VE
         QsvSUyoesFMFnmA3/lhF6fd6Cr6D3n8swI5UI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qKuEqjmPg3OyynyMJV4qkms8y9kxCF0SV/oxfjylU8fah/BIMzPdiq2dnZM224uOFZ
         wEzfXQmu4yRP5w81TeVjOOWhVXVOes1cITu7iXskd5Z1/nw+XDqccybyZQHOJ4JaNjxo
         PWUWKeIunVcHCD5B1MKA928AlIf45NxgFx6kI=
Received: by 10.67.116.8 with SMTP id t8mr815592ugm.57.1217085697893;
        Sat, 26 Jul 2008 08:21:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.191])
        by mx.google.com with ESMTPS id m1sm744755ugc.9.2008.07.26.08.21.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 08:21:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6QFLYn6020324;
	Sat, 26 Jul 2008 17:21:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6QFLV5Z020321;
	Sat, 26 Jul 2008 17:21:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <488B394F.9000300@keyaccess.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90239>

Rene Herman <rene.herman@keyaccess.nl> writes:

> On 26-07-08 09:27, Scott Chacon wrote:
> 
> > Perhaps it would be useful to split the mailing list into
> > core/contrib and support lists?  I would be happy to help out
> > answering questions - a lot of them come directly to me anyhow
> > because of the gitcasts site and such.
> 
> A git-user list would be welcomed at least by me. It remains to be
> seen how useful it would be (and stay) as often the user lists for a
> project dwinddle a bit but I've subcribed and unsubscribed to this
> list a number of times now since unless I've a specific question to
> ask, the list is too busy too just sit around on; I end up deleting
> all list mail unread every night anyway, so I just unsubcribe again.
> 
> Maybe a less busy and less implementation focused list could help "me
> and mine" gradually pick up new tips and tricks. Depends ofcourse on
> willingness of some of the more proficient to be involved in that list
> as well...

Well, there _is_ separate Git Users Group at Google Groups
  http://groups.google.com/group/git-users
  nntp://news.gmane.org/gmane.comp.version-control.git.user

-- 
Jakub Narebski
Poland
ShadeHawk on #git
