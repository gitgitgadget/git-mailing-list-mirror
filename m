From: Mike Hommey <mh@glandium.org>
Subject: [Patch reminder] Don't verify host name in SSL certs when
	GIT_SSL_NO_VERIFY is set
Date: Sun, 7 Sep 2008 10:20:59 +0200
Organization: glandium.org
Message-ID: <20080907082059.GA26705@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 07 10:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcFXY-0004kR-JK
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 10:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYIGIVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 04:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYIGIVO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 04:21:14 -0400
Received: from vuizook.err.no ([194.24.252.247]:59547 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbYIGIVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 04:21:12 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KcFW4-0004xk-GP; Sun, 07 Sep 2008 10:21:10 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KcFVz-0007Aj-ET; Sun, 07 Sep 2008 10:20:59 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95126>

Hi,

While rebasing old branches on master, I saw that I still had this
patch[1] ahead, to which you replied with [2]. I might be guilty of not
replying back then, but I think your version should be applied.

Cheers,

Mike

1. http://marc.info/?l=git&m=120362183916288&w=2
2. http://marc.info/?l=git&m=120363548506950&w=2
