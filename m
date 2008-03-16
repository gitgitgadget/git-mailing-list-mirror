From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Editing patch sequences
Date: Sun, 16 Mar 2008 12:02:55 +0100
Message-ID: <87r6eb0w4g.fsf@mid.deneb.enyo.de>
References: <877igcw8gn.fsf@mid.deneb.enyo.de>
	<m3myp8fdae.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 12:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaqep-0007q3-VE
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 12:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYCPLDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 07:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYCPLDA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 07:03:00 -0400
Received: from mail.enyo.de ([212.9.189.167]:59948 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbYCPLDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 07:03:00 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Jaqdl-00060I-Ps; Sun, 16 Mar 2008 12:02:57 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Jaqdj-0003ME-Ba; Sun, 16 Mar 2008 12:02:55 +0100
In-Reply-To: <m3myp8fdae.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 09 Mar 2008 01:37:54 -0800 (PST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77361>

* Jakub Narebski:

>> Has this already been implemented? "git rebase --interactive" comes
>> close, I think.  But minimizing the changes to individual patches seems
>> a bit of work.
>
> You can try to use one of two Git patch management interfaces: 
> StGit or Guilt.

I had missed that StGit has got three-way merge support.  Fortunately,
the need to manage patch sequences has gone away for the time being
(someone else did it for me 8-).  But I'll report back when the need
finally arises.  Thanks.
