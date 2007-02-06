From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: git-fast-import
Date: Tue, 06 Feb 2007 11:42:03 +0530
Message-ID: <45C81C33.6010704@gmail.com>
References: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 07:12:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEJZJ-0003Ze-My
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 07:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbXBFGMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 01:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965361AbXBFGMb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 01:12:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:25489 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965329AbXBFGMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 01:12:30 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1825289nze
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 22:12:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=My3K7ZJoj4j4JKnadQEb39oSOHYrr0toJr9KrEhADgQxhBeUWHQO7DfXnJsW/5Qhkf1+HBjayb77JpLahrsBD3Up4DdUhsdabgitsTLaPqsc+5Ank0XkY21AVe3zi98v4+cg/V6wU3BHU1Tfzf70yoUjm7prKBEll/SgQrB8u2Y=
Received: by 10.35.127.7 with SMTP id e7mr10088546pyn.1170742349255;
        Mon, 05 Feb 2007 22:12:29 -0800 (PST)
Received: from ?192.168.2.70? ( [59.92.178.182])
        by mx.google.com with ESMTP id f60sm10748797pyh.2007.02.05.22.12.27;
        Mon, 05 Feb 2007 22:12:28 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070104)
In-Reply-To: <20070206023111.GB9222@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38811>

Shawn O. Pearce wrote:
> I'm starting to get gfi (git-fast-import) prepared for a merge into
> the main git.git tree.  For those who don't know, gfi is the result
> of my work with Jon Smirl on trying to *quickly* import the massive
> Mozilla CVS repository into Git.  Recently its been getting a lot
> of attention from the KDE, OOo, Dragonfly BSD, and Qt projects.
> 
> When exactly we merge it in will depend a lot on Junio.  It should
> be safe to merge before 1.5.0 as its strictly new source files,
> but we may still want to wait until after 1.5.0 is out.
> 
> 
.....


> SYNOPSIS
> --------
> frontend | 'git-fast-import' [options]
> 

Do we have example frontend  that can be added along with gfi ?

-aneesh
