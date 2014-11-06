From: Tristan Roussel <troussel@phare.normalesup.org>
Subject: Question about rerere
Date: Thu, 6 Nov 2014 12:30:31 +0100
Message-ID: <F9D7CE90-BED2-4694-B5DB-AE848C9F3F34@phare.normalesup.org>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 13:02:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmLmE-0007ox-7f
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 13:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaKFMCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2014 07:02:54 -0500
Received: from nef2.ens.fr ([129.199.96.40]:3866 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaKFMCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2014 07:02:53 -0500
X-Greylist: delayed 1938 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Nov 2014 07:02:52 EST
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
          by nef2.ens.fr (8.13.6/1.01.28121999) with ESMTP id sA6BUWnf086944
          for <git@vger.kernel.org>; Thu, 6 Nov 2014 12:30:32 +0100 (CET)
Received: from [10.20.43.72] (unknown [78.109.80.129])
	by phare.normalesup.org (Postfix) with ESMTPSA id F2D9148003
	for <git@vger.kernel.org>; Thu,  6 Nov 2014 12:30:31 +0100 (CET)
X-Mailer: Apple Mail (2.1990.1)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef2.ens.fr [129.199.96.32]); Thu, 06 Nov 2014 12:30:32 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I=E2=80=99ve just learnt about rerere and it=E2=80=99s going to make my=
 life so much easier, I have a question though.

I enabled rerere very lately and I wanted to know if there was a way to=
 feed rerere with old merge conflict resolutions (and if not, would it =
be considered a good feature request)? I=E2=80=99d like to do a rebase =
of my work because I unintentionally merged a branch I didn=E2=80=99t w=
ant and the merge is a bit far in the git history and I don=E2=80=99t w=
ant to re-resolve merge conflicts I had after that.

Thanks for your help!