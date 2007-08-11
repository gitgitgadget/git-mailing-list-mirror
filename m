From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add: Add a --refresh option.
Date: Sat, 11 Aug 2007 13:05:17 -0700
Message-ID: <7v7io1n8g2.fsf@assigned-by-dhcp.cox.net>
References: <87bqdeweds.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxDA-0000WP-8p
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbXHKUFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbXHKUFT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:05:19 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61038 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbXHKUFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:05:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811200517.NNGM3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 16:05:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ak5H1X00m1kojtg0000000; Sat, 11 Aug 2007 16:05:18 -0400
In-Reply-To: <87bqdeweds.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Sat, 11 Aug 2007 12:32:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55625>

Alexandre Julliard <julliard@winehq.org> writes:

> This allows to refresh only a subset of the project files, based on
> the specified pathspecs.

Makes sense.  Tests and docs?
