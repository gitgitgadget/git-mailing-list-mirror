From: David Kastrup <dak@gnu.org>
Subject: Re: Track /etc directory using Git
Date: Sat, 15 Sep 2007 18:57:02 +0200
Message-ID: <85642bc1ep.fsf@lola.goethe.zz>
References: <38b2ab8a0709130511q7a506c5cvb0f8785a1d7ed7ad@mail.gmail.com>
	<20070913122002.GO671@genesis.frugalware.org>
	<38b2ab8a0709140120k50f5b474oc8a841ea0a5fda50@mail.gmail.com>
	<20070915163209.GA18508@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 18:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWaxH-0004Zc-Nc
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 18:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXIOQ5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXIOQ5L
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 12:57:11 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:59196 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751786AbXIOQ5L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 12:57:11 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id A8EAC1F58B9;
	Sat, 15 Sep 2007 18:57:09 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 9655C114336;
	Sat, 15 Sep 2007 18:57:09 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-048-000.pools.arcor-ip.net [84.61.48.0])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 5E7AB35E74C;
	Sat, 15 Sep 2007 18:57:05 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1271B1C0024C; Sat, 15 Sep 2007 18:57:03 +0200 (CEST)
In-Reply-To: <20070915163209.GA18508@piper.oerlikon.madduck.net> (martin f. krafft's message of "Sat\, 15 Sep 2007 18\:32\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4280/Sat Sep 15 17:03:14 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58262>

martin f krafft <madduck@madduck.net> writes:

> also sprach Francis Moreau <francis.moro@gmail.com> [2007.09.14.1020 +0200]:
>> The funny thing is that this tool is based on git/cogito but the
>> scm used to manage it is darc.
>
> They switched to git after running their heads too many times
> against darcs walls.

Since they are not using git as a source code management system nor
darcs as a versioned file system, it is not particularly funny.

It's like being proud when the neighbor watchmaker borrows a hammer:
"ah, I always told him that a hammer is the ultimate device for
repairing a clock".

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
