From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Sat, 1 Sep 2007 15:46:51 +1000
Message-ID: <ee77f5c20708312246u37f9c1bahe2211117abd05790@mail.gmail.com>
References: <20070831000149.GK1219@pasky.or.cz>
	 <ee77f5c20708301756k60b4d295j907da463af477982@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, ltuikov@yahoo.com
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 01 07:46:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRLou-0007pS-20
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 07:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbXIAFqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbXIAFqw
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 01:46:52 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:39227 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbXIAFqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 01:46:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so569060rvb
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 22:46:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MFq+OCq2xWO5Nk3qTLrw4TmKhoe0GPHPrMl7bEf4Iwwj9lpkYGhRMGA9OzM3iu2ysCfKkgghJ8N11egpCXrJM6zozS3P5W3/6Yk+GEqwfLuqUUjHAU7jmYdrebcEa860wdqAr+WHYbyJrZLAWNrQrxDNbTF40GmNXJOm5qrRPvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SBhj2THQp1I2QN6h+zMTvI4ntLYB2Irn7K6PZFizM1vwODUEWiFOSw71pX6fF0VSueJbukjpiqWfN66ZaB0e9KSYdca+7MaD7VpLiHPi84qD8+Fbmj/knRKpEMch/AUk80Hi0VwYXErzxkOb90OTbDT8iABJ85f9j8ftc2hiwDw=
Received: by 10.140.128.3 with SMTP id a3mr1028540rvd.1188625611356;
        Fri, 31 Aug 2007 22:46:51 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 31 Aug 2007 22:46:51 -0700 (PDT)
In-Reply-To: <ee77f5c20708301756k60b4d295j907da463af477982@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57256>

On 31/08/07, David Symonds <dsymonds@gmail.com> wrote:
> On 31/08/2007, Petr Baudis <pasky@suse.cz> wrote:
> >   Please feel encouraged to make random forks for your development
> > efforts, or push your random patches (preferrably just bugfixes,
> > something possibly controversial should be kept in safe containment like
> > a fork or separate branch) to the mob branch.
>
> Sorry, I'm still relatively new to git, and couldn't work out how to
> push to the mob branch, so it's inline below. It's fairly minor, just
> adding <span title="foo">..</span> around author names when they get
> abbreviated.

Okay, I worked out how to push to the mob branch: it's commit 37c8546.
I can refactor this somewhat if that's an issue.


Dave.
