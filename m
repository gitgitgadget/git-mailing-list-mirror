From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Problem with cogito and Linux tree tags
Date: Thu, 02 Jun 2005 21:36:05 +0200
Message-ID: <429F5FA5.2030306@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 02 21:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdvR6-0001r4-A4
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFBTgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVFBTgA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 15:36:00 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:34176 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261260AbVFBTfz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 15:35:55 -0400
Received: (qmail 11648 invoked from network); 2 Jun 2005 19:35:52 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 2 Jun 2005 19:35:52 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 4C5E35833D1
	for <git@vger.kernel.org>; Thu,  2 Jun 2005 21:36:05 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

My cg-version is:
cogito-0.10 (20e473c9afd8b5d2d549b0e7881473600beb9c37)

cg-tag-ls output is:
v2.6.11    5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
v2.6.11-tree    5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
v2.6.12-rc2    9e734775f7c22d2f89943ad6c745571f1930105f
v2.6.12-rc3    0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
v2.6.12-rc4    ebb5573ea8beaf000d4833735f3e53acb9af844c
v2.6.12-rc5    06f6d9e2f140466eeb41e494e14167f90210f89d

The ID of the commit that says "Linux 2.6.12-rc5" is:
137318b273db26b889675101fbd02d2e84cae5e3

The v2.6.12-rc5 tag hash isn't a tree or commit hash, it is unusable.
I don't know what causes that...

AstralStorm
