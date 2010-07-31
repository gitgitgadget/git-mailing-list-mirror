From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Sat, 31 Jul 2010 17:28:11 +0200
Message-ID: <4C54410B.704@gnu.org>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>	<4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 17:28:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfDzD-0001mZ-1w
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 17:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab0GaP21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 11:28:27 -0400
Received: from lo.gmane.org ([80.91.229.12]:36685 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533Ab0GaP20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 11:28:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OfDz5-0001ji-B3
	for git@vger.kernel.org; Sat, 31 Jul 2010 17:28:23 +0200
Received: from s209p8.home.99maxprogres.cz ([85.93.118.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 17:28:23 +0200
Received: from bonzini by s209p8.home.99maxprogres.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 17:28:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: s209p8.home.99maxprogres.cz
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100621 Fedora/3.0.5-1.fc13 Lightning/1.0b2pre Thunderbird/3.0.5
In-Reply-To: <vpqd3u53sd2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152330>

On 07/30/2010 05:24 PM, Matthieu Moy wrote:
> Marc Branchaud<marcnarc@xiplink.com>  writes:
>
>>> The name of the command may be subject to discussions. I've chosen
>>> "run", but maybe "shell" would be OK too. In both cases, it doesn't
>>> allow the one-letter version since both "r" and "s" are already used.
>>
>> "exec" with one-letter "x"?
>
> Thanks, that sounds good, yes. Any other thought?

I like run, for the short version what about ! (as in vi)?  Maybe with 
an optional space.

Paolo
