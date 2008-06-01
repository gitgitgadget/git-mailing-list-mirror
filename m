From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sun, 1 Jun 2008 21:07:44 +0200
Message-ID: <97942300-E8AC-4AC6-AD4D-6EEA2198E5D9@wincent.com>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de> <20080531182555.1646.47950.stgit@localhost.localdomain> <5DBABAFE-C447-4E5D-A7E8-0C16B4D1D960@wincent.com> <alpine.DEB.1.00.0806010018300.13507@racer.site.net>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 01 21:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2svL-0007iY-Ij
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 21:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbYFATIA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2008 15:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYFATIA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 15:08:00 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:54950 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYFATH7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jun 2008 15:07:59 -0400
Received: from cuzco.lan (157.pool85-53-24.dynamic.orange.es [85.53.24.157])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m51J7jJA015770
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 1 Jun 2008 15:07:48 -0400
In-Reply-To: <alpine.DEB.1.00.0806010018300.13507@racer.site.net>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83463>

El 1/6/2008, a las 1:19, Johannes Schindelin escribi=F3:

> Hi,
>
> On Sat, 31 May 2008, Wincent Colaiuta wrote:
>
>> El 31/5/2008, a las 20:28, Jakub Narebski escribi=F3:
>>
>>> Testing if gitweb handles filenames with spaces, filenames with plu=
s
>>> sign ('+') which encodes spaces in CGI parameters (in URLs), and
>>> filenames with Unicode characters should be handled by gitweb tests=
=2E
>>>
>>> Those files are remainder of the time when gitweb was project on it=
s
>>> own, not a part of git (with its testsuite).
>>>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>
>> Ack.
>
> And I thought "Ack" was reserved for the people who are considered th=
e
> primary authors of the patched code...

I had no idea. Thanks for letting me know.

Wincent
