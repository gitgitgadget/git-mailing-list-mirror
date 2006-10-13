From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Fri, 13 Oct 2006 11:09:31 -0300
Message-ID: <ego6nn$l78$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjnk5$bpn$2@sea.gmane.org> <200610120745.00909.robin.rosenberg.lists@dewire.com> <200610122321.18630.jnareb@gmail.com> <ego2nk$3nm$1@sea.gmane.org> <ego331$568$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 13 16:13:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYNlY-0005wg-8L
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 16:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJMOLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWJMOLt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 10:11:49 -0400
Received: from main.gmane.org ([80.91.229.2]:24272 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750842AbWJMOLt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 10:11:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYNkc-0005dl-NC
	for git@vger.kernel.org; Fri, 13 Oct 2006 16:11:02 +0200
Received: from 200.213.42.52 ([200.213.42.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 16:11:02 +0200
Received: from pazu by 200.213.42.52 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 16:11:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.213.42.52
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <ego331$568$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28848>

Jakub Narebski wrote:

> Well, there is yet another solution. Do browser detection, and do not output
> <?xml ... ?> declaration for IE. Perhaps that would be best solution.

Well, there's now drawback in removing the XML declaration (no browser 
requires it), so why even worry about browser detection?

-- Marcus
