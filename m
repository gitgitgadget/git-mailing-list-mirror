From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable)
Date: Sat, 28 Jul 2007 02:02:40 -0700
Message-ID: <7vk5sksxxr.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
	<85zm1g3nze.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 11:02:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEiCF-0005T1-7m
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 11:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXG1JCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 05:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbXG1JCo
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 05:02:44 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62799 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbXG1JCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 05:02:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728090243.POWG7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 05:02:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ux2g1X00H1kojtg0000000; Sat, 28 Jul 2007 05:02:43 -0400
In-Reply-To: <85zm1g3nze.fsf@lola.goethe.zz> (David Kastrup's message of "Sat,
	28 Jul 2007 10:56:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54016>

David Kastrup <dak@gnu.org> writes:

> I'd like to see some changes for mergetool's Emacs support: in
> moderately current versions of Emacs and XEmacs, ediff is a much
> preferable tool to emerge.

Between ediff and emerge, I think Ted gave a well thought out
analysis on the list earlier, so you might want to consider the
issues he raised if/when you tackle this.

This is late in the game, however, so your change probably won't
be merged before I can tag 1.5.3 final, but I'd expect that a
better Emacs support will be widely welcomed.
