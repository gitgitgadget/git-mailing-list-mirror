From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] mergetool: support setting path to tool as config var mergetool.<tool>.path
Date: Sun, 14 Oct 2007 14:52:25 +0200
Message-ID: <06B63221-7F8E-42FF-959F-D83FBABA6790@zib.de>
References: <11919632613176-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 14 14:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih2w4-00050U-HD
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 14:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198AbXJNMvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 08:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbXJNMvA
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 08:51:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:38611 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498AbXJNMu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 08:50:59 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9ECotSh008066;
	Sun, 14 Oct 2007 14:50:55 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db109af.pool.einsundeins.de [77.177.9.175])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9ECosiH029388
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 14 Oct 2007 14:50:55 +0200 (MEST)
In-Reply-To: <11919632613176-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60844>


On Oct 9, 2007, at 10:54 PM, Steffen Prohaska wrote:

> This commit adds a mechanism to provide absolute paths to the
> external programs called by 'git mergetool'. A path can be
> specified in the configuation variable mergetool.<tool>.path.

Any news on this patch?
Will you apply it (or recommend that Junio does)?

	Steffen
