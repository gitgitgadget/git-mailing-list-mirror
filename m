From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: provide easy way of adding new submodules
Date: Tue, 03 Jul 2007 22:10:33 -0700
Message-ID: <7vabucn48m.fsf@assigned-by-dhcp.cox.net>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
	<7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
	<20070624151750.GA997MdfPADPa@greensroom.kotnet.org>
	<7vir9dtf5z.fsf@assigned-by-dhcp.cox.net>
	<20070624210607.GC997MdfPADPa@greensroom.kotnet.org>
	<7vps3k33ze.fsf@assigned-by-dhcp.pobox.com>
	<20070703154732.GO7969MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 04 07:10:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x8Y-0001Ec-33
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbXGDFKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 01:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXGDFKg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:10:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61684 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbXGDFKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 01:10:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704051035.IHKH22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 01:10:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHAa1X0071kojtg0000000; Wed, 04 Jul 2007 01:10:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51561>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Mon, Jun 25, 2007 at 12:09:09AM -0700, Junio C Hamano wrote:
>> I am not sure about the usefulness of "-b branch" thing myself,
>> but other than that, looks very sane to me.
>
> So, do you want me to send it in again, without the branch thing?

It is already scheduled for 1.5.3 and is part of 'master'.
