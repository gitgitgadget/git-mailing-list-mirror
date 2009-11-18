From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Nov 2009, #04; Tue, 17)
Date: Wed, 18 Nov 2009 09:40:53 +0100
Message-ID: <4B03B315.2080407@viscovery.net>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 09:41:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAg63-0007MP-RO
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 09:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbZKRIkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 03:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbZKRIkw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 03:40:52 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46286 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753473AbZKRIkw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 03:40:52 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NAg5u-0004OP-27; Wed, 18 Nov 2009 09:40:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BDA799F88; Wed, 18 Nov 2009 09:40:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133156>

Junio C Hamano schrieb:
> * rj/cygwin-msvc (2009-11-09) 3 commits.
>  - Add explicit Cygwin check to guard WIN32 header inclusion
>  - MSVC: Add support for building with NO_MMAP
>  - Makefile: keep MSVC and Cygwin configuration separate
>  (this branch uses rj/maint-simplify-cygwin-makefile.)
> 
> I think J6t was not happy with the tip one.

Ramsay suggested to drop the one at the tip, and I agree. The other two
patches are good.

-- Hannes
