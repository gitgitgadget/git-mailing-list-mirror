From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: .git as file pointing to directory?
Date: Fri, 05 Nov 2010 00:28:20 +0100
Message-ID: <4CD34194.8010002@web.de>
References: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com>	<vpqpqulc52q.fsf@bauges.imag.fr> <4CD31904.5040308@web.de> <vpqbp64d9e0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad Larson <bklarson@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 05 00:28:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE9EJ-0006NS-Tm
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 00:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab0KDX2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 19:28:23 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51613 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0KDX2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 19:28:22 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id D397517DDAEBF;
	Fri,  5 Nov 2010 00:28:20 +0100 (CET)
Received: from [93.240.104.42] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PE9EC-0005f0-00; Fri, 05 Nov 2010 00:28:20 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <vpqbp64d9e0.fsf@bauges.imag.fr>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+x1Y4OtZ8A+oflEgbIffD2nfn0wolKuG6OEaRf
	W3K2X1EiFTA9InnzbBHWmObGde+j5i2DkJBekzWLTBkyVQhc0U
	17OL7+3fRTXq+sVf9qkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160793>

Am 04.11.2010 23:14, schrieb Matthieu Moy:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 04.11.2010 19:32, schrieb Matthieu Moy:
>>> Brad Larson <bklarson@gmail.com> writes:
>>>
>>>> Sorry if this is obvious, I can't figure out what term to search for.
>>>>
>>>> At gittogether there was some talk about having .git be a file, not a
>>>> folder, with contents pointing to the real .git directory.  Similar to
>>>> a symlink, but supported in Windows.  Is there a specific name for
>>>> this feature?  Where can I find more details?  Which version of git
>>>> introduced this?
>>>
>>> It has been discussed under the name "gitlink", which was
>>> unfortunately also used for something else in the subtree
>>> implementation, but AFAIK, it has never been implemented.
>>
>> Hmm, AFAIK gitlinks are already in heavy use for submodule entries ...
> 
> Err, isn't that precisely what I was saying? The same word has been
> used in the subtree implementation, but the other concept with the
> same name hasn't been implemented.

Sorry, seems like I misunderstood what you where saying.
