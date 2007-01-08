From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Mon, 8 Jan 2007 13:38:19 +0100
Message-ID: <8b65902a0701080438v4822eabdi135a5358f977328a@mail.gmail.com>
References: <20061116221701.4499.qmail@science.horizon.com>
	 <20070103170411.GB5491@thunk.org>
	 <20070107234411.GD18009@fieldses.org>
	 <20070108004006.GB23182@thunk.org>
	 <20070108004641.GG18009@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, linux@horizon.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 13:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3tlg-00080P-Hi
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 13:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbXAHMiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 07:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbXAHMiV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 07:38:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:51012 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161266AbXAHMiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 07:38:20 -0500
Received: by wr-out-0506.google.com with SMTP id i28so25297wra
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 04:38:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y+k+ecE2RT+7TU4T0A7wm4p1miqx2m4yP+ywhtTuxgm9xqUfAzM8OqAWP4ACbPa/4Hw3/NtrST7qKBdVfzGtZI/A0Bcc9EHlZB+UMEHJhL13NwaRP3sm1WfaQbFRwJ2rBtbr33zCYtrG/zRZuNaON8DUUqi6uCgF0TWrqRcesq8=
Received: by 10.90.34.3 with SMTP id h3mr2050521agh.1168259899507;
        Mon, 08 Jan 2007 04:38:19 -0800 (PST)
Received: by 10.90.51.4 with HTTP; Mon, 8 Jan 2007 04:38:19 -0800 (PST)
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070108004641.GG18009@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36248>

On 1/8/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Sun, Jan 07, 2007 at 07:40:06PM -0500, Theodore Tso wrote:
> > On Sun, Jan 07, 2007 at 06:44:11PM -0500, J. Bruce Fields wrote:
> > > On Wed, Jan 03, 2007 at 12:04:11PM -0500, Theodore Tso wrote:
> > > > What ever happened to this document?  There was some talk of getting
> > > > this integrated into the git tree as Docmentation/tutorial-3.txt.
> > >
> > > Just to throw more fuel on the fire....
> > >
> > > I have a draft attempt at a complete "git user's manual" at
> > >
> > >     http://www.fieldses.org/~bfields/
> >
> > Is that the right URL?  That gets me to "Not Bruce's Webpage" and I
> > don't see an obvious link to git documentation...
>
> Crap:
>
>         http://www.fieldses.org/~bfields/git-user-manual.html

Nice work.

My only 2 cents: the SVN book is really a good book, as it contains
both simple user and advanced hacker info. As it is in free licence,
perhaps it could be possible to "port" the book to Git. I saw that the
SVK book is such a port. But it's a DocBook document.
http://svnbook.red-bean.com/
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
