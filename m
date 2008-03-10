From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] autoconf: Test FREAD_READS_DIRECTORIES
Date: Sun, 09 Mar 2008 23:21:27 -0700
Message-ID: <7vy78rksk8.fsf@gitster.siamese.dyndns.org>
References: <200803092144.04440.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Mon Mar 10 07:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYbOt-0002pG-Da
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 07:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYCJGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 02:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYCJGVl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 02:21:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYCJGVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 02:21:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18A8F122D;
	Mon, 10 Mar 2008 02:21:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8DB54122C; Mon, 10 Mar 2008 02:21:35 -0400 (EDT)
In-Reply-To: <200803092144.04440.michal.rokos@nextsoft.cz> (Michal Rokos's
 message of "Sun, 9 Mar 2008 21:44:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76699>

Looks fine to me.  I was not keeping on an close eye on the discussion,
however.  Can we have a list of platforms we saw success stories on, so
that I can mention them when I queue this?
