From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the requirement opaquelocktoken uri scheme
Date: Sat, 20 Dec 2008 12:09:36 -0800
Message-ID: <7vabaqwqv3.fsf@gitster.siamese.dyndns.org>
References: <7vljucbows.fsf@gitster.siamese.dyndns.org>
 <1229753986-5193-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8AA-0001oF-3l
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYLTUJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbYLTUJl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:09:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbYLTUJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:09:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CC218739E;
	Sat, 20 Dec 2008 15:09:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B57F98739A; Sat,
 20 Dec 2008 15:09:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2248510A-CED2-11DD-98F2-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103661>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> ...
> This resulted in push failure (often resulted in "cannot lock existing
> info/refs" error message) when talking to a server that does not use
> opaquelocktoken URI scheme.
>
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>

Thanks.
