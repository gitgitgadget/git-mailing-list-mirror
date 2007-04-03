From: Alberto Bertogli <albertito@gmail.com>
Subject: Re: Commit cherry-picking
Date: Tue, 3 Apr 2007 02:45:02 -0300
Message-ID: <20070403054502.GD24722@gmail.com>
References: <20070403034234.GB24722@gmail.com> <20070403051947.GE15922@spearce.org> <20070403053344.GG15922@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 07:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYboP-0003Jr-3t
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 07:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbXDCFoD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 01:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXDCFoD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 01:44:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:19649 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbXDCFoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 01:44:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1670893wxd
        for <git@vger.kernel.org>; Mon, 02 Apr 2007 22:44:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TSn0znCKLw5ihcP+itzbyiLhjUsZzKVOcBRucPlEVK/LRxjw5HqJ2/HDMH2K9hvWdXhmuURHP6q3K+9Zbh0RLAtVzGp8Mg2uZIpokV8mvvPZ0b9jGT+9kG6QN/zYNGo5ezgmUdKU8OBGq9vN97FOF4kV7Urv/zk76l+G847gpws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZaMPt/DqbvEdsMan0LMRuwym4Jmx3hioA86y+eNsbMzQKCMGA8NuYGUoBE0pnIgAQY1K+AuYONqIYkgLrC5kfSQXxsOlon7nQYQr2Zs+tmaGlKz4/pdkxVgt6RvSzpvdrpBCvwo7/37Jr60cVqgp8jzAkxjo6orZ0c6JXByz/Ok=
Received: by 10.70.65.8 with SMTP id n8mr10309558wxa.1175579040853;
        Mon, 02 Apr 2007 22:44:00 -0700 (PDT)
Received: from gmail.com ( [190.30.3.127])
        by mx.google.com with ESMTP id h7sm7442017wxd.2007.04.02.22.43.58;
        Mon, 02 Apr 2007 22:43:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070403053344.GG15922@spearce.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43617>

On Tue, Apr 03, 2007 at 01:33:44AM -0400, Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Alberto Bertogli <albertito@gmail.com> wrote:
> > > I often use darcs, and one feature I miss when I use git is the ability
> > > to do cherry-picking on what I'm about to commit.
> > 
> > Have you tried:
> > 
> > 	git add -i
> > 	git commit
[...]
> 
> Also `git gui` (or `git citool`) offers this hunk selection feature,

Argh, how can I have missed all that!

Sorry for the noise, and thanks for the suggestions.

		Alberto
