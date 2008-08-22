From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Fix one-liner in p4_write_pipe function.
Date: Thu, 21 Aug 2008 23:21:23 -0700
Message-ID: <7vd4k1d0yk.fsf@gitster.siamese.dyndns.org>
References: <1219353100-1692-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 08:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWQ2d-0003et-7C
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 08:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbYHVGVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 02:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbYHVGVa
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 02:21:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbYHVGVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 02:21:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0399D66A0F;
	Fri, 22 Aug 2008 02:21:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 667FE66A0B; Fri, 22 Aug 2008 02:21:25 -0400 (EDT)
In-Reply-To: <1219353100-1692-1-git-send-email-torarvid@gmail.com> (Tor Arvid
 Lund's message of "Thu, 21 Aug 2008 23:11:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E4AD5CC-7012-11DD-A7A6-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93258>

Looks obviously correct.  Mind if I forge your sign-off?
