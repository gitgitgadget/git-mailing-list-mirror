From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question about announcing it
Date: Mon, 6 Jul 2009 23:44:24 +0200
Message-ID: <200907062344.26126.jnareb@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <20090704090535.GA6518@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Renold <martinxyz@gmx.ch>
X-From: git-owner@vger.kernel.org Mon Jul 06 23:44:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNvzJ-0005dV-F1
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 23:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbZGFVo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbZGFVo0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 17:44:26 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:53604 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZGFVoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 17:44:25 -0400
Received: by bwz25 with SMTP id 25so1614292bwz.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yWklCUN8Iw1eIs2IvdYlDk88jhl8WH2X/WV7Ld3NS4w=;
        b=nVhvUSmlHMLT1BMq3tBEGCfilIseEAFEMWzk5p2cmq+YravkQ1U2bgqyWRbRjK0rIl
         zzZdT27nPjZLkE4qJaSVX9hojoyV0lNsODLFERw6AvFcBLVFQ50zJrdKFiR9W2/Rg9VD
         XT8Tlouno/qdF4BQGgMaQiXR4zkjYLq16kF3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dnXFmragVYqyPY1WlZ7X2SbrX2B02oOJrqAKsK3dcrZv/4GzbnHsRBRzQMUTgK8w7c
         7uBhAWPwK5uZfJCr/yTR6QKk8moiJC+hA2cY6lL79CRbZgW5ptW4ry4fb02bF11m3yek
         vO4lTX1UMIQ1feRhyKcgsCFW+nVYF22OPjG+I=
Received: by 10.204.118.12 with SMTP id t12mr5002279bkq.158.1246916667826;
        Mon, 06 Jul 2009 14:44:27 -0700 (PDT)
Received: from ?192.168.1.13? (abwt137.neoplus.adsl.tpnet.pl [83.8.243.137])
        by mx.google.com with ESMTPS id 18sm12208858fks.10.2009.07.06.14.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Jul 2009 14:44:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090704090535.GA6518@old.homeip.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122799>

On Sat, 4 Jul 2009, Martin Renold wrote:
> On Fri, Jul 03, 2009 at 01:30:22AM +0200, Jakub Narebski wrote:

> > 11. What Git interfaces, implementations, frontends and tools do you use?
> >     * my own scripts
> 
> There was a surprising amout of 12% of the users picking that in 2008, and
> confusion about why they do so.  Could this be split up, eg. like this?
> 
>     * my own scripts (for daily commandline use)
>     * my own scripts (for special tasks)

By "for daily commandline use" you mean writing [partial] porcelain, 
don't you?  It might be good idea to split it... on the other hand
number of possible answers for this question is quite large (but IMHO
not unmanageable large) already.

-- 
Jakub Narebski
Poland
