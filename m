From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 5 Feb 2009 01:08:13 +0100
Message-ID: <200902050108.14033.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com> <200902040304.05028.jnareb@gmail.com> <20090204235436.GA8945@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 01:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUroL-0003RF-UF
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 01:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbZBEAIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 19:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbZBEAIP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 19:08:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:7229 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbZBEAIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:08:14 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1393815fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GyD0yT9wZSjpvNKMbcNXWkZRGlD/Bg0krVbD0pEYiLI=;
        b=ZP+hHBVW6gfstw4RR1VfIboDTx09eSVjCTtL7QX6Owuzrg253tobMy2/dUAMk5vpFA
         HoMoaosUgtoMp/1d5pjGlbLfApILWXfTBOEZ2SuIf+ViRhDjw08ulcTCBrCMzoUBPA2Q
         VFCaoHLF2t+diW/E2urV2J8XeP6nRVJs7dSTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=q/7ew1VcjmM4R5YOZ+DmGPKfGPt8nHPiLApmJwT1NMwv+Fk+HOxmetE8YB6GRGw9Ye
         ugkM8+gQ90aOe8AbEhaoARnN7wEjwYrHwTutWu7vm+0qBhpnuYFqsFnnl9pehV8sy0Gb
         6nG7TPqFm4vMbDnqL3SRDEDk7e1Iu+XiwUFUE=
Received: by 10.103.171.20 with SMTP id y20mr609255muo.122.1233792492577;
        Wed, 04 Feb 2009 16:08:12 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id e8sm989495muf.29.2009.02.04.16.08.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:08:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090204235436.GA8945@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108475>

On Thu, 5 Feb 2009, Theodore Tso wrote:
> On Wed, Feb 04, 2009 at 03:04:02AM +0100, Jakub Narebski wrote:
> > 
> > I guess that this mailing list is subscribe-only, isn't it?  So doing
> > CC to uvc-reviewers wouldn't, unfortunately, cut?
> 
> According to the Wayback Archive's record of the uvc-reviewers mailman
> listinfo was open for anyone to join, and the archives were public,
> which is why I don't mind sharing the archives with anyone who asks.

What I meant here was whether to send email to uvc-reviewers mailing
list I have to be subscribed or not?  Because if you have to be
subscribed, even if it is open subscription and not by invitation only,
it would make it impossible to have discussion on git mailing list as
a main venue, and just CC: (send copies) to uvc-reviewers list.

-- 
Jakub Narebski
Poland
