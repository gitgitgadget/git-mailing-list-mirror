From: Russ Brown <pickscrape@gmail.com>
Subject: Re: Mailing patch series'
Date: Sat, 15 Sep 2007 11:44:26 -0500
Message-ID: <46EC0BEA.6060608@gmail.com>
References: <46EB301B.8050602@gmail.com> <20070915023518.GX3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 18:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWal9-0008Ry-Dx
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 18:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbXIOQoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 12:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXIOQoj
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 12:44:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:52990 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbXIOQoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 12:44:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1024905wxd
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=xs3Z5gR//qMEaiprCrQ5DOH086WRTIjwPYT/kPwjHaM=;
        b=kfMXo8EyOal4jx2+xmM/8pGwR+joLkoWRNh24EwAz4UutYZrkkYqg6sm5uVHiGq998nyTeWpHokGBWW442W2pR9VaSgFOcHO+RtOdVDWN4/3nkMEE4/PXWHBYI8Qy9dJAwy2I8xAgXrFkeyH2S5zVLWpFZBQofzqeMBXhS0fpPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BaXv+RFmEfpx6AqVYosA5Ehv9zxhAfP/OPUC1yhZgWsisSr3fZFgXNPysUyqpLRH/b1LZzBg4fJftQ90AVlYB17NLb0+GQtyRwdxMo34OVxqnzFiRhmKEoP7vtZqa4tELm+qNXlrccxFnWDnvlXEMi8TUohLu27jOeUkYhPVyA8=
Received: by 10.90.96.7 with SMTP id t7mr1204701agb.1189874677652;
        Sat, 15 Sep 2007 09:44:37 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.170.122.29])
        by mx.google.com with ESMTPS id e27sm3114088elf.2007.09.15.09.44.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Sep 2007 09:44:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <20070915023518.GX3099@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58260>

Shawn O. Pearce wrote:
> Russ Brown <pickscrape@gmail.com> wrote:
>> I've noticed the method of mailing series' of patches on this mailing
>> list, and I'd like to know a little more about how it's done, as I'm
>> considering how well it might work for us as a workflow and review process.
>>
>> Particularly, where does the series of patches come from?
> 
> Usually from Git itself, as in each Git commit is turned into its
> own email message by `git format-patch` which can then be sent by
> `git send-email` or your favorite mail client.
> 
<snip>

Shawn, thank you very much for your extremely detailed and helpful
explanation. It's given me plenty of food for thought!

Thanks again!

-- 

Russ
