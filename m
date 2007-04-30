From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Checklist clarifications: added "Commits", "Patch:" headings
Date: Mon, 30 Apr 2007 15:02:50 +0300
Organization: Private
Message-ID: <abwqxe6t.fsf@cante.net>
References: <r6q2xgws.fsf@cante.net>
	<Pine.LNX.4.64.0704301333400.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 14:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiUcx-0007x0-EM
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 14:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031546AbXD3MFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 08:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031550AbXD3MFG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 08:05:06 -0400
Received: from main.gmane.org ([80.91.229.2]:34487 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031546AbXD3MFE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 08:05:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HiUco-0004ks-Bl
	for git@vger.kernel.org; Mon, 30 Apr 2007 14:05:02 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 14:05:02 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 14:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:qHfKNl6f5mCbl4m8L6YdbMcltGw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45863>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 30 Apr 2007, Jari Aalto wrote:
>
>> +	- send your patch to <git@vger.kernel.org> by using
>> +	  git-format-patch(1) with option "-M". See also
>> +	  git-send-email(1).
>>  	- do not PGP sign your patch
>> -	- use "git format-patch -M" to create the patch
>
> NACK.
>
> I never use send-email myself. There are even technical issues to my 
> excuse: sometimes I cannot send the mails from my machine. So, this should 
> not be a _replacement_ for `git format-patch -M && send mail manually`, 
> but only an _alternative_.
>
> However, my impression was that many people had problems when first 
> sending patches with send-email. There should be _at least_ a word of 
> caution, that you should test the operation on something different than 
> the Git list first.

Is this workding okay?

        - send your patch to <git@vger.kernel.org> by using
          git-format-patch(1) with option "-M". If you use  
          git-send-email(1), please test it first by sending 
          email to yourself.

Jari
