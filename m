From: Erik Broes <erikbroes@ripe.net>
Subject: Re: [PATCH] git-shell: Add 'git-upload-archive' to allowed commands.
Date: Sun, 12 Apr 2009 16:07:49 +0200
Message-ID: <49E1F5B5.6090500@ripe.net>
References: <49DE537C.8070907@ripe.net> <7v3acff10x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 16:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt0Nd-0007Ix-6o
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 16:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbZDLOH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbZDLOH5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 10:07:57 -0400
Received: from postgirl.ripe.net ([193.0.19.66]:45367 "EHLO postgirl.ripe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbZDLOH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 10:07:57 -0400
Received: from herring.ripe.net ([193.0.1.203])
	by postgirl.ripe.net with esmtp (Exim 4.63)
	(envelope-from <erikbroes@ripe.net>)
	id 1Lt0Le-0001dh-0A; Sun, 12 Apr 2009 16:07:50 +0200
Received: from Grumm.local (gw.office.nsrp.ripe.net [193.0.1.126])
	by herring.ripe.net (Postfix) with ESMTP id E52942F583;
	Sun, 12 Apr 2009 16:07:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <7v3acff10x.fsf@gitster.siamese.dyndns.org>
X-RIPE-Spam-Level: ----
X-RIPE-Signature: a3d33ccd309479c043417935190f954d46964606caf7301f1b166d72d1508eae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116379>

> Can't the "security concern" be addressed by whatever creates the
> controlled environment (e.g. gitosis)?  For example, git-daemon can be
> configured to service upload-archive request, so I do not think it is such
> a bad idea to make this available if the site owner wants to use it.

I completely agree. :)

-- 
Erik Broes
Database Group
RIPE NCC
