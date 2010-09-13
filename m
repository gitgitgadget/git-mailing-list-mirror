From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Mailing list headers: Date:<TAB> instead of Date:<SPACE>
Date: Mon, 13 Sep 2010 11:58:13 -0700
Message-ID: <4C8E7445.6070604@gmail.com>
References: <20100913150245.GT22527@danbala.tuwien.ac.at> <AANLkTinEb9geKox+a+HosQn-g4eKd-DW4agRCf8yqv=k@mail.gmail.com> <sfid-H20100913-202503-+038.68-1@spamfilter.osbf.lua> <4C8E6C7B.2090904@gmail.com> <20100913183054.GE7006@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Klausner <tk@giga.or.at>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEEG-0004Bj-FZ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0IMS6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:58:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45810 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab0IMS6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:58:03 -0400
Received: by pvg2 with SMTP id 2so2253781pvg.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=okK/IHW7jeQ3WNoN/ylwWOBmxr/nDXmJXf5Xm+OUiBM=;
        b=Zedgk1nLEEguI+/yXiNjtxyYX8EqtF6Zh+d0gC1HRwA5YaHY06+/n+TV2rSQBHkgB9
         eNdVRC9gG1ch2HfobdR+uOrIlVrmzcRicPpM3oY9Md7B7Vzc+huvmHiGWWpcOJHtp2sM
         Q69MN8AHxYJJuo63RSyNJxDEpxHiumUmNTdCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rLUrLulF8iBcNLTpssHkTwfhGzWYW7M6rrntJ/AkK9V0FESJTf6HLIEm7Wfz23XSfW
         EpugcB7WcLmWdgflvC/JVUrpFs13Xun9gVJUskI8SZYXXC4vn/myjUcZWQVotbVZWasl
         YgYMDAvM2ayT0cLpFPi1Yl8/UGXOWfALtPHlg=
Received: by 10.114.127.3 with SMTP id z3mr164694wac.83.1284404282464;
        Mon, 13 Sep 2010 11:58:02 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm12559456wam.4.2010.09.13.11.58.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 11:58:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <20100913183054.GE7006@danbala.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156114>

On 13/09/10 11:30, Thomas Klausner wrote:
> On Mon, Sep 13, 2010 at 11:24:59AM -0700, Chris Packham wrote:
>> There is also a problem with your definition of "uncommon". I haven't
>> checked but I'm guessing the tabs are there for every mailing list run
>> by vger.kernel.org. Those are some of the highest volume mailing lists
>> that I know of. It can't be to hard to change tin to parse a tab or
>> space character.
> 
> I'm sorry if you don't like my choice of words. I have subscribed to a
> number of mailing lists and read them in tin without stumbling over
> this problem.

And I'm sorry if that came of a little terse. Honestly since the advent
of web based mail/news viewers I've never really bothered with using one
so I'm fairly ignorant.

> Is my request so much to ask?
>  Thomas

My point was you're not asking the maintainer of the git mailing list to
change something. You're asking the maintainers of all mailing lists run
from vger.kernel.org to change something (i.e. a much greater scale).
Again my ignorance as to how things are run at kernel.org may be
distorting reality.

You may get more mileage out of asking the developers of the majordomo
software [1]. But even if they do make a change it may take a while to
be deployed on kernel.org

[1] http://www.greatcircle.com/majordomo/
