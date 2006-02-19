From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] git-rev-list --help anywhere
Date: Sun, 19 Feb 2006 11:40:14 -0800
Message-ID: <43F8C99E.7080703@gmail.com>
References: <20060219112627.18989.qmail@science.horizon.com> <20060219183930.GB10010@steel.home> <Pine.LNX.4.63.0602192023270.11855@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, linux@horizon.com,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 20:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAuPu-0006mF-7Y
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 20:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWBSTkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 14:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWBSTkT
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 14:40:19 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:24308 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750808AbWBSTkR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 14:40:17 -0500
Received: by pproxy.gmail.com with SMTP id z74so921930pyg
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 11:40:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sXN2EhKzqaEkWqwgHuDAjz5iBF6HDexRYODH7zaayPvP7AOApm/JyG3OtV7Q8YotG6ZiBhHEUCMA3IYyjipnv6kC7keklzmcFzLTVudvcnRtXyLcRBTVAMaYRz3n6nICzZAOsRV+l13uFpJMXa3dYSKelE5ICmOn4N89zOyXDyw=
Received: by 10.35.109.2 with SMTP id l2mr1063908pym;
        Sun, 19 Feb 2006 11:40:16 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.71.142])
        by mx.gmail.com with ESMTP id q36sm1003055pyg.2006.02.19.11.40.15;
        Sun, 19 Feb 2006 11:40:16 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602192023270.11855@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16447>

Johannes Schindelin wrote:
> Hi,
> 
> can someone please enlighten me why you need to see the usage, when you 
> cannot execute the command anyway?
> 
> Puzzled,
> Dscho

How about so that you can find the options needed to run the command in 
another window where it will work.
