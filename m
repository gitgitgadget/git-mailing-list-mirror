From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 19:09:51 -0500
Message-ID: <4F6BBF4F.9080302@gmail.com>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net> <4F6BB425.2010807@gmail.com> <7vlimsur95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Anjib Mulepati <anjibcs@hotmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 01:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAs54-0006N6-K8
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 01:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760238Ab2CWAKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 20:10:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:50752 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758440Ab2CWAKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 20:10:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SAs4w-0006FB-Sd
	for git@vger.kernel.org; Fri, 23 Mar 2012 01:10:03 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 01:10:02 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 01:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <7vlimsur95.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193738>

On 3/22/2012 6:53 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> See this thread for the "cons" of nested git repos: (I don't think
>> there are any "pros".)
>> http://thread.gmane.org/gmane.comp.version-control.git/190372
>
> Hmph, I see you saying "I will keep this in mind" and "Thanks" at the end,
> and back then I took it that you understood why/how nested working trees
> are useful.  Perhaps you didn't and I misunderstood you?

I neglected to distinguish between ignored-nested-git-repos (has pros) 
and tracked-subdir-nested-git-repos (has no pros) in my preface to the 
thread link.  That was an oversight on my part.

BTW, I'm am still being compelled to deal with 
tracked-subdir-nested-git-repos and I have not found any pros to them so 
your original assessment of that technique still stands. ;-)

v/r,
neal
