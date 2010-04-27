From: Miles Bader <miles@gnu.org>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Tue, 27 Apr 2010 11:10:13 +0900
Message-ID: <87wrvtfxx6.fsf@catnip.gol.com>
References: <4B7D8358.1080108@gmail.com>
	<fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	<4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
	<4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
	<4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>
	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
	<m2u86ecb3c71004261646zd17cafdcy85cd2ce522a771d5@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 04:10:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6aFm-0004bl-WC
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 04:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab0D0CKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 22:10:20 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:45411 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab0D0CKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 22:10:19 -0400
Received: from 218.231.253.147.eo.eaccess.ne.jp ([218.231.253.147] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1O6aFa-0006Ll-DY; Tue, 27 Apr 2010 11:10:14 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 9FD1EDF93; Tue, 27 Apr 2010 11:10:13 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <m2u86ecb3c71004261646zd17cafdcy85cd2ce522a771d5@mail.gmail.com>
	(Dmitrijs Ledkovs's message of "Tue, 27 Apr 2010 00:46:50 +0100")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145870>

Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com> writes:
> As far as I know bzr-git can fetch, clone, commit and push to/from
> bzr/git repos. Not sure why you would want git-bzr

In general people want this because they prefer the
UI/functionality/speed/etc of the git client over that of the bzr
client, but also want to interact with a project that uses a bzr repo.

So, something like git-bzr is necessary for this (though
"git-remote-bzr" is sounding like it will be the future).

Thanks,

-Miles

-- 
We have met the enemy, and he is us.  -- Pogo
