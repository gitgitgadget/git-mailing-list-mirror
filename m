From: Sam Vilain <sam@vilain.net>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 12:23:43 +1200
Message-ID: <46F06C0F.3040609@vilain.net>
References: <20070917193027.GA24282@old.davidb.org>	 <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org> <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnKN-0005kV-Iu
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbXISAVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXISAVv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:21:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46586 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbXISAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:21:50 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id B16BF21CFB9; Wed, 19 Sep 2007 12:21:49 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 2849321CFB6;
	Wed, 19 Sep 2007 12:21:46 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58666>

Reece Dunn wrote:
> There is no need to create yet another Perforce importing tool, git-p4
> works well in most cases. If we focus on improving git-p4, extending
> it to support the functionality mentioned here, fix the issues that
> there are with it, then that will be more beneficial to the community
> as they will not have to learn another tool with a different set of
> bugs and issues.

I like my approach; it's clean and I think shows a tasteful level of
distrust towards the sanity and integrity of the data held by Perforce.
 Actually it really helped me understand what was really going on;
because the information as displayed by for instance "p4 integrate" is
a lot more confusing than the underlying tables (IMHO).

Sam.
