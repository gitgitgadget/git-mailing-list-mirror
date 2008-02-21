From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Object Permissions
Date: Thu, 21 Feb 2008 12:29:27 -0800
Organization: Bluelane
Message-ID: <47BDDF27.2030603@bluelane.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: piet.delaney@gmail.piet.net
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSI3k-0007OH-9Z
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbYBUU3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbYBUU3e
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:29:34 -0500
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:2611 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932172AbYBUU3c (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 15:29:32 -0500
Received: from piet2.bluelane.com ([64.94.92.242]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Feb 2008 15:29:31 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-Enigmail-Version: 0.95.6
X-OriginalArrivalTime: 21 Feb 2008 20:29:31.0253 (UTC) FILETIME=[769FE250:01C874C8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74652>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've been trying to us the git repo in a
centralize pull, push model where the
developers pull the repo, checkout a
branch, commit and then push back to the
common repo.

Problem is that the objects get set with
the ownership of the user (at least when
pulling with this format:

~    git clone git:/home/git/blux

Amy suggestions on how to do this?

- -piet
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHvd8nJICwm/rv3hoRAm8lAKCIql7mCd1rU5ZdS/w/dzNUZLA++gCfYy90
nzIA0vqSgwTh0EYUz70/Uxo=
=RAIY
-----END PGP SIGNATURE-----
