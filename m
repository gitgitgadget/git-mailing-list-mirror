From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote: allow 'git-remote fetch' as a synonym for 'git fetch'
Date: Sat, 30 Jun 2007 10:19:32 -0700
Message-ID: <7vps3de4wr.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
	<1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gbn-0005lz-5g
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbXF3RTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbXF3RTf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:19:35 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38771 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213AbXF3RTe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:19:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630171932.XHKK17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:19:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtKY1X00J1kojtg0000000; Sat, 30 Jun 2007 13:19:33 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51226>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> From: Sam Vilain <sam@vilain.net>
>
> I found myself typing this when doing remote-like things.  Perhaps
> other people will find this useful

I would like to reject this, for the same reason I did not apply
three patch series "Human friendly git" on April 1st this year
;-).
