From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon, 07 Jul 2008 16:44:41 +0200
Message-ID: <48722BD9.4090406@free.fr>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr> <alpine.DEB.1.00.0807071400180.18205@racer> <48722038.1010203@free.fr> <alpine.DEB.1.00.0807071505470.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFry4-0006eF-9G
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbYGGOob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 10:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbYGGOob
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:44:31 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:47534 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbYGGOoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:44:30 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D5AEF12B71C;
	Mon,  7 Jul 2008 16:44:29 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 84B4012B6CF;
	Mon,  7 Jul 2008 16:44:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0807071505470.18205@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87618>

Johannes Schindelin a =E9crit :
>=20
> Okay, but then the obvious question is: what do you do about "<<<<<<"=
=20
> lines that are not a marker?

The answer is the same.

> Same remark as before: if you fix rerere, why not do it properly?

If you have a better fix send a patch or at least give me some clues.

Olivier.
