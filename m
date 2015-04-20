From: Sam Vilain <sam@vilain.net>
Subject: Re: git-p4 Question
Date: Mon, 20 Apr 2015 11:23:56 -0700
Message-ID: <5535443C.1060600@vilain.net>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: FusionX86 <fusionx86@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 20:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGS5-0002zE-M8
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbbDTS3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:29:44 -0400
Received: from tx.vilain.net ([74.50.57.245]:49408 "EHLO tx.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbbDTS3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:29:44 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2015 14:29:43 EDT
Received: from [10.12.102.191] (unknown [38.104.194.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by tx.vilain.net (Postfix) with ESMTPSA id 5119A83B0;
	Mon, 20 Apr 2015 19:23:57 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267482>

On 04/20/2015 09:41 AM, FusionX86 wrote:
> Hopefully this is an appropriate place to ask questions about git-p4.
>
> I started at a company that wants to migrate from Perforce to Git. I'm
> new to Perforce and have been trying to learn just enough about it to
> get through this migration.

You might also like to check out my git-p4raw project which imports 
directly from the raw repository files into a git repo using git fast-import

     http://github.com/samv/git-p4raw

Apparently it's my most popular github project :-).  YMMV.

Sam.
