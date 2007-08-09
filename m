From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] send-email: teach sanitize_address to do rfc2047
	quoting
Date: Thu, 9 Aug 2007 14:10:26 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070809121026.GA3068@cassiopeia>
References: <20070806083341.GA6625@informatik.uni-freiburg.de> <11864324902764-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 14:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ6qf-0001sh-Ri
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 14:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759993AbXHIMKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 08:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756201AbXHIMKi
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 08:10:38 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63353 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756135AbXHIMKi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 08:10:38 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJ6qa-0005ds-RZ; Thu, 09 Aug 2007 14:10:36 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l79CAWeC012992;
	Thu, 9 Aug 2007 14:10:32 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l79CARPD012991;
	Thu, 9 Aug 2007 14:10:27 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11864324902764-git-send-email-ukleinek@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55444>

Hello Junio,

thanks for taking that patch in next (as 5b56aaa29e), but my name got
scrambled once again in a strange way.

Please correct me if I'm wrong, but I think this time it happened
completely on your side.

The mail I got returned from the list looks good and
http://article.gmane.org/gmane.comp.version-control.git/55172 looks
right, too.

Strange enough my name is right in your What's in git.git (stable) mail=
=2E
(http://article.gmane.org/gmane.comp.version-control.git/55221)

I have still another problem with send-email.  I will try to come up
with a fix before 1.5.3.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
