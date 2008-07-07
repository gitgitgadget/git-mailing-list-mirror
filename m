From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] imap-send.c: Clean up coding style to better match
 the rest of the git codebase.
Date: Mon, 07 Jul 2008 01:49:41 -0700
Message-ID: <7vfxqm5ba2.fsf@gitster.siamese.dyndns.org>
References: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rob Shearman" <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 10:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFmQs-0003uw-5H
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 10:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYGGItu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYGGItu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 04:49:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYGGItt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 04:49:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CF3D11B0D;
	Mon,  7 Jul 2008 04:49:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D3C8E11AFF; Mon,  7 Jul 2008 04:49:43 -0400 (EDT)
In-Reply-To: <1096648c0807070105s2b4ea1d9t2ab1eb17e891e3e8@mail.gmail.com>
 (Rob Shearman's message of "Mon, 7 Jul 2008 09:05:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7BA9694-4C01-11DD-95D7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87594>

These patches seem to have been linewrapped severely.  I _could_ fix them
up and apply, but the last one being about whitespace and style fixes, I'd
rather not.
