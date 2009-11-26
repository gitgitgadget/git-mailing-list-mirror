From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to ~/.gitexcludes.
Date: Thu, 26 Nov 2009 13:49:54 +0100
Message-ID: <helthi$8k5$1@ger.gmane.org>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr> <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr> <4B0E6DC9.3070105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 13:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDdnm-0005v0-Pu
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 13:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbZKZMuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 07:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbZKZMuN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 07:50:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:42667 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbZKZMuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 07:50:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NDdnc-0005rW-3a
	for git@vger.kernel.org; Thu, 26 Nov 2009 13:50:16 +0100
Received: from nat-pool-brq-t.redhat.com ([209.132.186.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 13:50:16 +0100
Received: from bonzini by nat-pool-brq-t.redhat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 13:50:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-pool-brq-t.redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-3.9.b4.fc12 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <4B0E6DC9.3070105@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133791>

On 11/26/2009 01:00 PM, Michael J Gruber wrote:
> I'm sorry to jump in so late, and this may sound like bike-shedding, but
> right now we have
>
> .git/info/exclude
> .gitignore
>
> and this would add
>
> ~/.gitexcludes
>
> That is, three terms, or two, where one comes in two variations
> (exclude/exludes). I always wondered why we have two.

Would you be fine with ~/.gitexclude?

Paolo
