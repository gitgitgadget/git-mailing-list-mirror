From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] Document git commit --untracked-files and --verbose
Date: Sat, 16 Jun 2007 13:06:27 -0700
Message-ID: <7vr6ob3br0.fsf@assigned-by-dhcp.pobox.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
	<11820206363507-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 22:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzeXW-0001DE-WC
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 22:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbXFPUGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXFPUG3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 16:06:29 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52300 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbXFPUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 16:06:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070616200629.JRZD6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 16:06:29 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CL6T1X00b1kojtg0000000; Sat, 16 Jun 2007 16:06:28 -0400
In-Reply-To: <11820206363507-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sat, 16 Jun 2007 21:03:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50306>

Jakub Narebski <jnareb@gmail.com> writes:

> +-u|--untracked-files::
> +	Show all untracked files, also those in uninteresting
> +	directories.
> +
> +-v|--verbose::
> +	Show the diff output between the HEAD commit and what
> +	would be committed.
> +

Thanks -- "show" sounds a bit funny, though, don't you think?
