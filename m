From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: coming from git, understanding mercurial branching
Date: Fri, 6 Sep 2013 17:40:21 +0100
Organization: OPDS
Message-ID: <E27274C44BAD4DAE92D9D89AA9591CEF@PhilipOakley>
References: <20130905212714.636db4c4@bigbox.christie.dr> <20130906175124.7d08947410503681449642ad@domain007.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Konstantin Khomoutov" <flatworm@users.sourceforge.net>
To: "Tim Chase" <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHz4n-0004Ur-8g
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517Ab3IFQjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:39:55 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:35904 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757208Ab3IFQjw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 12:39:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwNAEoEKlJOl3GZ/2dsb2JhbABbgwc1iTm4ZAEDAQMBgSUXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwMJJRQBBBoGBxcGEwgCAQIDAYU4BwGCEiMIvgmPfIMkgQADiH2GEooVkDeBOoFnOw
X-IPAS-Result: AvwNAEoEKlJOl3GZ/2dsb2JhbABbgwc1iTm4ZAEDAQMBgSUXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwMJJRQBBBoGBxcGEwgCAQIDAYU4BwGCEiMIvgmPfIMkgQADiH2GEooVkDeBOoFnOw
X-IronPort-AV: E=Sophos;i="4.90,855,1371078000"; 
   d="scan'208";a="587673991"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with SMTP; 06 Sep 2013 17:39:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234059>

From: "Konstantin Khomoutov" <flatworm@users.sourceforge.net>
To: "Tim Chase" <git@tim.thechases.com>
> On Thu, 5 Sep 2013 21:27:14 -0500
> Tim Chase <git@tim.thechases.com> wrote:
>
> [...]
>> Do any git users here have good "understanding Mercurial branches
>> for the git user" resources they've found helpful when working with
>> Mercurial?  Preferably a "for dummies" resource with illustrations &
>> comparison charts so I can see the big picture.
>
> I found this guide [1] very useful back in the time I tried to grok
> Mercurial.
>
> 1. 
> http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial/
> --
Tim,
Another recent blog is 
http://felipec.org/2013/08/27/analysis-of-hg-and-git-branches/ by Felipe 
Contreras who wrote Git's official GitMercurial bridge; git-remote-hg

Philip 
