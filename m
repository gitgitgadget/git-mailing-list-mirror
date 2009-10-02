From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to delete large files
Date: Fri, 02 Oct 2009 15:41:46 +0200
Message-ID: <4AC6031A.2070409@viscovery.net>
References: <C6EB1E10.D7AB%nilshomer@gmail.com> <237967ef0910020526w51c05570g606ebc16e0b4a3e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nils Homer <nilshomer@gmail.com>, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 15:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtiP1-0002K1-Uu
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 15:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871AbZJBNmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 09:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757865AbZJBNmW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 09:42:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4789 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469AbZJBNmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 09:42:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MtiOe-0005ay-Dz; Fri, 02 Oct 2009 15:42:08 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5C2929F88; Fri,  2 Oct 2009 15:42:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <237967ef0910020526w51c05570g606ebc16e0b4a3e7@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129441>

Mikael Magnusson schrieb:
> Well, you just gave "HEAD" to git filter-branch to rewrite, i think
> you want --all to rewrite all refs you have.

... and '--tag-filter cat' to rewrite tags as well.

-- Hannes
