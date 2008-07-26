From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] Move launch_editor() from builtin-tag.c to editor.c
Date: Sat, 26 Jul 2008 05:14:51 +0200
Message-ID: <20080726031451.GG13539@leksak.fem-net>
References: <alpine.DEB.1.00.0807251636140.11976@eeepc-johanness> <1217003322-10291-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807260456360.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 05:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMaGN-0000SQ-Ay
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 05:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbYGZDPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 23:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYGZDPE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 23:15:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:55201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752718AbYGZDPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 23:15:03 -0400
Received: (qmail invoked by alias); 26 Jul 2008 03:15:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp062) with SMTP; 26 Jul 2008 05:15:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18Omr8e2KEOzgAYQ7gVXnkKZJRynIO1I9xOFPCzmV
	vUdxafJYUsGa+x
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMaFA-0001oL-08; Sat, 26 Jul 2008 05:14:52 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807260456360.26810@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90163>

Hi,

Johannes Schindelin wrote:
> On Fri, 25 Jul 2008, Stephan Beyer wrote:
> 
> > To be kind to the maintainer, I've also run the test suite again, all 
> > tests passed except t4116*.sh, but this is not my fault. It's the fault 
> > of 9a885fac.
> 
> You do understand that you cost everybody, who actually cared to take a 
> look for herself, a few minutes?

Yes, now I see that I forgot to mention the subject.

I'm sorry.

> Dscho "who thinks that so many mails would be better if the posters would 
> read the mails themselves and try to imagine how readers would perceive 
> them"

You're right.

In my case I perhaps should've *first* looked if I could fix the TAR issue
and then first send the fix for the TAR stuff and then remove the text from
here. But I noticed the failure, wrote about it here, sent this mail, looked
for the reason of the error, ... the wrong order, as it seems.

I try to improve.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
