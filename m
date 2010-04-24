From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 12:05:36 +0200
Message-ID: <m2vdbhxj0v.fsf@igel.home>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<m3633hdw9u.fsf_-_@localhost.localdomain>
	<87fx2li36m.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 24 12:05:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5cFK-0004SX-FP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 12:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab0DXKFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 06:05:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52148 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0DXKFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 06:05:40 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id AA0241C15693;
	Sat, 24 Apr 2010 12:05:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 8C63F90E66;
	Sat, 24 Apr 2010 12:05:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id oDuflOBAJTfd; Sat, 24 Apr 2010 12:05:36 +0200 (CEST)
Received: from igel.home (ppp-88-217-124-203.dynamic.mnet-online.de [88.217.124.203])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 24 Apr 2010 12:05:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5A509CA297; Sat, 24 Apr 2010 12:05:36 +0200 (CEST)
X-Yow: I put aside my copy of ``BOWLING WORLD'' and think
 about GUN CONTROL legislation..
In-Reply-To: <87fx2li36m.fsf@catnip.gol.com> (Miles Bader's message of "Sat,
	24 Apr 2010 18:56:49 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145664>

Miles Bader <miles@gnu.org> writes:

> I think it's sort of annoying that "git add" has such a dual meaning
> (instead of, for instance, having separate "add" and "stage" commands)

"git add -N" could be regarded as such a non-staging add command.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
