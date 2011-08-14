From: David Aguilar <davvid@gmail.com>
Subject: Re: git am ~/Documents/mail-[1-9]-11.txt Patch format detection
 failed.
Date: Sat, 13 Aug 2011 19:14:16 -0700
Message-ID: <20110814021414.GA8724@gmail.com>
References: <CAJfuBxx9Ayo8cHga+vK+Ynx5P7dhST7f=p87-qyjEzofSdZ=RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 04:14:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsQDf-0000y0-PT
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 04:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab1HNCOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 22:14:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41905 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1HNCOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 22:14:24 -0400
Received: by gwaa12 with SMTP id a12so2704117gwa.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xEigXzUBMX6FdlzaLmEFQ0LdGlHNN7W4kYTZ0N+wIzs=;
        b=J18DOmvEjdvQWCLx7FfmMLH4bgNTyP2XdhilGXxeisVbWSo0C+j8nHCLsjSEEm4mlz
         ynmIIUkqpEmDdaQhRY/ibZbW0EnR2Fvk4BCYPnOF04/4GXNl0wXMwxIEKRsud0HxkOYM
         3CpijIszg9IgOJ2YJ11wBM/voMkrajJQD1vGQ=
Received: by 10.91.195.19 with SMTP id x19mr2625523agp.6.1313288063748;
        Sat, 13 Aug 2011 19:14:23 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c15sm2428942anm.46.2011.08.13.19.14.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 19:14:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJfuBxx9Ayo8cHga+vK+Ynx5P7dhST7f=p87-qyjEzofSdZ=RQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179301>

On Sat, Aug 13, 2011 at 01:49:35PM -0600, Jim Cromie wrote:
> git am is giving me trouble.
> 
> Im a gmail user, and have saved a patch series by doing
> show-original, save w rename for each patch
> [snip]

My experience with gmail + patches is that you need to use an
email client to download patches, not the web interface.

mutt works well for me.  Any client that can talk to gmail
over imaps:// should do the trick.

I couldn't find what was wrong with the patch you
attached to your original message, though.
-- 
					David
