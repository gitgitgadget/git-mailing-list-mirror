From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 13:22:40 -0600
Message-ID: <kzzjRvB2M5uliRiLEqrN04NicW1QU3nr34zZu0lEAhdLiv9YxvOrsw@cipher.nrlssc.navy.mil>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbkS-0002P0-Bg
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbZBITXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756933AbZBITXW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:23:22 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47840 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbZBITXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:23:21 -0500
Received: by mail.nrlssc.navy.mil id n19JMfn5007909; Mon, 9 Feb 2009 13:22:41 -0600
In-Reply-To: <49907F75.2050100@beonex.com>
X-OriginalArrivalTime: 09 Feb 2009 19:22:41.0105 (UTC) FILETIME=[C69F5C10:01C98AEB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109111>

Ben Bucksch wrote:
> On 09.02.2009 19:54, Brandon Casey wrote:
>> I will follow up with an example patch which has the control
>> characters in
>> it.

<snip>
> email bodies are never
> going to be character-to-character identical, because there are many
> demands on formatting (up to graphical smiles) and from many different
> languages (charsets, like seems to be the problem here) on it by users
> -,

I can understand that the display of the message would not be optimal, and
could be different from what the sender intended, but I expect that the
saved version would be identical to the original.

In the 'graphical smilie' example, you still save colon-close-parenthesis
in the file don't you? and not the little smiley face bitmap?

> I think your better route for success would be to use inline
> attachments and fix the software which can't deal with *that* properly,
> including display and quoting.

It's not the display part that causes a problem for me, it's the "saving" part.
The displayed gobledygook is fine.  The saved gobledygook is not.

Why doesn't Thunderbird just save out the raw message?

-brandon
