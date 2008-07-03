From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 0/3] Making remote tracking statistics available to other
 tools
Date: Thu, 03 Jul 2008 21:25:30 +0200
Message-ID: <486D27AA.405@free.fr>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net> <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org> <7v3amsg1wx.fsf@gitster.siamese.dyndns.org> <486CFDA3.9070704@free.fr> <7v8wwi23dr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEURI-0003WC-3P
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYGCTY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbYGCTY6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:24:58 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:48439 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbYGCTY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:24:58 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id F20A912B6CC;
	Thu,  3 Jul 2008 21:24:56 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5A66F12B73B;
	Thu,  3 Jul 2008 21:24:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v8wwi23dr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87307>

Junio C Hamano a =C3=A9crit :
>=20
>  remote.c                 |    4 +++
>  revision.h               |    1 +
>  t/t6040-tracking-info.sh |   52 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 57 insertions(+), 0 deletions(-)

Tested: it works. Thanks.

Olivier.
