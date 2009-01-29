From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: diff settings
Date: Thu, 29 Jan 2009 11:26:21 -0500
Message-ID: <4981D8AD.6000000@tedpavlic.com>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu> <497D1AB7.7000208@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Thu Jan 29 17:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZkE-0000HI-NJ
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 17:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758697AbZA2Q02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 11:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbZA2Q02
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 11:26:28 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:44067 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758697AbZA2Q01 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 11:26:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id CD24880D8020;
	Thu, 29 Jan 2009 11:20:16 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENyxc-m2VUxi; Thu, 29 Jan 2009 11:20:16 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B323F80D8015;
	Thu, 29 Jan 2009 11:20:16 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <497D1AB7.7000208@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107701>

> This task is pretty easy in Mercurial because Mercurial porcelains are
> implemented as modules that are all executed through the central "hg"
> command. This isn't the case with git.

(on the other hand, having a "[defaults]" section that only applies when 
commands are called via "git" might be nice. That way you can use the 
"git-CMD" when you want to use CMD without the "[defaults]"... perhaps?)

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
