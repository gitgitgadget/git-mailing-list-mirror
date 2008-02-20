From: Pete/Piet Delaney <pete@bluelane.com>
Subject: can't read "treediffs(....)
Date: Wed, 20 Feb 2008 15:18:50 -0800
Organization: Bluelane
Message-ID: <47BCB55A.4090308@bluelane.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Piet Delaney <piet.delaney@gmail.com>,
	Piet Delaney <pdelaney@bluelane.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyDy-0004VM-Qd
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764308AbYBTXS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbYBTXS6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:18:58 -0500
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:46088 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758893AbYBTXS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2008 18:18:56 -0500
Received: from piet2.bluelane.com ([64.94.92.242]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Feb 2008 18:18:54 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-Enigmail-Version: 0.95.6
X-OriginalArrivalTime: 20 Feb 2008 23:18:54.0828 (UTC) FILETIME=[F62C9AC0:01C87416]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74566>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

What does this mean?
- -----------------------------------------------------------------------
can't read "treediffs(1c977462d86c94cd20492c72f2be175a05aad0f4)": no
such element in array
can't read "treediffs(1c977462d86c94cd20492c72f2be175a05aad0f4)": no
such element in array
~    while executing
"lindex $treediffs($diffids) [expr {$l-2}]"
~    (procedure "pop_flist_menu" line 11)
~    invoked from within
"pop_flist_menu .bright.cfiles 977 652 54 105"
~    (command bound to event)
- -------------------------------------------------------------------------

- -piet
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHvLVaJICwm/rv3hoRAkjHAJ46mxx+CzdiWHnE5xE/oJ2DR3gNKgCdHSCg
nPffcBjtolA1XIp3F7fWL1U=
=wbMX
-----END PGP SIGNATURE-----
