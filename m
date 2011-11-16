From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git, Parrot, Perl6, Rakudo for G4 MAC
Date: Wed, 16 Nov 2011 16:35:29 +0100
Message-ID: <4EC3D841.1050805@web.de>
References: <loom.20111115T112500-386@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg <greggallen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 16:41:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQhcY-0001RP-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 16:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab1KPPlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 10:41:49 -0500
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:33837 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845Ab1KPPls (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 10:41:48 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Nov 2011 10:41:48 EST
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EC0B6880014BD0A; Wed, 16 Nov 2011 16:35:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <loom.20111115T112500-386@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185552>

Hej,
you actually don't need perl, if I remember my experimenta with git under
G4 MAC PPC right.

See the Makefile:
# Define NO_PERL if you do not want Perl scripts or libraries at all

And, if I remember it right, git (the selfe compiled) stopped
working after 1.7.0 or so.
I didn't do a bisect, since that machine runs linux most of the time.
/Torsten



On 15.11.11 11:36, Greg wrote:
> Howdy:
> 
> Could someone please assist me in locating the resources to "GIT" 
>  this stuff going on a G4 MAC PPC?  I 
> keep getting weird bugs.  
> Need me to be more explicit?  Ok - it says gcc v3.3 isn't compatible, and a 
> bunch of other sheet!
> 
> I'd like to start messing with this while I'm waiting for my Debian
>  Linux box to be returned. (A friend 
> borrowed it to do some work:  
> He installed a horribly virulent bug called WInBlows XP!!!!)  
> 
> I already have Perl5.10.1 working fine, and performing 
> numerous marvelous tasks, so I (perhaps 
> mistakenly) thought it would be an easy addition.
> 
> 
> Cheers,
> 
> Greg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
