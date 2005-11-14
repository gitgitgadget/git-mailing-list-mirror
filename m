From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Question] info/grafts file.
Date: Mon, 14 Nov 2005 12:56:37 -0800
Message-ID: <7vhdafx81m.fsf@assigned-by-dhcp.cox.net>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 21:59:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EblNZ-00034S-Ty
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 21:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVKNU4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 15:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVKNU4j
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 15:56:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17142 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932119AbVKNU4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 15:56:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114205606.TEMC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 15:56:06 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051114182019.GA19105@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Mon, 14 Nov 2005 11:20:19 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11847>

Grafts are considered local preference, and not copied when
cloned.  I am unsure this was a right decision, but that is how
things are right now.
