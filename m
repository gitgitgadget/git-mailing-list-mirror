From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Using git with eclipse (jgit/egit?)
Date: Mon, 2 Nov 2009 21:33:55 +0100
Message-ID: <fabb9a1e0911021233l6c1314b8q9a0f0c3a05b7e7c3@mail.gmail.com>
References: <20091102201207.GG4064@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N53bc-0004Ez-OA
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 21:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbZKBUeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 15:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756763AbZKBUeM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 15:34:12 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:56063 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759AbZKBUeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 15:34:12 -0500
Received: by bwz27 with SMTP id 27so6753557bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Ryyd40YDp26+rynYaOVfJ/fjm2INYjox3l7XgRwdU18=;
        b=ZIffKUfU5ERby3urtOHcC5XSwDPIotvXui7c0KmdJApV2gTaLhTxS++znwRDGJxX5O
         fnSLHXKCHkPfw3NAPQyS3sapPsmYmMxPYjaRalb2+fAYc2ulvdB2q2x/YBN4vl2Ww2Cv
         JJOL7adbKAvQu1Uw7Xs49r2BVuujRtn4dFZYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dzYBNTJrDaaevScnb2Er2+kMlH/B6WcoVSxIaSgZ1UM9smf24gmvyUJecixKSmnjDf
         V3InbdI9MhBzX34b1lGO6T/2PTFslsAT9SBQatU45ecL7VnVQDxOx/IVOy3dzBvZiMIo
         iuH7JYqkUl34+R5W0HwE66HXsjHKbbj7yAF/Q=
Received: by 10.204.155.90 with SMTP id r26mr4288750bkw.81.1257194055210; Mon, 
	02 Nov 2009 12:34:15 -0800 (PST)
In-Reply-To: <20091102201207.GG4064@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131934>

Heya,

On Mon, Nov 2, 2009 at 21:12, Nico -telmich- Schottelius
<nico-linux-git@schottelius.org> wrote:
> What's currently the best way to use git with eclipse?
> Using jgit or egit? And if so, what's the easiest way to
> install either? Is there any update-site available?
> Is it usable for development at all?

According to [0] there is a download site you can point your eclipse
download manager at [1] and use an unofficial periodic snapshot, but
Robin or Shawn might have more accurate information.

[0] http://www.eclipse.org/egit/install.php
[1] http://www.jgit.org/updates

-- 
Cheers,

Sverre Rabbelier
