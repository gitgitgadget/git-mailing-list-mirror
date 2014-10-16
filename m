From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git download ---  Virus
Date: Thu, 16 Oct 2014 13:48:36 +0400
Message-ID: <20141016134836.062c143b3d90a0f70e181234@domain007.com>
References: <17221679.285681413452133349.JavaMail.defaultUser@defaultHost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "risto.makiniemi@pp.inet.fi" <risto.makiniemi@pp.inet.fi>
X-From: git-owner@vger.kernel.org Thu Oct 16 11:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xehfo-0003CB-Kw
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 11:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbaJPJsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 05:48:41 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:39180 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaJPJsk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 05:48:40 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s9G9maMw017059;
	Thu, 16 Oct 2014 13:48:37 +0400
In-Reply-To: <17221679.285681413452133349.JavaMail.defaultUser@defaultHost>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Oct 2014 12:35:33 +0300 (EEST)
"risto.makiniemi@pp.inet.fi" <risto.makiniemi@pp.inet.fi> wrote:

> I downloaded and started to Install Git.
> 
> There is a Virus on you setup.
> Program that appears to have trojan-like features or behavior.
> 
> Git/bin/pdfinfo.exe
> 
> trojan.generic.[variant], gen:trojan.[variant]
> 
> Why???

Because your antivirus software applies its (seemingly imperfect)
heuristics and thinks there's a virus while there's none.

To state this in a more blunt way: no there's no any virus in the Git
for Windows installation package.

The other possibility is you obtaining the installation package from
a place other than http://git-scm.com or some malware active on your
computer is changing the packages you're downloading on the fly.  The
latter is highly unlikely though.
