From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to import stuff?
Date: Wed, 25 Jan 2006 16:16:01 -0800
Message-ID: <7vr76vkfni.fsf@assigned-by-dhcp.cox.net>
References: <43D80C77.70207@f2s.com> <20060125234239.GA5426@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ian Molton <spyro@f2s.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 01:16:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1uo3-0003kx-Cf
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 01:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWAZAQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 19:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWAZAQE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 19:16:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1016 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751265AbWAZAQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 19:16:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126001505.OAHJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 19:15:05 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060125234239.GA5426@fieldses.org> (J. Bruce Fields's message
	of "Wed, 25 Jan 2006 18:42:39 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15146>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Wed, Jan 25, 2006 at 11:40:39PM +0000, Ian Molton wrote:
>> git add . adds all the new files, but there seems to be no equivalent to 
>> remove files
>
> That happens on commit without the need for any special command.
>
> --b.

... as long as you say "git commit -a", that is.
