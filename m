From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-receive-pack.c: fix compiler warnings about
 format string
Date: Sun, 15 Feb 2009 11:34:03 -0800
Message-ID: <7v3aeflck4.fsf@gitster.siamese.dyndns.org>
References: <1234721938.17613.21.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmmL-00069v-Mh
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbZBOTeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbZBOTeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:34:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbZBOTeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:34:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 312EC9A5AC;
	Sun, 15 Feb 2009 14:34:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45CFA9A5AB; Sun,
 15 Feb 2009 14:34:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9CE39CF2-FB97-11DD-93A7-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110041>

Thanks.
