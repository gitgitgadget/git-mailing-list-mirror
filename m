From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: Make ECMerge use the settings as specified by the user in the GUI
Date: Sun, 11 May 2008 21:08:13 +0200
Message-ID: <54B4FE81-30F2-4B4B-BE47-91661EF9745F@zib.de>
References: <482038C4.6050402@visageimaging.com> <183DBDB1-99BE-42C5-91DE-2488046164B7@zib.de> <7vy76g4uis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@visageimaging.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 21:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGv3-0002Qz-KQ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 21:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbYEKTIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 15:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbYEKTIB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 15:08:01 -0400
Received: from mailer.zib.de ([130.73.108.11]:57457 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbYEKTIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 15:08:00 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4BJ7ZGW022620;
	Sun, 11 May 2008 21:07:35 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db97dd2.pool.einsundeins.de [77.185.125.210])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4BJ7UJq017387
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 May 2008 21:07:34 +0200 (MEST)
In-Reply-To: <7vy76g4uis.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81814>


On May 11, 2008, at 7:31 PM, Junio C Hamano wrote:

>> I tested the change and propose to take the patch.  I needed,
>> however, to remove dos line endings from the patch before it
>> applied cleanly.
>
> Thanks, I did not have that "apply" problem.

Indeed, it is Mac OS X's Mail.app that exports mails with the
wrong line endings.  I did not recognize this before, so I guess
something changed with OS X 10.5, which I installed recently.

	Steffen
