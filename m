From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Bug in git-show with "%ai" and "%ci" formats?
Date: Mon, 29 Oct 2007 15:28:07 +0100
Message-ID: <ED7A9BBE-14D2-4B87-9598-305E3E30C1A2@wincent.com>
References: <4A647262-B69A-4DB6-942C-18C45458B169@wincent.com> <Pine.LNX.4.64.0710291331310.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 15:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImVbU-0005Il-Hp
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 15:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbXJ2O2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Oct 2007 10:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbXJ2O2T
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 10:28:19 -0400
Received: from wincent.com ([72.3.236.74]:54601 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988AbXJ2O2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2007 10:28:19 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9TESAjL031122;
	Mon, 29 Oct 2007 09:28:11 -0500
In-Reply-To: <Pine.LNX.4.64.0710291331310.4362@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62620>

El 29/10/2007, a las 14:32, Johannes Schindelin escribi=F3:

> On Mon, 29 Oct 2007, Wincent Colaiuta wrote:
>
>> Can anybody reproduce the following behaviour? Basically all the =20
>> author and
>> committer date formats documented in the git-show man page work =20
>> except for
>> "%ai" and "%ci". This is with Git 1.5.2.4 running on Darwin 9.0.0:
>
> It was added in v1.5.3-rc2~17.
>
> Usually, it is a good idea to use the documentation which =20
> corresponds with
> the git version you are using ;-)

Doh... funny... This was only yesterday; I installed 1.5.2.4 =20
(stupidly, a typo) and the 1.5.3.4 man pages. If I'd just done a "git =20
stash" or something I would've realized that I was using an older =20
version...

Cheers,
Wincent
