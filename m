From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 13:24:05 -0700 (PDT)
Message-ID: <m34p6cv1gl.fsf@localhost.localdomain>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	<20080726015314.GU32184@machine.or.cz>
	<20080726020951.GV32184@machine.or.cz>
	<7v4p6dnv5k.fsf@gitster.siamese.dyndns.org>
	<d411cc4a0807252343n2b9ade68veaebb68664f0a3d7@mail.gmail.com>
	<20080726201751.GU10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 26 22:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMqKF-00086h-1j
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 22:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbYGZUYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 16:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755236AbYGZUYK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 16:24:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:23983 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbYGZUYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 16:24:09 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1374966nfc.21
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=sDXP0Lrhuo54pIACMnyT60vZwhZbLywRmqUquqTNn80=;
        b=l0MKmHzwTjGKlTwVIcXANsAM/ah2Hs0NJqImhQMRI3nv57ROSGJCQ/iYZsP0RoXF6Q
         mFpxEe/pcHKF9OHytEzzCjvLARDLV5kiyx6EHveeW+kRMr1hQvvqCSaDojXQ5o2R+/ks
         QoLaNPTE+9dX7WvcqjxqfwLcFARVMmGxQ1YY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Ra6WW3an4QR8VSGTzhZiY1K4opnwyWMbmUTlfdtX1pPIXqTtUkzdC+66ga4nbx7q7a
         a2GhV2WgaaStLyE/HMHuP0k+aK3rQfN3JX81/qXUV1zzrMIe5bgLlGPHRGddyk0B7d25
         B8tUC/sIaUenIj/2IPFjlzUzVqLM9GSHmiy1A=
Received: by 10.210.41.14 with SMTP id o14mr3744695ebo.137.1217103846600;
        Sat, 26 Jul 2008 13:24:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.240.214])
        by mx.google.com with ESMTPS id y37sm17418766iky.8.2008.07.26.13.24.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 13:24:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6QKO0Fj022327;
	Sat, 26 Jul 2008 22:24:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6QKNwUv022324;
	Sat, 26 Jul 2008 22:23:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080726201751.GU10151@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90281>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Jul 25, 2008 at 11:43:55PM -0700, Scott Chacon wrote:
> > However, I have evangelized Git in person to literally thousands of
> > people, and tens of thousands more online.  GitHub hosts over 10,000
> > public git projects completely for free, and has contributed a ton
> > back to the community, both in code and proselytization efforts.
> 
> I certainly agree that GitHub has done a lot for spreading Git; the
> mention of code is interesting, though. There is Grist and the GitHooks;
> anything else? It's a pity Grist wasn't even announced at the mailing
> list. :-(

And neither project was added to Git Wiki:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

It looks like GitHub-bers are a bit of splinter faction.  Thank you
Scott Chacon for trying to change this...

P.S. What about http://git-scm.org/ ?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
