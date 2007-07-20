From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull-fetch-param.txt
Date: Fri, 20 Jul 2007 11:01:13 -0700
Message-ID: <7v1wf3x8d2.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
	<452211C2.8020402@s5r6.in-berlin.de>
	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
	<45222B18.1090305@s5r6.in-berlin.de>
	<20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org>
	<7vvecps2rz.fsf@assigned-by-dhcp.cox.net>
	<20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org>
	<7vejjcpyb5.fsf@assigned-by-dhcp.cox.net>
	<20070713074824.9806.qmail@df2dc1a3890a6b.315fe32.mid.smarden.org>
	<20070720143214.23897.qmail@511f57d39b0a54.315fe32.mid.smarden.org>
	<7vbqe7xbvq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707201758330.26817@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBwn6-0006tN-Q8
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXGTSBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756865AbXGTSBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:01:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62337 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762159AbXGTSBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 14:01:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720180114.OWWM1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 20 Jul 2007 14:01:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ru1E1X0091kojtg0000000; Fri, 20 Jul 2007 14:01:14 -0400
In-Reply-To: <Pine.LNX.4.64.0707201758330.26817@reaper.quantumfyre.co.uk>
	(Julian Phillips's message of "Fri, 20 Jul 2007 18:09:07 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53105>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Fri, 20 Jul 2007, Junio C Hamano wrote:
> ...
>> Hmph. Where does that leave us poor users who would want to
>> support both 1.71 and 1.72, I wonder...
>>
>> Will they have the same revert in 1.73 for that House Sign, too?
>
> It looks like they do, so perhaps we could just say that you will have
> issues building the git docs with 1.72 and ignore my last patch?

That actually sounds a very tempting thing to do, especially
considering we are past -rc2.
