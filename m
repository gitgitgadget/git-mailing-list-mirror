From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding menu for Emacs git.el
Date: Mon, 10 Dec 2007 22:36:59 -0800
Message-ID: <7vhciphh4k.fsf@gitster.siamese.dyndns.org>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
	<87fxylos4o.fsf@wine.dyndns.org>
	<877ijwfh6z.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ykR-0002Ff-CB
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbXLKGhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 01:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbXLKGhS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:37:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXLKGhR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 01:37:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB604929;
	Tue, 11 Dec 2007 01:37:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 238464928;
	Tue, 11 Dec 2007 01:37:06 -0500 (EST)
In-Reply-To: <877ijwfh6z.dlv@vanicat.homelinux.org> (Remi Vanicat's message of
	"Mon, 03 Dec 2007 07:03:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67804>

Remi Vanicat <vanicat@debian.org> writes:

> Adding three menus to the git-status-mode of git.el : One for marking
> and unmarking, one for what you do when you have a conflict, and the
> other one for all the rest.
>
> Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
> ---
>
> Alexandre Julliard <julliard@winehq.org> writes:
>
>> "=3D?utf-8?q?R=3DC3=3DA9mi=3D20Vanicat?=3D" <vanicat@debian.org>, Re=
mi Vanicat
>> <vanicat@debian.org> writes:
>>
>>> Adding three menu to the git-status-mode of git.el : One for markin=
g
>>> and unmarking, one for every thing you need when you have a conflic=
t,
>>> and a last one for all the rest.
>>>
>>> Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
>>
>> It looks good to me. A couple of minor details:
>
> Here is the corrected patch
> [...]
>
>> BTW do you have a copyright assignment for Emacs?
> No, should I seek one ?

Alex, what is the current status of this patch?
