From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: HTTP error 511 [Was: Secure (https) proxy authentification]
Date: Tue, 21 Feb 2012 10:44:45 +0100
Message-ID: <f5ee5676efa057beb51b00237a6c13b2.squirrel@arekh.dyndns.org>
References: <009e3177ab4b0f3de7ea47fa17118458.squirrel@arekh.dyndns.org>
    <689660A9-8EAD-4EE6-8B4D-401E73F13941@bblfish.net>
    <4ec05cf797322715a960743aeec0a48b.squirrel@arekh.dyndns.org>
    <39d91a07ae0beb19a734e52496ab5700.squirrel@arekh.dyndns.org>
    <4F4363C1.90902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: squid3@treenet.co.nz, ietf-http-wg@w3.org,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Daniel Stenberg" <daniel@haxx.se>, git@vger.kernel.org
To: "Julian Reschke" <julian.reschke@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 21 10:44:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzmHJ-0000Ut-D3
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 10:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab2BUJow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 04:44:52 -0500
Received: from smtpout3.laposte.net ([193.253.67.228]:29587 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab2BUJov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 04:44:51 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8505-out with ME
	id cZko1i0034WQcrc03ZkoL3; Tue, 21 Feb 2012 10:44:48 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id 174671D3;
	Tue, 21 Feb 2012 10:44:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKACzjQu073r; Tue, 21 Feb 2012 10:44:45 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Tue, 21 Feb 2012 10:44:45 +0100 (CET)
Received: from 192.196.142.27
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Tue, 21 Feb 2012 10:44:45 +0100
In-Reply-To: <4F4363C1.90902@gmx.de>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191148>


Le Mar 21 f=C3=A9vrier 2012 10:28, Julian Reschke a =C3=A9crit :
> On 2012-02-21 09:58, Nicolas Mailhot wrote:

>> Could you please revise the error 511 definition to add such a field=
 ?
>
> The specification has already been approved, so it's too late to make
> more than editorial changes.

I know it has been approved, and we'll go with it as is for now on our =
network.
However, could it be extended to add this location field later please? =
(taking
into account the tool authors' feedback)

Best regards,

--=20
Nicolas Mailhot
