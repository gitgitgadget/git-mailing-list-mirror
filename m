From: "Marijn Schouten (hkBst)" <hkBst@gentoo.org>
Subject: cloning empty repo
Date: Sun, 24 Jun 2007 17:04:40 +0200
Message-ID: <467E8808.7030903@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 17:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2U3J-0006S8-5m
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 17:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbXFXPa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 11:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbXFXPa7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 11:30:59 -0400
Received: from pollux.sshunet.nl ([145.97.192.42]:33528 "EHLO
	pollux.warande.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbXFXPa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 11:30:59 -0400
X-Greylist: delayed 1665 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2007 11:30:58 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by pollux.warande.net (Postfix) with ESMTP id 9456F580005
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 17:03:09 +0200 (CEST)
Received: from pollux.warande.net ([127.0.0.1])
	by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03698-05 for <git@vger.kernel.org>;
	Sun, 24 Jun 2007 17:03:09 +0200 (CEST)
Received: from [145.97.223.213] (213pc223.sshunet.nl [145.97.223.213])
	by pollux.warande.net (Postfix) with ESMTP
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 17:03:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070616)
X-Enigmail-Version: 0.95.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at sshunet.nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50800>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi list,

is there any reason why cloning an empty repository should result in an error
instead of a succesfully cloned empty repo?

Marijn

PS Please CC me
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGfogIp/VmCx0OL2wRAnYXAJ9cJAO4WsQihr6iEsEIawA9cpycQACglI8G
lofEKfuidJ1OOv12A9QPK8w=
=p344
-----END PGP SIGNATURE-----
