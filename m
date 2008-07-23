From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 18:54:55 +0400
Message-ID: <20080723145455.GS2925@dpotapov.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com> <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfl5-0001fV-0S
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbYGWOzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYGWOzD
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:55:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:58620 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYGWOzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:55:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1148470fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4I2gNUIdlKiCw44QphBytNdFakhRtWHEhZeZ4qEaFGY=;
        b=LBIPkCNJ6GR/6RW9nlHnSjv4XTXaZOpwKoW72X4a6RjXSKe0ETbL5JrRzqseNBOrei
         WLm5B24ucevGyAZfFZ8s2ryNio0eEvDFoBYLOqtXKAFdC8Pz4DHGWXkp0cYGY+lykmI9
         dHV9TGHstStfAXItRqnLhfWPxHHjRJUDqi+P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bZNAUAprn6GsjM1FQI5XYml3HcjYPfg8lftVqv0lgouzR+kwHiGr3tVPYPPmm732vn
         2+aPe9aynMM1NHonVX0zuoctX3N+EguO9m3+JvDYJqFV+TB2C6izESV1hNMeT8CDdCe6
         7MGh9o34wbtfDp6X3yS/upDLg5zlLBQvtBkOw=
Received: by 10.86.52.1 with SMTP id z1mr159888fgz.31.1216824898782;
        Wed, 23 Jul 2008 07:54:58 -0700 (PDT)
Received: from localhost ( [85.140.170.138])
        by mx.google.com with ESMTPS id e20sm4308008fga.1.2008.07.23.07.54.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:54:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89668>

On Wed, Jul 23, 2008 at 11:53:27AM +0200, Johannes Schindelin wrote:
> 
> On Wed, 23 Jul 2008, Jakub Narebski wrote:
> 
> 
> >    11. Why did you choose Git? (if you use Git)
> >        What do you like about using Git?
> >        (free form, not to be tabulated)
> 
> Again, to avoid hassles with free-form:
> 
> 	Mandatory: work, mandatory: open source project I am participating 
> 	in, speed, scalability, It's What Linus Uses, Other.

If we move away from free-form, it should be much more choices here.

- Ability to work offline
- Cryptographic authentication of history.
- Distributed development (pull/push from/to more than one remote repo)
- Easy to extend functionality through scripting
- Efficient storage model
- Elegant design
- Fast
- Good community support
- Rewriting patches before publishing (git rebase, commit --amend)
- Scalability (Efficient handling of large projects)
- Strong support for non-linear development
- Support of wide range of protocols for synchronization.
...

Dmitry
