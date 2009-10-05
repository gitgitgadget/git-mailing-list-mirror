From: Anders Melchiorsen <mail@spoon.kalibalik.dk>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 05 Oct 2009 21:43:55 +0200
Message-ID: <87ab05r5hg.fsf@dylle.kalibalik.dk>
References: <4AC8F22F.5070101@gmail.com>
	<alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
	<6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
	<alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de>
	<fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
	<6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mutft-0006HR-HT
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbZJETzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbZJETzq
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:55:46 -0400
Received: from mail.hotelhot.dk ([97.107.140.94]:53998 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbZJETzp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 15:55:45 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2009 15:55:45 EDT
Received: from dylle.kalibalik.dk (unknown [77.75.167.238])
	by mail.hotelhot.dk (Postfix) with ESMTPSA id ECF956C0B2;
	Mon,  5 Oct 2009 21:43:56 +0200 (CEST)
Received: from dylle.kalibalik.dk (localhost [127.0.0.1])
	by dylle.kalibalik.dk (Postfix) with ESMTP id 725136E5;
	Mon,  5 Oct 2009 21:43:55 +0200 (CEST)
In-Reply-To: <6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Mon\, 5 Oct 2009
 18\:10\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129583>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> Thanks for the comments. "reword" it will be then. I'll send a new pa=
tch soon.

If you could also make it possible to edit the commit summary line
right in the git-rebase-todo buffer, that would be great.

Being in an editor but still not able to fix typos is a nuisance.


Cheers,
Anders.
