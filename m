From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 12/13] Remove irrelevant reference from "Tying it all together"
Date: Mon, 26 Aug 2013 08:51:08 -0500
Message-ID: <E1VDxCG-0003Wz-H2@jdl.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net> <1749978317.1091238.1377329758522.JavaMail.ngmail@webmail08.arcor-online.net> <xmqqwqnal8yv.fsf@gitster.dls.corp.google.com>
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org,
	wking@tremily.us
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 15:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDxCQ-0006gy-1s
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 15:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab3HZNvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 09:51:13 -0400
Received: from jdl.com ([208.123.74.7]:50780 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab3HZNvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 09:51:12 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.72)
	(envelope-from <jdl@jdl.com>)
	id 1VDxCG-0003Wz-H2; Mon, 26 Aug 2013 08:51:08 -0500
In-reply-to: <xmqqwqnal8yv.fsf@gitster.dls.corp.google.com>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Sat, 24 Aug 2013 20:56:08 -0700."
X-Spam-Score: 0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232992>

> Thomas Ackermann <th.acker@arcor.de> writes:
> 
> > Sorry Jon, but this might not be of any help to new Git users ;)
> >
> > Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> 
> Yeah, I think this is long overdue.  The drawing was taken from an
> e-mail posted in a discussion, and the credit should have been given
> in the commit log message, not in-text.
> 
> 
> > ---
> >  Documentation/user-manual.txt | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index 0d3f04e..08d8c91 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -3908,8 +3908,7 @@ save the note about that state, in practice we tend t
> o just write the
> >  result to the file pointed at by `.git/HEAD`, so that we can always see
> >  what the last committed state was.
> >  
> > -Here is an ASCII art by Jon Loeliger that illustrates how
> > -various pieces fit together.
> > +Here is a picture that illustrates how various pieces fit together:
> >  
> >  ------------

Heh.  Totally agree.  I don't need my name on *that*
bit of Git documentation.  If needed, you can find
my name on *other* Git documentation. :-)

Acked-by: Jon Loeliger <jdl@jdl.com>

jdl
