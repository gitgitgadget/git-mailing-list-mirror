From: Florian Weimer <fweimer@bfk.de>
Subject: Fast-forward-only merge
Date: Fri, 24 Jul 2009 09:50:47 +0000
Message-ID: <82ws5y4dfs.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 11:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUHR2-0007PR-W4
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbZGXJus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 05:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZGXJus
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 05:50:48 -0400
Received: from mx01.bfk.de ([193.227.124.2]:52653 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbZGXJur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 05:50:47 -0400
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	id 1MUHUt-0002Kk-Jl
	for git@vger.kernel.org; Fri, 24 Jul 2009 11:55:27 +0200
Received: by bfk.de with local id 1MUHQN-0007oY-2B
	for git@vger.kernel.org; Fri, 24 Jul 2009 09:50:47 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123913>

Is there an easy way to require that "git merge" succeeds only if the
merge is fast-forward?

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
