From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 10:20:41 -0700
Message-ID: <7vejnragie.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	<7v6494dwms.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
	<7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
	<7vwt1jaiiu.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703141012n6fc252ecsd5ed3bc7283cf10f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRX9a-00076C-Fr
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 18:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXCNRUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 13:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbXCNRUn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 13:20:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48293 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbXCNRUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 13:20:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314172043.CXLY24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 13:20:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ahLh1W00i1kojtg0000000; Wed, 14 Mar 2007 13:20:42 -0400
In-Reply-To: <81b0412b0703141012n6fc252ecsd5ed3bc7283cf10f@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 18:12:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42217>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Updated patch:
> - implemented exit_with_status+has_changes
> - fixed test WRT intermediate failures

Thanks.
