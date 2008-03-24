From: "Chiyuan Zhang" <pluskid@gmail.com>
Subject: Re: [GSoC2008]What's wrong with last years Gittorrent?
Date: Mon, 24 Mar 2008 15:34:32 +0800
Message-ID: <b6f0e9dd0803240034v4b53cc3fo9bc890fb3f60b919@mail.gmail.com>
References: <b6f0e9dd0803231814r72aef8aenf6d35bae77b84181@mail.gmail.com>
	 <20080324072434.GN8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 08:35:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdhDI-0007hr-8a
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 08:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYCXHee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 03:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYCXHee
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 03:34:34 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:23443 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYCXHed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 03:34:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1403425rvb.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A5GhlHs4yZtN6I8PU6k0nBt1Iz76pwxKKmwA9X4jXvg=;
        b=qUl0FV1xbqHfGM4hfN50FcRJB5Ksc2rccz/c9EZnon/0aAlgDfWNMBzECmCUQ5awCOIuc7+jC78QXv8pj4PWdJUZg/pLBygcPxav/N3Iybzo6yh7pu+aFfGBT6IM9QDEso/nAzdhQ3K/OR83LSfLfdvFGOoDBNGSPOpxia6eB/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XVOkhQxlNh1J35c5YXFi3hNp6wz8RDeh96/t4QH3fP/i61AQs+ZXaKPF2JzhcjwPn6SoRUV503Te+88Hhc5zy3DTKgMNcQqklcM6XI1d7npaslh7Yua9YXtLdKAgB8g7C0+k3JxtYB9Tq8nQ7mDmezqIAVI9kTwtjKamThGNNSg=
Received: by 10.140.174.11 with SMTP id w11mr1954803rve.17.1206344072232;
        Mon, 24 Mar 2008 00:34:32 -0700 (PDT)
Received: by 10.141.5.18 with HTTP; Mon, 24 Mar 2008 00:34:32 -0700 (PDT)
In-Reply-To: <20080324072434.GN8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78008>

OK! Thanks for this information. I think I should double
check that I'm legal to work on this before trying to
apply this. :p

2008/3/24, Shawn O. Pearce <spearce@spearce.org>:
> Chiyuan Zhang <pluskid@gmail.com> wrote:
>  > I'm planning to apply Google Summer of Code this year. I noticed
>  > on the git project page there's a gittorrent implementation. I'm
>  > interested in this. But later I found there was also a similar
>  > project (accepted) in last year's SoC: GitTorrent Server and Peer,
>  > written in Python. Unfortunately, the two links on that page aren't
>  > available any more. So I'm wondering what's the status of last
>  > year's GitTorrent? Is there something wrong with that? If any, what
>  > caused the problem and what's the differences between this year's
>  > and that one?
>
>
> Last year's GitTorrent implementation never got off the ground.
>  The student who we accepted was unable to actually participate due
>  to legal problems, and we did not find out about it until too late
>  in the program to select a replacement student.
>
>  So in short, there's nothing wrong with last year's GitTorrent,
>  as there was no last year's GitTorrent.  Hence it is on the list
>  again for this year.  :)
>
>  --
>
> Shawn.
>
