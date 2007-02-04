From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git config' vs 'git repo-config'
Date: Sun, 04 Feb 2007 02:09:10 -0800
Message-ID: <7v4pq2tet5.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
	<7v8xfetft6.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702040200y4f09070fia3716ca949fddac7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDeJD-00056r-OW
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbXBDKJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbXBDKJM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:09:12 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:33671 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752235AbXBDKJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:09:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204100911.BHV1343.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 05:09:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KN9A1W0031kojtg0000000; Sun, 04 Feb 2007 05:09:10 -0500
In-Reply-To: <e5bfff550702040200y4f09070fia3716ca949fddac7@mail.gmail.com>
	(Marco Costalba's message of "Sun, 4 Feb 2007 11:00:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38678>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 2/4/07, Junio C Hamano <junkio@cox.net> wrote:
>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>
>> > Probably you already now why I'm asking this ;-)
>>
>> No.  But we should certainly draw up deprecation/removal
>> schedule.  It simply could be "never" ;-).
>
> qgit needs to handle the text codec information 'i18n.commitencoding'

I thought you already fixed the header parser.  Is that a news?

I wonder what it has to do with the command deprecation/removal
schedule...
