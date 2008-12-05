From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git weekly news: 2008-49
Date: Fri, 5 Dec 2008 23:33:39 +0100
Message-ID: <200812052333.40213.jnareb@gmail.com>
References: <94a0d4530812041643r784ae8b1x242e3b2f9c9f41@mail.gmail.com> <7v3ah2z6jh.fsf@gitster.siamese.dyndns.org> <94a0d4530812051349tff33aaan76e29402215dcae2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git list" <git@vger.kernel.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8jGP-0000T5-UP
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 23:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbYLEWdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 17:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYLEWdw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 17:33:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:3009 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbYLEWdv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 17:33:51 -0500
Received: by ey-out-2122.google.com with SMTP id 6so100003eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iuKk7/YjZxjA9jm8zaJkfV7LYcRDKKTcZ6kAB/f3mbk=;
        b=WoyoS2hkZ8DzQgIy/dmiNHoviSEYssdPcHCQgz491lsQBWXioz6YEqHnmI45fPUYce
         xnEuitutdMSlzz52t2AlrpXft2ZP3R1X6UEli5RvWoIkcUUc7EXfdUMgUkyX1d+R8pQI
         V7IroK+IHM3fqm6gC8oCoT52WB9gDjyWnYB5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SkKvbfsLMx06DsrLBgxzkdfD145uyxUoQ0XaralgltKktd9DCNZn2cEM5Y8S8KUlhJ
         mDo7f270NG4QWUyJeFrBDQ8EnHH1PUdC5XJ6ynuCcD5gqoobE7WnHqDUdOCVYV11XROD
         +IJTCHRrfVb2qCyDzM8BlExLF214NudfyRMBo=
Received: by 10.210.16.17 with SMTP id 17mr470378ebp.62.1228516427488;
        Fri, 05 Dec 2008 14:33:47 -0800 (PST)
Received: from ?192.168.1.11? (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id 10sm1030174eyd.53.2008.12.05.14.33.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 14:33:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530812051349tff33aaan76e29402215dcae2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102420>

On Fri, 5 Dec 2008, Felipe Contreras wrote:
> On Fri, Dec 5, 2008 at 10:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:

> > Felipe's page currently is a random collection of links, and other than
> > their titles, there is no indication for readers to judge which link is
> > worth clicking and reading.  It does not even mention who wrote each
> > piece, let alone editorial comments (e.g. "This is worth reading") like
> > you added.  When you click one of them in order to read it, you leave the
> > "list of links".  That is not how navigation (the click and thought flow
> > for the readers) usually works in a "Planet".
> 
> Lets remember that this is the first try, and there's many more links
> that what would fit in any given week, but I just didn't want to leave
> them out.
> 
> Maybe for the next weeks I'll do a bit of explanation about each link,
> lets see. 

Not necessary a bit of explanation about _each_ link, but at least put
them in rough categories (as a kind of you did), separating praise,
explanation/documentation, web and Ruby stuff and solving, and solving
specific issue (like those on BlogPosts wiki page).
 
 
> I actually propose two things:

[...]
> b) git blog
> 
> A blog can be shared by a bunch of people, much line online news
> sites. Junio could write a post once for each release, for example,
> without having to setup his own blog, maybe somebody else can
> copy-paste "What's cooking in git.git", or any kind of semi-official
> announcement.

Junio has its own blog: http://gitster.livejournal.com

And there is RSS feed for [ANNOUNCE] posts at http://gitrss.q42.co.uk
and "What's cooking in git.git" and the like.

> And I'm sure there will be one or two developers who wouldn't mind
> sharing their frustrations and/or visions.

Would they want to write blog posts? Git is very much email driven
community...

[...]
> For b) I just need interested people to send me their emails.

To apply for accounts, isn't it?
-- 
Jakub Narebski
Poland
