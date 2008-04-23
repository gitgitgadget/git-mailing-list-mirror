From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: git-gui hangs on read
Date: Wed, 23 Apr 2008 16:49:18 +0200
Message-ID: <480F4C6E.9070400@isy.liu.se>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>	 <20080422001311.GS29771@spearce.org>	 <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com>	 <20080422232530.GK29771@spearce.org> <480EF84A.4020308@isy.liu.se> <b3889dff0804230716n1b5dde1ctb7b0c1dd83f2d1ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Benjamin Collins <ben.collins@acm.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 16:50:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JogIT-0001qX-Do
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 16:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYDWOtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYDWOtV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 10:49:21 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:45359 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYDWOtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 10:49:21 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 99F13259AC;
	Wed, 23 Apr 2008 16:49:19 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 13288-01; Wed, 23 Apr 2008 16:49:18 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id DADF12594F;
	Wed, 23 Apr 2008 16:49:18 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <b3889dff0804230716n1b5dde1ctb7b0c1dd83f2d1ff@mail.gmail.com>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80222>

On 04/23/2008 04:16 PM, Benjamin Collins wrote:
> What I have done for now is to comment out the line in gui-gui that
> does the lappend on spell_cmd, near the end.

Thanks!

/Gustaf
