From: Markus Wanner <markus@bluegap.ch>
Subject: Re: [Monotone-devel] Re: [ANN] mtn2git v0.1
Date: Mon, 15 Sep 2008 11:07:02 +0200
Message-ID: <48CE25B6.40608@bluegap.ch>
References: <94a0d4530809121559w5f644174j461ec61cb2327fd8@mail.gmail.com>	<m3d4j8nzy9.fsf@localhost.localdomain>	<94a0d4530809130352v5775be53sc14b354b8c1dae15@mail.gmail.com>	<200809131402.11413.jnareb@gmail.com>
	<94a0d4530809130821h6f424695xe09386243c3213c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@pidgin.im, openembedded-devel@openembedded.org,
	monotone-devel@nongnu.org, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: devel-bounces@pidgin.im Mon Sep 15 11:08:14 2008
Return-path: <devel-bounces@pidgin.im>
Envelope-to: gcgg-gaim-devel-259@gmane.org
Received: from homing.pidgin.im ([69.31.24.85])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfA45-0002ko-RW
	for gcgg-gaim-devel-259@gmane.org; Mon, 15 Sep 2008 11:08:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by homing.pidgin.im (Postfix) with ESMTP id 81D6648F66;
	Mon, 15 Sep 2008 05:07:09 -0400 (EDT)
Received: from homing.pidgin.im ([127.0.0.1])
	by localhost (homing.pidgin.im [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bgVSqR3iVyP; Mon, 15 Sep 2008 05:07:08 -0400 (EDT)
Received: from homing.pidgin.im (localhost [127.0.0.1])
	by homing.pidgin.im (Postfix) with ESMTP id 6ED3E48F24;
	Mon, 15 Sep 2008 05:07:08 -0400 (EDT)
X-Original-To: devel@pidgin.im
Delivered-To: devel@pidgin.im
Received: from localhost (localhost [127.0.0.1])
	by homing.pidgin.im (Postfix) with ESMTP id 4FCB048F24
	for <devel@pidgin.im>; Mon, 15 Sep 2008 05:07:05 -0400 (EDT)
Received: from homing.pidgin.im ([127.0.0.1])
	by localhost (homing.pidgin.im [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkZdhjhwLGgX for <devel@pidgin.im>;
	Mon, 15 Sep 2008 05:07:05 -0400 (EDT)
Received: from nabagan.bluegap.ch (nabagan.bluegap.ch [88.198.58.248])
	by homing.pidgin.im (Postfix) with ESMTP id 11DFD48F1D
	for <devel@pidgin.im>; Mon, 15 Sep 2008 05:07:04 -0400 (EDT)
Received: from [192.168.0.238] (berlin.programmfabrik.de
	[::ffff:213.221.101.147]) (AUTH: CRAM-MD5 markus@bluegap.ch)
	by nabagan.bluegap.ch with esmtp; Mon, 15 Sep 2008 11:07:03 +0200
	id 006707CA.48CE25B7.00004EA6
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <94a0d4530809130821h6f424695xe09386243c3213c3@mail.gmail.com>
X-Pidgin-SpamProbe: GOOD 0.0000136 014f62d9d13d29b48c2cb97ea1f9a1e1
X-Pidgin-Spam-Flag: Clean
X-BeenThere: devel@pidgin.im
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Discussion about the development of Pidgin,
	Finch and libpurple" <devel.pidgin.im>
List-Unsubscribe: <http://pidgin.im/cgi-bin/mailman/listinfo/devel>,
	<mailto:devel-request@pidgin.im?subject=unsubscribe>
List-Archive: <http://pidgin.im/pipermail/devel>
List-Post: <mailto:devel@pidgin.im>
List-Help: <mailto:devel-request@pidgin.im?subject=help>
List-Subscribe: <http://pidgin.im/cgi-bin/mailman/listinfo/devel>,
	<mailto:devel-request@pidgin.im?subject=subscribe>
Sender: devel-bounces@pidgin.im
Errors-To: devel-bounces@pidgin.im
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95893>

Hi,

Felipe Contreras wrote:
> Monotone can have multiple heads in one single branch, but from what I
> understand that mostly happens locally (not on the published repo).

Uh.. no, I'd say quite the opposite: if multiple developers work on the 
same branch and do their commits, the first time both heads appear in 
the same branch on the same machine will be the public repository.

> Anyway, If that happens the commits are still there, just dangling
> temporarily in no branch.

..for the mtn repo imported into git that is, right?

Regards

Markus Wanner (ne Schiltknecht)
