From: Chris Packham <judge.packham@gmail.com>
Subject: Re: OT: This forum
Date: Mon, 11 Oct 2010 17:11:14 -0700
Message-ID: <4CB3A7A2.1040307@gmail.com>
References: <loom.20101012T012512-764@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Tue Oct 12 02:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5SSG-0004bB-BU
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 02:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab0JLAKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 20:10:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51087 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab0JLAKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 20:10:50 -0400
Received: by pvc7 with SMTP id 7so4995pvc.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=HosR8GbAsqiSP9TGcVIC4NeKgdlzj8YG+L7Xb1Kgus0=;
        b=JFbjb/gXGdnzTbRnxO3AezYX7J7G7qmaVvUKJQtPJPZY3y4mewz47G0+i7lmWQuzMV
         4dtKcdi3RkCpdmESwrVNxmjoN1l9H2CaoAm8JZJL1ZBDHD769K3V46l+9ll7Mtbr91xr
         Nt7nS7TVDvzW+dfOY5NVICMJndIEGFKGNjga4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YDRYJlic2hcXMQvq2flM4KbWxTPQCs9iZUVKGitKax+4TVK0ReLeBGvmJL2zGXGquo
         Ufb6ptPkVr70KiQNSzz7Dg+HzX6Lo897h0Y9haTVzylyD+iQHDijSb/7C3GBxo27iCne
         F7/5+DbBx8jjWBMIgGyAeDbk88DgPrJ9de4e8=
Received: by 10.142.194.19 with SMTP id r19mr5695166wff.351.1286842249628;
        Mon, 11 Oct 2010 17:10:49 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id p6sm9502508wal.7.2010.10.11.17.10.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 17:10:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <loom.20101012T012512-764@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158815>

On 11/10/10 16:35, Maaartin wrote:
> I read this forum using
> http://post.gmane.org/post.php?group=gmane.comp.version-control.git
> and it sort of works. Except that finding own old posting is quite impossible, 
> even when I try searching for the subject, and/or author, and/or pieces of text 
> in any combination. It finds some posting, but it misses others, whatever I do. 
> Except that I don't know how to attach a file. Except that I'd expect to see a 
> thread containing a new reply somewhere on the first page instead of on the 
> 14th. Except that replies to emails I get (answers to my threads) goes to their 
> author instead of to the forum.
> 
> Is there a better way for using this forum/mailing list? However, I'd like to 
> avoid getting daily dozens of emails.

Luckily for you, you don not have to be subscribed to send email to
git@vger.kernel.org, that's the preferred method. By convention on this
list replies are sent to the originator _and_ the mailing list (and
quite often a few people that may provide a better answer to the
questions being asked).

As for searching I sometimes find using google's
site:http://news.gmane.org/gmane.comp.version-control.git yields better
results than the gmane's own search (also I'm familiar with how to tell
google to ignore a particular word which can help weed out unwanted
results).
