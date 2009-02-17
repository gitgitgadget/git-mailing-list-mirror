From: Frank Li <lznuaa@gmail.com>
Subject: Re: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Tue, 17 Feb 2009 15:11:30 +0800
Message-ID: <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>
References: <20090217011256.GA23314@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:13:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZK8k-0002MF-GE
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZBQHLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbZBQHLc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:11:32 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:39300 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZBQHLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:11:31 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1068309yxm.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 23:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c2vcuEIJ0C0UqXAXTp4tAbBQI7zXJyvdLp5mmFmTYx0=;
        b=Po9sONUsi8d+fZlt80/M8kEdhpK8Wzc8cWnHi3QsXuZzze1dARRZU+A55PayCZvAvq
         kL7YWVB965bSusDeEnUUU61iF9I5LsyBLfhUPNEIkbw0JVWoxFUVUv/dgFQGjVWBnYBf
         U+QHQcNpn3+jXfLDvR8JOe0IYmmLkaHmzsmO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CGoJ74lfF4YX9/WxfQkE69oF+BwzP4/4NvTHCCzxgUU+CvROwgXkhh1asfY1kMG01g
         3OfXXHmktNvRwHGC3mb7gawxDX2qmZcm51KWWUuPKHxiQygF/iS5OGJDeh3kDI7hX2Y1
         2qQhgr0NVucoRUUEMTlO6DtNb59GWtE4CbG5I=
Received: by 10.151.108.13 with SMTP id k13mr4685518ybm.3.1234854690018; Mon, 
	16 Feb 2009 23:11:30 -0800 (PST)
In-Reply-To: <20090217011256.GA23314@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110317>

when I click http://review.source.android.com/open , A Gerrit file
download by IE

2009/2/17 Shawn O. Pearce <spearce@spearce.org>:
> Gerrit is a web based code review system, facilitating online code
> reviews for projects using the Git version control system.
>
> Gerrit makes reviews easier by showing changes in a side-by-side
> display, and allowing inline comments to be added by any reviewer.
>
> Gerrit simplifies Git based project maintainership by permitting
> any authorized user to submit changes to the master Git repository,
> rather than requiring all approved changes to be merged in by
> hand by the project maintainer.  This functionality enables a more
> centralized usage of Git.
>
> Gerrit 2.x and later run in any standard Java servlet container,
> and includes an embedded SSH daemon, providing gitosis like group
> security and data access.  If desired, the review process can be
> skipped by directly pushing branches/tags, if the necessary access
> has been granted to the user.
>
> The last time I announced Gerrit on this list, it only ran on
> Google App Engine.  Gerrit 2.x and later is designed to run in
> any environment, without requiring the use of a Google product,
> or network connectivity to the Internet.  This makes it much more
> suited for corporate deployments, or open source projects which
> already have their own servers.
>
> Currently, Gerrit is under very active development, with stable
> releases being made about once per week.  As such, I won't be
> announcing future releases here very often.
>
> For more information:
>
>  Homepage:   http://code.google.com/p/gerrit/
>  Live Demo:  http://review.source.android.com/open
>  Source:     git://android.git.kernel.org/tools/gerrit.git
>              (but see http://code.google.com/p/gerrit/wiki/Source?tm=4)
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
