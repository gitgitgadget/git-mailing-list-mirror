From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Apr 2011, #01; Sun, 3)
Date: Mon, 04 Apr 2011 09:21:30 +0200
Message-ID: <4D99717A.1030902@web.de>
References: <7v62quc464.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 09:21:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6e6V-0001Oq-3S
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 09:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab1DDHVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 03:21:34 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57448 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1DDHVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 03:21:34 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id A4E4819BC6BE5;
	Mon,  4 Apr 2011 09:21:32 +0200 (CEST)
Received: from [93.246.37.182] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q6e6O-0007Wi-00; Mon, 04 Apr 2011 09:21:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7v62quc464.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19gUQiQsU+jkLasCkJT3qqL+BpkPKwfL7F0PmLK
	CfuplAtEZBBATVUiTqiMT+1fm884mFoGwr/7VlVCBrj8wUR0zX
	IisgwbHnJt8NPY8TsZTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170793>

Am 04.04.2011 01:21, schrieb Junio C Hamano:
> * nm/maint-conflicted-submodule-entries (2011-03-30) 1 commit
>   (merged to 'next' on 2011-04-03 at 40c5094)
>  + submodule: process conflicting submodules only once
> 
> A fix to a rather common operation and the implementation looked
> low-impact enough.  Do submodule people want this in 1.7.5?

I concur and think this should go into 1.7.5.
