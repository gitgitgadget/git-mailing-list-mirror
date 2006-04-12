From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Subject: Re: how to make a git-format patch
Date: 12 Apr 2006 16:04:16 +0200
Organization: Uh?
Message-ID: <m3sloiriu7.fsf@localhost.localdomain>
References: <6d6a94c50604120328ufa09f0do76c04472206ae15f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 16:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTfyH-0001kW-Bw
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 16:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDLOFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDLOFV
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 10:05:21 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:60427 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751144AbWDLOFU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 10:05:20 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1312.wanadoo.fr (SMTP Server) with ESMTP id 04FD3700009A
	for <git@vger.kernel.org>; Wed, 12 Apr 2006 16:05:19 +0200 (CEST)
Received: from bigip.bigip.mine.nu (AMarseille-252-1-124-143.w86-216.abo.wanadoo.fr [86.216.35.143])
	by mwinf1312.wanadoo.fr (SMTP Server) with ESMTP id D09697000090;
	Wed, 12 Apr 2006 16:05:18 +0200 (CEST)
X-ME-UUID: 20060412140518854.D09697000090@mwinf1312.wanadoo.fr
Received: from localhost.localdomain (shookaylt.bigip.mine.nu [10.0.1.11])
	by bigip.bigip.mine.nu (8.13.6/8.13.6) with ESMTP id k3CE4H9Z031609;
	Wed, 12 Apr 2006 16:04:17 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k3CE4HH9027014;
	Wed, 12 Apr 2006 16:04:17 +0200
Received: (from mchouque@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k3CE4HJJ027011;
	Wed, 12 Apr 2006 16:04:17 +0200
X-Authentication-Warning: localhost.localdomain: mchouque set sender to ml2news@free.fr using -f
To: aubreylee@gmail.com (Aubrey)
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
In-Reply-To: <6d6a94c50604120328ufa09f0do76c04472206ae15f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18631>

aubreylee@gmail.com (Aubrey) writes:
> But I saw most of the git-format patches have a header in the front of
> the patch file, like:

I believe you're talking about 'git whatchanged -p' which not only displays
the diffs but also the commit comments.

-- 
Mathieu Chouquet-Stringer
