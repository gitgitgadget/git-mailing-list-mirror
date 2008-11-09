From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Init on push
Date: Sat, 08 Nov 2008 16:13:11 -0800
Message-ID: <7vmyg9bvu0.fsf@gitster.siamese.dyndns.org>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com>
 <7v3ai2c5sd.fsf@gitster.siamese.dyndns.org>
 <200811082144.25261.fg@one2team.com> <200811082150.24583.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 01:16:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyxz4-0000Zu-7Z
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 01:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbYKIANb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYKIANb
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 19:13:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbYKIANb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 19:13:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE5437ABD0;
	Sat,  8 Nov 2008 19:13:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8B3897ABCD; Sat,
  8 Nov 2008 19:13:18 -0500 (EST)
In-Reply-To: <200811082150.24583.fg@one2team.net> (Francis Galiegue's message
 of "Sat, 8 Nov 2008 21:50:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3CB7AEDC-ADF3-11DD-84A1-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100430>

=46rancis Galiegue <fg@one2team.net> writes:

> Le Saturday 08 November 2008 21:44:25 Francis Galiegue, vous avez =C3=
=A9crit=C2=A0:
> [...]
>>
>> I personnaly think that the directory creation SHOULD be created
>
> I meant "handled", sorry.

Why have we ended up losing the most important Cc: to the original patc=
h
submitter who asked if the idea of his patch is sound?
