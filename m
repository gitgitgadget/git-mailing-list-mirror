From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] help: use parseopt
Date: Mon, 25 Feb 2008 07:50:52 +0100
Message-ID: <200802250750.53047.chriscool@tuxfamily.org>
References: <cover.1203890846.git.peff@peff.net> <20080224221655.GB31309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTX67-0002i1-Jk
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 07:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbYBYGpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 01:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbYBYGpN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 01:45:13 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:59207 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbYBYGpL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 01:45:11 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 459381AB2C9;
	Mon, 25 Feb 2008 07:45:09 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 15B161AB2BD;
	Mon, 25 Feb 2008 07:45:08 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080224221655.GB31309@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74995>

Le dimanche 24 f=C3=A9vrier 2008, Jeff King a =C3=A9crit :
> This patch converts cmd_help to use parseopt, along with a
> few style cleanups, including:
>
>   - enum constants are now ALL_CAPS

Ok.

>   - parse_help_format returns an enum value rather than
>     setting a global as a side effect

Nice cleanup.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Sorry, the diff turned out quite messy because of the cleanups. It's
> probably easier to just read the result.

Or could you send the cleanups in some separated patches ?

Thanks in advance,
Christian.
