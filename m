From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: Commit messages
Date: Wed, 14 Jan 2009 11:55:39 -0500
Message-ID: <496E190B.7020104@tedpavlic.com>
References: <496CBD17.3000207@tedpavlic.com> <20090113164518.GS10179@spearce.org> <200901131403.16012.bss@iguanasuicide.net> <20090113201024.GA20129@chistera.yi.org> <8763kjt0mw.fsf_-_@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN93E-0003E6-0w
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762288AbZANQzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761596AbZANQzm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:55:42 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:42805 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760793AbZANQzm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 11:55:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 6E45E80D808B;
	Wed, 14 Jan 2009 11:49:56 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Bb36lV32Q9N; Wed, 14 Jan 2009 11:49:56 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 59C0E80D806E;
	Wed, 14 Jan 2009 11:49:56 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <8763kjt0mw.fsf_-_@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105658>

That rule could be modified to support .stgit-edit.txt as well.

> (add-to-list 'auto-mode-alist
>               '("/\\.git/\\(COMMIT\\|TAG\\)_EDITMSG\\'" .
>                 vcs-message-mode))

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
