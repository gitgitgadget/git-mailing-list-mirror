From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Wed, 11 Oct 2006 22:08:10 -0300
Message-ID: <egk4im$njm$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjang$nmh$1@sea.gmane.org> <egjllu$6k8$1@sea.gmane.org> <egjmri$atp$1@sea.gmane.org> <egjnk5$bpn$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 12 03:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXp55-00032N-VS
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 03:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWJLBJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 21:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWJLBJe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 21:09:34 -0400
Received: from main.gmane.org ([80.91.229.2]:33436 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965248AbWJLBJd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 21:09:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXp4R-0002v7-FH
	for git@vger.kernel.org; Thu, 12 Oct 2006 03:09:11 +0200
Received: from 200.213.42.52 ([200.213.42.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 03:09:11 +0200
Received: from pazu by 200.213.42.52 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 03:09:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.213.42.52
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <egjnk5$bpn$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28765>

Jakub Narebski wrote:

> But isn't it _required_ by XML/XHTML?

According to the XML 1.0 specification, section 2.8:

[Definition: XML documents should begin with a XML declaration which 
specifies the version of XML being used]

I believe that the use of 'should' instead of 'must' here makes it 
highly recommended, but not strictly required. Anyway, the comments in 
my previous message (the 'browser support is what really matters' part) 
remain valid.

-- Marcus
