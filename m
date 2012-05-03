From: Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH 0/4] report chmod'ed binary files the same as text files
Date: Thu, 3 May 2012 13:45:30 +0200
Message-ID: <mj+md-20120503.114519.14372.nikam@ucw.cz>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Zbigniew =?iso-8859-2?Q?J=EAdrzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu May 03 13:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPueQ-0007YD-S8
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 13:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab2ECL4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 07:56:36 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:60918 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab2ECL4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 07:56:35 -0400
X-Greylist: delayed 664 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2012 07:56:35 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 8362D9AC861; Thu,  3 May 2012 13:45:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196899>

Hi!

> This patch series fixes a small discrepancy between the way that
> text files and binary files are treated. Reported by Martin Mare=B9 i=
n [1].
> Firt patch is cleanup, second describes current behaviour, third does
> the change, and fourth is a bonus micro-opt.

Thanks for the fix!

				Have a nice fortnight
--=20
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.=
cz/
=46aculty of Math and Physics, Charles University, Prague, Czech Rep., =
Earth
This mail doesn't contain viruses, because it wasn't sent from MS Windo=
ws. Checked by eyes.
