From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 10:46:57 -0700
Message-ID: <7vtzvgtdny.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
	<20070416055111.GC23255@mellanox.co.il>
	<7vodlox3fx.fsf@assigned-by-dhcp.cox.net>
	<20070416061813.GD23255@mellanox.co.il>
	<20070416065119.GF23255@mellanox.co.il>
	<7v647wx0q3.fsf@assigned-by-dhcp.cox.net>
	<20070416071127.GM2229@spearce.org>
	<81b0412b0704160556j6596ab03v2405eadcefe34bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdVIV-0005VS-B2
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 19:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXDPRrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 13:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbXDPRrB
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 13:47:01 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39234 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbXDPRq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 13:46:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416174658.BKIH1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 13:46:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ntmy1W00A1kojtg0000000; Mon, 16 Apr 2007 13:46:58 -0400
In-Reply-To: <81b0412b0704160556j6596ab03v2405eadcefe34bd8@mail.gmail.com>
	(Alex Riesen's message of "Mon, 16 Apr 2007 14:56:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44681>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 4/16/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > I am not quite convinced that giving a short summary is
>> > necessary yet, probably for the same reason you questioned why
>> > we do --shortstat.
>>
>> Of course I'm one of those "gah, I got more shells than I know what
>> I'm doing with!" people.  ;-)
>>
>
> Me too. Please, can we have it? :)

Will be in.  And --shortstat is not going away.
