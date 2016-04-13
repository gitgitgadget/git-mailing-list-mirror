From: Stephen Kelly <steveire@gmail.com>
Subject: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 22:36:53 +0200
Message-ID: <nemal5$mb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:37:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqRXs-00056L-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 22:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbcDMUhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 16:37:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:38868 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbcDMUhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 16:37:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aqRX7-0004gI-Te
	for git@vger.kernel.org; Wed, 13 Apr 2016 22:37:06 +0200
Received: from x55b39f7f.dyn.telefonica.de ([85.179.159.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 22:37:05 +0200
Received: from steveire by x55b39f7f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 22:37:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x55b39f7f.dyn.telefonica.de
User-Agent: KNode/4.14 pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291482>

Hi,

If I look at git commit 89ea90351dd32fbe384d0cf844640a9c55606f3b in gitk, it 
does not linkify the v1.6.0-rc0~120^2 in the commit message. 

Is there any reason for that, or can gitk be changed?

Thanks,

Steve.
