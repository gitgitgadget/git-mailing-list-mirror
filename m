From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pushing specific branches to a public mirror repos
Date: Fri, 17 Jul 2009 12:05:01 +0200
Message-ID: <4A604CCD.5090108@viscovery.net>
References: <h3pcrg$ekk$1@ger.gmane.org> <4A603B7A.6050208@viscovery.net> <h3pf9d$mo7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 12:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRkJX-00016d-KV
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 12:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934353AbZGQKFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 06:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934349AbZGQKFF
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 06:05:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49724 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934348AbZGQKFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 06:05:05 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRkJJ-0005U8-Oy; Fri, 17 Jul 2009 12:05:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 81EE56D9; Fri, 17 Jul 2009 12:05:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <h3pf9d$mo7$1@ger.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123457>

Graeme Geldenhuys schrieb:
> Must this stay as is, or must I push 'remotes/trunk' to 'heads/master'?
> 
>      push = +refs/remotes/trunk:refs/heads/trunk
> vs
>      push = +refs/remotes/trunk:refs/heads/master

Both are OK. Pick the one that suits your needs.

-- Hannes
