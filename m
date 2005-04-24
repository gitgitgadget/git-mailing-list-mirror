From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: A very basic tutorial
Date: Sat, 23 Apr 2005 22:19:18 -0400
Message-ID: <426B0226.8020001@dwheeler.com>
References: <1114305552.3114.3.camel@kryten>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 24 04:12:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPWbe-00077o-QC
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVDXCRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 22:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVDXCRI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 22:17:08 -0400
Received: from cujo.runbox.com ([193.71.199.138]:43962 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262230AbVDXCRF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 22:17:05 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DPWgC-0003Vr-47; Sun, 24 Apr 2005 04:17:04 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DPWgB-0002Eg-FO; Sun, 24 Apr 2005 04:17:04 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: James Purser <purserj@ksit.dynalias.com>, git@vger.kernel.org
In-Reply-To: <1114305552.3114.3.camel@kryten>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

James Purser wrote:
> I've done a very basic tutorial for using git. If someone who knows more
> about git (pretty much everyone on this list I think) could have a look
> and point out any glaring errors that would be great.

You mention two layers, but the layers are about to get (pun?)
separate names: git (lower layer) and Cogito (upper layer, and
separable from the "real" git lower layer).  You should explain
the two names.

You concentrate on Cogito, which is almost certainly reasonable
for normal starting points, but that's not clear in your text.

Also: The Cogito user interface is about to undergo a
significant rename of the commands.  It won't be hard to update
your text for it, but you'll need to do so.

--- David A. Wheeler
