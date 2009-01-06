From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: suggest name for OPML view
Date: Tue, 06 Jan 2009 00:18:14 -0800
Message-ID: <7vhc4cluex.fsf@gitster.siamese.dyndns.org>
References: <1230900570-25324-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7AG-0007cQ-6E
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZAFISW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZAFISW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:18:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZAFISV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:18:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A8A78DE27;
	Tue,  6 Jan 2009 03:18:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2C57D8DE25; Tue,
  6 Jan 2009 03:18:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9475D3A6-DBCA-11DD-A254-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104651>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Suggest opml.xml as name for OPML view by providing the appropriate
> header, consistently with similar usage in project_index view.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I think this makes sense; will apply unless there is any objection.
