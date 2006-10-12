From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Wed, 11 Oct 2006 21:26:36 -0300
Message-ID: <egk24r$hgb$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjang$nmh$1@sea.gmane.org> <egjllu$6k8$1@sea.gmane.org> <egjmri$atp$1@sea.gmane.org> <egjnk5$bpn$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 12 02:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXoQG-00076w-JQ
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 02:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbWJLA1a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 20:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030693AbWJLA1a
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 20:27:30 -0400
Received: from main.gmane.org ([80.91.229.2]:39877 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030691AbWJLA12 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 20:27:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXoPs-00071o-K2
	for git@vger.kernel.org; Thu, 12 Oct 2006 02:27:16 +0200
Received: from 200.213.42.52 ([200.213.42.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 02:27:16 +0200
Received: from pazu by 200.213.42.52 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 02:27:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.213.42.52
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <egjnk5$bpn$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28764>

Jakub Narebski wrote:

>> The XML declaration forces IE6 into quirks mode, breaking our
>> nice standards compliant stylesheet.
> 
> But isn't it _required_ by XML/XHTML?

As far as I know, it isn't. But even if the specs required it, none of 
the popular browsers do, and since we're talking about a web page 
intended for presentation (as opposed to automated data processing), 
that's what matters.

-- Marcus
