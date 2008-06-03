From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What is the status of "GitTorrent" git GSoC 2008 project?
Date: Tue, 3 Jun 2008 14:27:50 +0200
Message-ID: <200806031427.51517.jnareb@gmail.com>
References: <200806030425.48794.jnareb@gmail.com> <48451209.3090308@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joshua Roys <roysjosh@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 14:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3VdF-0004f4-Am
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 14:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYFCM17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 08:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbYFCM17
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 08:27:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50985 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbYFCM16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 08:27:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1020747fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=UW+AVL3Pd2IJy+1Gn2SYcLHsVkMXlcY2E6+3lQU5sYY=;
        b=Y8G+gzxSqNt9L4ski4rUPlpnXwaSveWcoqOWbQNl+PACa0DaAlL2EQFzM9vQGQB10l0UUQs/Rfq2TpEEYQCEux5M/qV+EQjidiFMZFxkw2g0eogigFWwkwPHk1HA4Hm2Cp6hEuct2iLREeOVlojfJcfk34/ptQL075h65bWVf+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n2Sn/oRcB+IQlPTpUa/1qS21w8fih2V3ACl8wHgGtojVHTV/vyzSA54vcP0qLXINqQq46C6pgc3xeYbXCxgT7mqPlUfJgGo4DoyUu5ENG25DDasVayoGl8IBYhGU+6ke98O4gdybUcOVd8Ftbqsy43KKhdGsG+brcQDyBacEvUE=
Received: by 10.86.57.9 with SMTP id f9mr99611fga.66.1212496076238;
        Tue, 03 Jun 2008 05:27:56 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id d4sm5215634fga.8.2008.06.03.05.27.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 05:27:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48451209.3090308@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83647>

Dnia wtorek 3. czerwca 2008 11:42, Sam Vilain napisa=B3:
> Jakub Narebski wrote:
> >
> > What is the status of GitTorrent project from GSoC 2008?
> > It is I think the only project which doesn't have link to
> > repository (to gitweb) at http://git.or.cz/gitwiki/SoC2008Projects
> >=20
> > BTW. public repository doesn't have to be on repo.or.cz
> > (although I guess it would be nice to have mirror there).
> > It can be self hosted; there is gitorious, github and
> > other git hosting sites...
>=20
> The gitweb is at
> http://utsl.gen.nz/gitweb/?p=3DVCS-Git-Torrent, and the public reposi=
tory
> is at git://utsl.gen.nz/VCS-Git-Torrent
>=20
> I'll be giving a public update around mid-term time
> (http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline),
> unless there is something of widespread interest before then.

Thanks a lot.
=20
> If you'd like to contribute in discussion or code, please feel free t=
o
> write to the list: http://lists.utsl.gen.nz/mailman/listinfo.cgi/gitt=
orrent

I have added linkt to GitTorrent Protocol RFC and to mailing list
(as it doesn't use git mailing list) to SoC2008Projects wiki page.


By the way, can I subscribe GMane (mail<->news interface) to gittorrent
mailing list, to make available to read (and post to) gittorrent list
from news reader (NNTP interface) at http://gmane.org/subscribe.php ?

--=20
Jakub Narebski
Poland
