From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 11:25:10 +0200
Organization: At home
Message-ID: <e378fs$lpc$1@sea.gmane.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net> <e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se> <7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 02 11:24:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Far7i-0006ma-O8
	for gcvg-git@gmane.org; Tue, 02 May 2006 11:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWEBJYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 05:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWEBJYj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 05:24:39 -0400
Received: from main.gmane.org ([80.91.229.2]:13703 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932185AbWEBJYi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 05:24:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Far7O-0006j4-Nu
	for git@vger.kernel.org; Tue, 02 May 2006 11:24:30 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 11:24:30 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 May 2006 11:24:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19412>

Junio C Hamano wrote:

> Andreas Ericsson <ae@op5.se> writes:
> 
>> "git grip" work just fine for me, since it's only intended for testing
>> and performance improvements so far. I also think it's clearer for
>> end-users looking for a grep command if they're not faced with
>> fgrep/egrep/ggrep/bgrep alongside plain "grep".
> 
> I renamed "git grip" to "git grep" and "git diffn" to "git diff"
> both in "next" branch to avoid confusion.  Thanks Andreas,
> Jakub, and others for input.

So, is there a way to use old, script version of those commands?

-- 
Jakub Narebski
Warsaw, Poland
