From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Escape --upload-pack from expr.
Date: Tue, 30 Jan 2007 11:19:03 -0800
Message-ID: <7v4pq8z5js.fsf@assigned-by-dhcp.cox.net>
References: <20070130181149.GA26655@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByVt-0000wE-DH
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXA3TTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbXA3TTH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:19:07 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35641 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbXA3TTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:19:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130191903.NNGU16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jan 2007 14:19:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HXJ41W00G1kojtg0000000; Tue, 30 Jan 2007 14:18:04 -0500
In-Reply-To: <20070130181149.GA26655@spearce.org> (Shawn O. Pearce's message
	of "Tue, 30 Jan 2007 13:11:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38193>

Good catch; thanks.
