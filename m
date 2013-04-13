From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git instaweb - share all project files
Date: Sat, 13 Apr 2013 20:02:01 +0000
Message-ID: <20130413200201.GA13323@dcvr.yhbt.net>
References: <CAMg8Y2pFXrbh8cz6m5z=LsksRijLVcV4fTk-TBx+9yaQTtAzpA@mail.gmail.com>
 <51659B5B.6000707@gmail.com>
 <CAMg8Y2qm9FuuMZh7jsAEyr=joUbsp=5V_zU5U86sW0Y=f2OVBA@mail.gmail.com>
 <51697812.6020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Trenton D. Adams" <trenton.d.adams@gmail.com>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 22:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR6eM-0005Yq-FM
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab3DMUCD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Apr 2013 16:02:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55423 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab3DMUCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 16:02:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491781F435;
	Sat, 13 Apr 2013 20:02:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51697812.6020106@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221068>

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> Unfortunately it turns out such simple solution doesn't really work.
>=20
> First, for some reason Firefox 20.0 refuses to follow file:/// link,
> even though it shows correctly worktree if copy'n'pasted as URL in ne=
w
> window / new tab.

I can confirm this behavior with chromium on Debian testing
(25.0.1364.160 (Developer Build 186726) Debian 7.0)

I can guess this is likely for security reasons.
