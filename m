From: Miles Bader <miles@gnu.org>
Subject: Re: multiple-commit cherry-pick?
Date: Thu, 06 Nov 2008 21:14:18 +0900
Message-ID: <buozlkd6oh1.fsf@dhapc248.dev.necel.com>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
	<20081106032437.GA27237@euler> <20081106095122.GA2656@atjola.homenet>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 06 13:15:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky3m5-00048e-2t
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 13:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbYKFMOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 07:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbYKFMOb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 07:14:31 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:41632 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYKFMOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 07:14:30 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mA6CEJMn018685;
	Thu, 6 Nov 2008 21:14:19 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Thu, 6 Nov 2008 21:14:19 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Thu, 6 Nov 2008 21:14:19 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 1CC5F3BD; Thu,  6 Nov 2008 21:14:18 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20081106095122.GA2656@atjola.homenet> (=?iso-8859-1?Q?=22Bj?=
 =?iso-8859-1?Q?=F6rn?= Steinbrink"'s
	message of "Thu, 6 Nov 2008 10:51:22 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100231>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> git reset --hard C
> git rebase --onto ORIG_HEAD A^

Is that safe...?  Doesn't git-rebase also set ORIG_HEAD?

-Miles

--=20
Twice, adv. Once too often.
