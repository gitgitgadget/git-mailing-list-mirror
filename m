From: Herman van Rink <rink@initfour.nl>
Subject: Re: git subtree push-all and pull-all
Date: Thu, 25 Jul 2013 12:00:08 +0200
Organization: Initfour Websolutions
Message-ID: <51F0F728.6090709@initfour.nl>
References: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com> <20130707125430.GA23197@paksenarrion.iveqy.com> <CALemSr4Q_En+9eAbu2oRO-=EYt78sCB4nQjSO67W_m=nxu6KiQ@mail.gmail.com> <51DBD636.7070601@initfour.nl> <CALeLG_=x30qR1LFiKzz+NZu6vAf3GAL2tTCsbCz0Zm6J+udAcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gareth Collins <gareth.o.collins@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	git <git@vger.kernel.org>,
	Dieter Adriaenssens <dieter.adriaenssens@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Jul 25 12:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2ILT-0006m1-SH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 12:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab3GYKAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 06:00:24 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:52988 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab3GYKAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 06:00:22 -0400
Received: from [192.168.42.73] (initfour.xs4all.nl [80.101.157.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 01D2D9FC20F;
	Thu, 25 Jul 2013 12:00:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CALeLG_=x30qR1LFiKzz+NZu6vAf3GAL2tTCsbCz0Zm6J+udAcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231129>

On 22-07-13 21:35, Paul Campbell wrote:
> Hi,
>
> Sorry for the delay. Not been monitoring the list lately.
>
> I'm afraid work stopped for two reasons. Lack of interest from the
> list was the main one. I understand subtree isn't used much and
> subsequently there wasn't much interest in reviewing the patches I was
> putting out. As a result I lost interest.
>

It seems to be hard to get anything done on such a busy list. :( 
Especially when the maintainers lack time/attention for such a contrib.

I think including it in the contrib folder has not done us any good.

Maybe we should just focus on maintaining a separate repo, which could 
be based of https://github.com/apenwarr/git-subtree (which has already 
92 forks, including one of mine). And obviously integrate all the recent 
work from Paul.

-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
