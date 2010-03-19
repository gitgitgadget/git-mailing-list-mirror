From: Mike Hommey <mh@glandium.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 12:54:45 +0100
Message-ID: <20100319115445.GA12986@glandium.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <4BA338C1.7030803@alum.mit.edu>
 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Mar 19 12:55:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsan5-0004rs-AH
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 12:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab0CSLyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 07:54:53 -0400
Received: from vuizook.err.no ([85.19.221.46]:54365 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab0CSLyx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 07:54:53 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NsanZ-0004wD-WD; Fri, 19 Mar 2010 12:55:32 +0100
Received: from mh by glandium.org with local (Exim 4.71)
	(envelope-from <mh@glandium.org>)
	id 1Nsamr-0005eb-SL; Fri, 19 Mar 2010 12:54:45 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142577>

On Fri, Mar 19, 2010 at 04:45:38AM -0700, david@lang.hm wrote:
> here is where you are missing the point.
> 
> no, there is not 'much less chance' of it getting messed up.
> 
> you seem to assume that people would never need to set the UUID on
> multiple machines.
> 
> if they don't need to set it on multiple machines, then the
> e-mail/userid is going to be reliable anyway
> 
> if they do need to set it on multiple machines and can't be bothered
> to keep their e-mail consistant, why would they bother keeping this
> additional thing considtant? Linus is pointing out that people don't
> care now about their e-mail and name, and will care even less about
> some abstract UUID
> 
> people who care will already make their e-mail consistant.

While I don't agree with the need for that uuid thing, I'd like to
pinpoint that people who care can't necessarily make their e-mail
consistant. For example, Linus used to use an @osdl.org address, and
he now uses an @linux-foundation.org address. It's still the same Linus,
but the (name, email) pair has legitimately changed.

Mike
