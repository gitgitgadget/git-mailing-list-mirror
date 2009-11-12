From: =?UTF-8?B?THXDrXMgU291c2E=?= <llsousa@ualg.pt>
Subject: Re: Idea for git-touch
Date: Thu, 12 Nov 2009 17:13:01 +0000
Message-ID: <4AFC421D.1090509@ualg.pt>
References: <4AFC348B.4000202@ualg.pt>	<20091112180132.5819f963@perceptron>	<4AFC4051.5030607@ualg.pt> <20091112180841.001ae651@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8dEb-0002LU-TL
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbZKLRNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 12:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbZKLRNO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:13:14 -0500
Received: from smtp3.ualg.pt ([193.136.224.6]:36666 "EHLO smtp3.ualg.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbZKLRNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 12:13:14 -0500
Received: from localhost (smtp3.ualg.pt [127.0.0.1])
	by smtp3.ualg.pt (Postfix) with ESMTP id 3AD7C16877;
	Thu, 12 Nov 2009 17:13:19 +0000 (WET)
Received: from smtp3.ualg.pt ([127.0.0.1])
 by localhost (host.domain.tld [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 02086-03; Thu, 12 Nov 2009 17:13:18 +0000 (WET)
Received: from [193.136.224.174] (unknown [193.136.224.174])
	by smtp3.ualg.pt (Postfix) with ESMTP id 2698F16872;
	Thu, 12 Nov 2009 17:13:18 +0000 (WET)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20091112180841.001ae651@perceptron>
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132787>

Yeah, but still need some copy&paste of message :)

Jan Kr=C3=BCger wrote:
> On Thu, 12 Nov 2009 17:05:21 +0000, Lu=C3=ADs Sousa <llsousa@ualg.pt>=
 wrote:
>  =20
>> But still preserves the original date, isn't it?
>>    =20
>
> Yes, and I just remembered that, too. Sorry. Today is not my day.
>
> Even so, you can still save one command:
>
>   git reset --soft HEAD^
>   git commit
>
> Jan
>
>
>  =20
