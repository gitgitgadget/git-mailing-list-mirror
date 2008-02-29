From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Which freedesktop.org "design flaws" in git are still relevant?
Date: Fri, 29 Feb 2008 22:16:29 +0100
Message-ID: <200802292216.29788.jnareb@gmail.com>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com> <alpine.LFD.1.00.0802291551310.4911@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCbO-0005Mw-SY
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbYB2VQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbYB2VQd
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:16:33 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:45367 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYB2VQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:16:33 -0500
Received: by fk-out-0910.google.com with SMTP id z23so5706142fkz.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=O1bp6sNxZq0LH3g5U7n8dKH824RfGXdgfyLOVj94pjg=;
        b=SBqUZovLX6kDPXimJK71K3N/g15j7ibgQjtidyKYXag13FyA7WDPE+zWdfOrG4Df3dKua9lXuxXBGcw5xJDbXzJkcUtkszJ8+tCxUc4i+WR9z6NvThwGfm4WkEnbBaf31ryUiZglJvH08biKoizZyd70TudYaj/UANENVcG4xww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UGQD6Plp+TCaQGTH3J3wtXN636F2zuOEaWjTDv0+kIQd9Y/nZpcHTD3nFvojKKxfI4Nf9/iuYzD+3YLvQBwfglLs7wSsNt9ZF3VpDss+q3rDYobJpyWpnp2fT1pUnJFSJpUkihrQ3YktyOZLvXCLJtfDjbP9nPvXrUz72Th0hgQ=
Received: by 10.82.121.15 with SMTP id t15mr17046630buc.32.1204319791474;
        Fri, 29 Feb 2008 13:16:31 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.217.18])
        by mx.google.com with ESMTPS id k9sm204373nfh.29.2008.02.29.13.16.29
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 13:16:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0802291551310.4911@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75566>

On Fri, 29 Feb 2008, Nicolas Pitre wrote:
> On Fri, 29 Feb 2008, Elijah Newren wrote:
> 
>> The page http://www.freedesktop.org/wiki/Infrastructure/git/UIFlaws
>> contains a number of claimed UI flaws of git.  I suspect that a number
>> of them are out-of-date; it doesn't seem to jive with my recent
>> reading of the documentation.  Could anyone point out which are still
>> accurate with recent git, and which aren't?
> 
> It says:
> 
> 	Infrastructure/git/UIFlaws (last edited 2007-06-03 18:41:26 by 
> 	JakubNarebski) 
> 
> and despite being updated almost 9 months ago, the content feels even 
> older than that.
> 
> Jakub?

http://www.freedesktop.org/wiki/Infrastructure/git/UIFlaws?action=info

I have just fixed one error there, and didn't take time to correct
all the things.

P.S. I have replied in another message in this thread, discussion those
mentioned "flaws" one by one.
-- 
Jakub Narebski
Poland
