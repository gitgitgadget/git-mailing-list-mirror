From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: don't use pathinfo for global actions
Date: Wed, 07 Jan 2009 13:19:11 -0800
Message-ID: <7vzli295m8.fsf@gitster.siamese.dyndns.org>
References: <1230896080-22801-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200901061837.23637.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Devin Doucette <devin@doucette.cc>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKfpc-0000VE-A8
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 22:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761738AbZAGVTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761688AbZAGVTV
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 16:19:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761657AbZAGVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 16:19:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F03378EDB3;
	Wed,  7 Jan 2009 16:19:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C6C148EDAE; Wed,
  7 Jan 2009 16:19:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D84E1804-DD00-11DD-B599-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104832>

Jakub Narebski <jnareb@gmail.com> writes:

> Therefore it really needs to be in, as df63fb also by Giuseppe
> (gitweb: use href() when generating URLs in OPML) is already in,
> and I think gitweb would generate broken OPML and TXT links without
> this patch.
> ...
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks for reminding me.  Queued.
