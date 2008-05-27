From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: msysGit: "git filter-branch --subdirectory-filter" doesn't work
 at all
Date: Tue, 27 May 2008 22:57:17 +0200
Message-ID: <483C75AD.5080206@dirk.my1.cc>
References: <483B0FF8.6070700@dirk.my1.cc> <alpine.DEB.1.00.0805262233190.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 27 22:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K16FV-0006sy-VZ
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbYE0U5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756474AbYE0U5V
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:57:21 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:44153 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442AbYE0U5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:57:20 -0400
Received: from [84.176.66.110] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K16EQ-000413-Mt; Tue, 27 May 2008 22:57:18 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0805262233190.30431@racer>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83050>

Johannes Schindelin schrieb:
> Hi,
>
> On Mon, 26 May 2008, Dirk S=FCsserott wrote:
>
>  =20
>> $ git filter-branch --subdirectory-filter perl
>>    =20
>
> And what branch, exactly, do you want to rewrite?  You did not specif=
y=20
> _any_ branch here.
>
> Ciao,
> Dscho
Hi,

thanks, that helped a lot. As said, I've no
actual use case for git-filter-branch but was just curious
about the usage. So this wasn't an issue with msysGit or
Windows, even though I thought that at first glance.

As I noticed from one of your replies to the
'Commit cce8d6fdb introduces...' thread, you seem to be
somewhat annoyed by people asking for Windows compatibility.
That was not the case here, I just wanted to state that. ;-)

To my opinion the --subdirectory-filter switch isn't documented
very well. When I find out and have an example, I'll post it.

    Dirk
