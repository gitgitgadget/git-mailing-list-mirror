From: Bill Lear <rael@zopyra.com>
Subject: Re: GIT v1.5.1-rc1
Date: Mon, 19 Mar 2007 07:21:35 -0600
Message-ID: <17918.36447.419632.224014@lisa.zopyra.com>
References: <20070306063501.GA24355@spearce.org>
	<7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
	<20070306071630.GB24004@spearce.org>
	<7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
	<7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 14:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTHo0-0004GJ-EW
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 14:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286AbXCSNVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 09:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933565AbXCSNVj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 09:21:39 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60156 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933286AbXCSNVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 09:21:38 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2JDLa102857;
	Mon, 19 Mar 2007 07:21:36 -0600
In-Reply-To: <7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42616>

On Monday, March 19, 2007 at 03:53:47 (-0700) Junio C Hamano writes:
>...
>* Hooks
>
>  - The sample update hook to show how to send out notification
>    e-mail was updated to show only new commits that appeared in
>    the repository.  Earlier, it showed new commits that appeared
>    on the branch.

I did not see Shawn's changes to the update hooks in here, and can't
recall where these stand at the moment --- will these be forthcoming?


Bill
