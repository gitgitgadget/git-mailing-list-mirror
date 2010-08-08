From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Documentation: changes in the behavior of tagopt
Date: Sun, 8 Aug 2010 10:17:32 +0800
Message-ID: <AANLkTike2mAoGGk2ryZGjOmfT=yjHBLD4W5GPaXkxiso@mail.gmail.com>
References: <AANLkTikf96RLfTq4Q6DAPesr6j70CJfT8vBzidJk42dE@mail.gmail.com>
	<1281102867-6490-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 04:17:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhvSF-0001s4-UX
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 04:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab0HHCRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 22:17:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45325 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab0HHCRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 22:17:32 -0400
Received: by iwn33 with SMTP id 33so2612074iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=dNz9yhqtcz+4K8ZGjEadRLGftZes1YmoE7NPK068C8s=;
        b=x5yyxPcbpljUkGOMdjm8JBsBt0iMRP1J+d+K3pH3gN2fSnTvSKqZibL1sMJkGJ3Ee+
         kMQL2MY61tn0WaJNPQ/1l2Sf/DusN7YPqSALHMZMTHYSVOhkFOoRRKR3GM2SBd7M/tVF
         9YRrfD7o6cR/EHhhMot/rXN2e/K4Okdx39ikw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=W2yY5l7QxF81AcENtPnId/WegCfOu9lSCKUZijCbsMRo6uvcF9+yg2kMN1biyiCt8f
         aZeRR3CwqRYPtKxhXJgI2fyE2KFSS8n/ccwuKi9uTPXExlLB23H9DM12S36BDszC7P2p
         +mxmjbucq3ZJyhKK/aHgQygt6CdiGyyaRHGac=
Received: by 10.231.184.16 with SMTP id ci16mr16823608ibb.23.1281233852189; 
	Sat, 07 Aug 2010 19:17:32 -0700 (PDT)
Received: by 10.231.158.141 with HTTP; Sat, 7 Aug 2010 19:17:32 -0700 (PDT)
In-Reply-To: <1281102867-6490-1-git-send-email-ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152877>

On Fri, Aug 6, 2010 at 9:54 PM, Daniel Johnson <computerdruid@gmail.com> wrote:
> ---
> How does this look?

Looks ok - now you'll have to squash this with your code patch.

-- 
Cheers,
Ray Chuan
