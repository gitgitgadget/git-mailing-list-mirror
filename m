From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 20:13:41 -0700
Message-ID: <7vtzetkviy.fsf@gitster.siamese.dyndns.org>
References: <20080710170735.4c5b237a@linux360.ro>
 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
 <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
 <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
 <32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
 <7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
 <32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
 <7vlk05o14i.fsf@gitster.siamese.dyndns.org>
 <32541b130807131642k1382cf84gdf5e8bb8d2ff4ffe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 05:15:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIEWn-0004Kx-6A
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 05:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbYGNDNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 23:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbYGNDNu
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 23:13:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbYGNDNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 23:13:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F99017D73;
	Sun, 13 Jul 2008 23:13:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E7BCF17D71; Sun, 13 Jul 2008 23:13:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0689BFC-5152-11DD-BA34-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88372>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> If git is going to start actually producing mbox files (as opposed to
> just individual messages as it does now), it should probably
> explicitly take a stance on the issue...

Yeah, that makes one reason I should not be enthusiastic to take this
patch.
