From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 0/4] remote show/prune improvement
Date: Tue, 10 Jun 2008 18:10:37 +0200
Message-ID: <484EA77D.7040003@free.fr>
References: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>	<1213109413-6842-1-git-send-email-dkr+ml.git@free.fr> <m3ej75pbrw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 18:11:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K66RS-0001BZ-LN
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 18:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbYFJQKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbYFJQKc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 12:10:32 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:39980 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbYFJQKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 12:10:31 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C372C12B6CE;
	Tue, 10 Jun 2008 18:10:30 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 53B4F12B752;
	Tue, 10 Jun 2008 18:10:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <m3ej75pbrw.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84522>

Jakub Narebski a =E9crit :
> Olivier Marin <dkr+ml.git@free.fr> writes:
>=20
>>   [1/4] remote show: fix the -n option
>>   [2/4] builtin-remote: split show_or_prune() in two separate functi=
ons.
>>   [3/4] remote prune: print the list of pruned branches
>>   [4/4] remote show: list tracked remote branches with -n.
>>
>>  Documentation/git-remote.txt |    9 +--
>>  builtin-remote.c             |  160 ++++++++++++++++++++++++++++++-=
-----------
>=20
> I like this series... but the [4/4] lacks documentation (all other
> patches update documentation).
>=20

I'm not sure, it's a minor change. Perhaps, I can squashed it in 1/4 in=
stead.

What do you think?

Olivier.
