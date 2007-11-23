From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 08:05:03 -0800
Message-ID: <7v63ztuevk.fsf@gitster.siamese.dyndns.org>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	<8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	<7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
	<200711231018.49322.jnareb@gmail.com>
	<7vejehux3y.fsf@gitster.siamese.dyndns.org>
	<8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
	<7vabp5uhke.fsf@gitster.siamese.dyndns.org>
	<8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 17:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivb25-0002yi-KM
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 17:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbXKWQFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 11:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbXKWQFO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 11:05:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49386 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbXKWQFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 11:05:12 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9B7282EF;
	Fri, 23 Nov 2007 11:05:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 15BC8981D7;
	Fri, 23 Nov 2007 11:05:27 -0500 (EST)
In-Reply-To: <8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Fri, 23 Nov 2007 16:34:27
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65904>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>> > OK. So git push will never understand bundles.
>>
>> Why not?
>
> Sorry, I misunderstood you, because pushing to an existing
> bundle loses information, and that is also inconsistent with pushing
> to regular repositories.

Maybe I am missing something from the discussion, but what
information loss are you referring to?
