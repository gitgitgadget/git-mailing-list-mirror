From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style part 3
Date: Mon, 15 Sep 2008 21:09:41 -0700
Message-ID: <7v7i9c91fe.fsf@gitster.siamese.dyndns.org>
References: <20080913171836.GA5597@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Andreas Ericsson <ae@op5.se>,
	Thomas Rast <trast@student.ethz.ch>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Tue Sep 16 06:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfRwH-0003Zr-23
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 06:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbYIPEJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 00:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbYIPEJy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 00:09:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYIPEJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 00:09:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83D665F10F;
	Tue, 16 Sep 2008 00:09:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BC4015F10B; Tue, 16 Sep 2008 00:09:43 -0400 (EDT)
In-Reply-To: <20080913171836.GA5597@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 13 Sep 2008 20:18:36 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4EC3B8F0-83A5-11DD-9D3F-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95969>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> User notifications are presented as 'git cmd', and code comments
> are presented as '"cmd"' or 'git's cmd', rather than 'git-cmd'.
>
> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---
> Part 3 resent. A small fix from Thomas Rast for builtin-tar-tree.c.

I did not see anything wrong in the patch; thanks.
