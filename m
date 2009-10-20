From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] git-gui: Allow staging multiple lines at once
Date: Tue, 20 Oct 2009 08:11:20 +0200
Message-ID: <4ADD5488.5020808@viscovery.net>
References: <20091019195456.GA11121@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N07wP-0002ht-9s
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZJTGLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbZJTGLT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:11:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41427 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZJTGLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:11:18 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N07wH-0001rs-7V; Tue, 20 Oct 2009 08:11:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EF7B69F88; Tue, 20 Oct 2009 08:11:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091019195456.GA11121@unpythonic.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130759>

Jeff Epler schrieb:
> When applying less than a full hunk, it's still often desirable to apply
> a number of consecutive lines.
> 
> This change makes it possible to sweep out a range of lines in the diff view
> with the left mouse button, then right click and "Stage Lines For Commit".
> 
> The selected lines may span multiple hunks.

Superb! Will test.

-- Hannes
