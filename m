From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git push: Interpret $GIT_DIR/branches in a Cogito
 compatible way
Date: Tue, 11 Nov 2008 16:52:01 -0800
Message-ID: <7vd4h1u5ou.fsf@gitster.siamese.dyndns.org>
References: <1226440260-26943-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:53:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03zN-00030V-6W
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbYKLAw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYKLAw3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:52:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYKLAw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:52:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5B127C5BD;
	Tue, 11 Nov 2008 19:52:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBD967C5BB; Tue,
 11 Nov 2008 19:52:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D6A57BE-B054-11DD-BF91-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100708>

Thanks, will start cooking in 'next'.
