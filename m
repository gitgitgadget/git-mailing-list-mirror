From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git-mail-commits (Re:What's a good setup for submitting
	patches to the list properly?)
Date: Tue, 25 Aug 2009 02:14:09 +0200
Message-ID: <20090825001409.GI3526@vidovic>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS> <200908222220.35354.chriscool@tuxfamily.org> <20090822205656.GA3526@vidovic> <200908230911.07218.chriscool@tuxfamily.org> <alpine.LNX.2.00.0908232357590.15613@reaper.quantumfyre.co.uk> <20090823234108.GB3526@vidovic> <alpine.LNX.2.00.0908250102580.28400@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 25 02:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfjlY-0007YU-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 02:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZHYATv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 20:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbZHYATv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 20:19:51 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:50474 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbZHYATu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 20:19:50 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2009 20:19:50 EDT
Received: by ewy2 with SMTP id 2so49074ewy.17
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=fh7DK6sjY0wAB8h3T55haKzppvlnZLEU3lGgdVEw3Mk=;
        b=E5pRjezVsUU2viXxOFl1KrZvOux4TUzs6RakhW2o89Bpg0R1keO6QMgQf+PwKUDrPn
         IRUE6Brp65OS83I119Uy7nZs9Ot3IrJiJoWrUrIB/b6PSN/QyzZx0jpl8rKDHdGMkY61
         WT/8JCoeKJr1HMxSKH6F/eW++NQzwUo8rTi6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eSX+JL8uvRiYvpreznBpqaP/NsH1Xv6Np6Yzqh7PQWMfcCY9nuX8OXcyRTMzSeJd/G
         iV6smFD4aiJX+NIK8YJkvfEpc0Vg8iYgIRadh/iypf95IfiIGqHa0qSDQ1WrtmimN04N
         eywDIui9JPz2wMu9AEivfmT58qtZYzXGdbl7I=
Received: by 10.210.135.1 with SMTP id i1mr5939713ebd.48.1251159252701;
        Mon, 24 Aug 2009 17:14:12 -0700 (PDT)
Received: from @ (88-121-114-119.rev.libertysurf.net [88.121.114.119])
        by mx.google.com with ESMTPS id 7sm497647eyb.57.2009.08.24.17.14.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 17:14:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0908250102580.28400@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126984>

The 25/08/09, Julian Phillips wrote:
> On Mon, 24 Aug 2009, Nicolas Sebrecht wrote:
>
> > I think it worth. That said, I would first add some config options like
> > mail-commits.cc (not reviewed that much yet) to be a bit more consistent
> > with the send-email program. I would also add README and INSTALL files.
>
> Yeah ... it would be nice to have more options settable via config.  Some 
> form of documentation would also be a good idea, and I would like to tidy 
> the code up a bit.  Kinda sort on tuits just at the moment though ... :(

Will have help from me. I find it nice to have a python alternative to
send-email. ,-p

> > Could you please consider to place your code under GPLv2?
>
> I have added a license statement.

Thank you. Patches comming.

-- 
Nicolas Sebrecht
