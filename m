From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: building git on Solaris
Date: Wed, 08 Sep 2010 10:55:11 -0400
Message-ID: <1283957577-sup-9932@pinkfloyd.chass.utoronto.ca>
References: <4C86A86B.1030107@bio.umass.edu> <AANLkTikvy-wUB-RFLegp7KJa_srqh97nLC03bdZDmru=@mail.gmail.com> <4C87A1DF.1020706@bio.umass.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 17:54:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtMyG-000765-0A
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 17:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab0IHPxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 11:53:37 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36148 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab0IHPxh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 11:53:37 -0400
X-Greylist: delayed 3504 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2010 11:53:37 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:38701 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1OtM3L-0002g8-Po
	for git@vger.kernel.org; Wed, 08 Sep 2010 10:55:11 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1OtM3L-0001TO-Ou
	for git@vger.kernel.org; Wed, 08 Sep 2010 10:55:11 -0400
In-reply-to: <4C87A1DF.1020706@bio.umass.edu>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155796>

Excerpts from Chris Hoogendyk's message of Wed Sep 08 10:46:55 -0400 2010:

Hi Chris,

> get asciidoc and python. I don't really like bloating my minimal
> server systems with python, but it seems I'm finally stuck, since I
> have faculty who really want to use git.

You could also use the git packages[1] from OpenCSW.  You'll get all
of the dependencies, etc and you won't need to install python.  You
will get the OpenCSW packages for perl, etc though, which you may find
to be bloat too?

HTH.
-Ben

[1] http://opencsw.org/packages/git
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
