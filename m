From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Remove dead link
Date: Fri, 23 Aug 2013 10:05:24 -0500
Message-ID: <E1VCsvU-0000Xp-EW@jdl.com>
References: <884d025e9da6f309d33dffdd1ed3731defa514ba.1377267683.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 17:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCtN9-0000Z7-K1
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 17:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab3HWPdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 11:33:55 -0400
Received: from jdl.com ([208.123.74.7]:35951 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab3HWPdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 11:33:55 -0400
X-Greylist: delayed 1708 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2013 11:33:55 EDT
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.72)
	(envelope-from <jdl@jdl.com>)
	id 1VCsvU-0000Xp-EW; Fri, 23 Aug 2013 10:05:25 -0500
In-reply-to: <884d025e9da6f309d33dffdd1ed3731defa514ba.1377267683.git.mina86@mina86.com>
Comments: In-reply-to Michal Nazarewicz <mpn@google.com>
   message dated "Fri, 23 Aug 2013 16:25:02 +0200."
X-Spam-Score: 0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232811>

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> ---
>  Documentation/technical/pack-heuristics.txt | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/tech
> nical/pack-heuristics.txt
> index 8b7ae1c..b7bd951 100644
> --- a/Documentation/technical/pack-heuristics.txt
> +++ b/Documentation/technical/pack-heuristics.txt
> @@ -366,12 +366,6 @@ been detailed!
>  
>      <linus> Yes, we always write out most recent first
>  
> -For the other record:
> -
> -    <pasky> njs`: http://pastebin.com/547965
> -
> -The 'net never forgets, so that should be good until the end of time.
> -
>      <njs`> And, yeah, I got the part about deeper-in-history stuff
>          having worse IO characteristics, one sort of doesn't care.
>  

Hmm.  Something oddly self-referential about this quip
being removed from the document.  Perhaps we should notify
the Boy from "Paradise By The Dashboard Light" that he
can rest easily now without the Girl as it seems the
end of time has come at last.

Acked-by: Jon Loeliger <jdl@jdl.com>

jdl
