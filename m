From: cho <tobutaz@gmail.com>
Subject: Re: [PATCH] git-svn: handle our top-level path is deleted and later
 re-added
Date: Sat, 15 Dec 2007 00:24:39 +0000 (UTC)
Message-ID: <fjv6s7$6ht$1@ger.gmane.org>
References: <475C8748.6000005@cryos.net>
	<20071210104235.GA7521@xp.machine.xx> <20071213164134.GD18433@soma>
	<20071213181312.GA4441@xp.machine.xx> <20071214163909.GA18300@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 01:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3KqD-0005wn-JO
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 01:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXLOAYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 19:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXLOAYx
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 19:24:53 -0500
Received: from main.gmane.org ([80.91.229.2]:32770 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbXLOAYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 19:24:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J3Kpi-0004tt-89
	for git@vger.kernel.org; Sat, 15 Dec 2007 00:24:46 +0000
Received: from pro75-5-88-162-203-35.fbx.proxad.net ([88.162.203.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 00:24:46 +0000
Received: from tobutaz by pro75-5-88-162-203-35.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 00:24:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pro75-5-88-162-203-35.fbx.proxad.net
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68364>

Thanks, this fixes a problem I had reported previously:
http://permalink.gmane.org/gmane.comp.version-control.git/61516

I'm not sure how I get to keep the git repository (branches) I previously 
had, but it's not too bad.
