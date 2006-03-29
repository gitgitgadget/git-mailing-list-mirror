From: Romain Francoise <romain@orebokech.com>
Subject: Re: Is 'merge' in your path?
Date: Wed, 29 Mar 2006 12:14:08 +0200
Organization: orebokech dot com
Message-ID: <87mzf9eexb.fsf@pacem.orebokech.com>
References: <CFF307C98FEABE47A452B27C06B85BB6046AA9@hdsmsx411.amr.corp.intel.com>
	<tnxmzf9sh7k.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Ericsson" <ae@op5.se>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 12:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOXh1-0003h0-Jh
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 12:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWC2KOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 05:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWC2KOS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 05:14:18 -0500
Received: from yeast.orebokech.com ([82.67.41.165]:26256 "EHLO
	yeast.orebokech.com") by vger.kernel.org with ESMTP
	id S1750743AbWC2KOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 05:14:17 -0500
Received: from pacem.orebokech.com (pacem.orebokech.com [192.168.1.3])
	by yeast.orebokech.com (Postfix) with ESMTP id 75CFE12E60;
	Wed, 29 Mar 2006 12:14:08 +0200 (CEST)
Received: by pacem.orebokech.com (Postfix, from userid 1000)
	id 2733F523E2; Wed, 29 Mar 2006 12:14:08 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
X-Face: }9mYu,e_@+e!`Z-P5kVXa3\_b:hdJ"B)ww[&=b<2=awG:GOIM</2q'*t@MNa)R`k0h1KbUu "Ek%gXCQA(?k=Uf9}qgF_x#7/+Ql\R!NJ9[Z[ky\CTYI<H(kc][?[m%*rsf!OG11|f&H[VgX;),"!N JG6IziY\~""3M
In-Reply-To: <tnxmzf9sh7k.fsf@arm.com> (Catalin Marinas's message of "Wed, 29
	Mar 2006 11:01:03 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18165>

Catalin Marinas <catalin.marinas@arm.com> writes:

> Are there any features in "merge" and not available in "diff3"?

`merge' from GNU RCS is just a wrapper around diff3.

-- 
Romain Francoise <romain@orebokech.com> | The sea! the sea! the open
it's a miracle -- http://orebokech.com/ | sea! The blue, the fresh, the
                                        | ever free! --Bryan W. Procter
