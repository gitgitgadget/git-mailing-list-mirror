From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 10:15:16 +0200
Message-ID: <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503180016.GB21333@informatik.uni-freiburg.de>
	 <20070503200013.GG4489@pasky.or.cz>
	 <loom.20070504T143538-533@post.gmane.org>
	 <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 06 10:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkbu3-0005WV-Do
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbXEFIPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512AbXEFIPU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:15:20 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:50634 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbXEFIPS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 04:15:18 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1261307nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 01:15:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RDsj60GNR74O04FtK74aeG2WH9qCfrxrv0xoSii3gb4HDLgMlUFFWx8M8KchkfY4cGRgNBE4NY9Ot/BK9QZdxrLsL7nf262S5MTQJaMwcBduYjnY+wgn+nYqfkwRMeUe7KF7B81tzd8dnNEn1//NOxaQkMoulUupFJRRaDXloeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qyxbn6RrFbYRfzvH10rDDUN3oBRh4XIDqIs20u1Gz29wnw077GqqGj/3g/p9jA8ztrOsyGKFbmT8IfOWVZyKnWx3I+fn9RHUeHZ2KmD3z1f95W0+z/en+Kz6AviW+hj6nuVkhFBLENbUG6HLyQdzFw5LG4I432/NKLA/BCXmHAc=
Received: by 10.115.72.1 with SMTP id z1mr363934wak.1178439317440;
        Sun, 06 May 2007 01:15:17 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 6 May 2007 01:15:16 -0700 (PDT)
In-Reply-To: <20070505133543.GC3379@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46315>

On 5/5/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-04 11:17:05 -0700, Carl Worth wrote:
>
> I know that I can ask it to highlight commits that insert or remove
> "snippet of interest", but frequently the highlighted commits are ten
> out of ten thousand, and not that easy to find even when boldfaced.
> What I want is to make it display only those commits.
>

Use qgit ;-)
