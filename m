From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GitStats development finished (WRT GSoC)
Date: Wed, 30 Jul 2008 00:07:10 -0700
Message-ID: <7vabfz97fl.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807291511v2d70d549r3682291eb10a745d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sam Vilain" <sam@vilain.net>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Jul 30 09:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO5nh-0002Wd-1m
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 09:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbYG3HH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757507AbYG3HHZ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 03:07:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499AbYG3HHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 03:07:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 71C4A4CEBA;
	Wed, 30 Jul 2008 03:07:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 768174CEB9; Wed, 30 Jul 2008 03:07:12 -0400 (EDT)
In-Reply-To: <bd6139dc0807291511v2d70d549r3682291eb10a745d@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed, 30 Jul 2008 00:11:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2761EFEE-5E06-11DD-A6EC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90755>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> ...  As a
> result it is quite clear what GitStats will look like at the end of my
> GSoC. I am going to continue working on it though, I am especially
> interested in getting the '--follow' part of 'git log' working in such
> a way that it can be incorporated into GitStats. As such, here is a
> summary of what GitStat is at the moment. From the documentation:

Wonderful.

> syntax: stats.py bug <options>
>
> The purpose of the bug module is to gather statistics on
> bugfixes within the content, and to aggregate this
> information to provide with a report of the last N commits.

Can't wait running this, especially in conjunction with the "author" stuff
;-)
