From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix fetch with deleted tag
Date: Sun, 15 Aug 2010 06:55:00 +0000
Message-ID: <20100815065500.GA29542@dcvr.yhbt.net>
References: <1281794831-33347-1-git-send-email-ddkilzer@kilzer.net> <AANLkTinpLUyQP=6XktduWAmSHg3CgcT3Y7cMJ9FQ4by_@mail.gmail.com> <84607.29034.qm@web30003.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Aug 15 08:55:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkX7c-0007cO-R3
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 08:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab0HOGzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 02:55:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44760 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124Ab0HOGzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 02:55:00 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F97A1F509;
	Sun, 15 Aug 2010 06:55:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <84607.29034.qm@web30003.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153596>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Thanks for the feedback!  I've already applied your other suggestions=
=2E

Thanks David and =C6var!

David: Everything looks alright to me with =C6var's suggestions, so I'l=
l
ack whenever you have the final patch ready.


On a related note, if anybody has the time/patience to do some grunt
work: converting all existing and fragile "cd" usage to use subshells
would be much appreciated and help set better examples for introducing
new code.

--=20
Eric Wong
