From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Mon, 28 Apr 2008 23:33:39 +0200
Message-ID: <20080428213339.GC10600@steel.home>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:34:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqazW-0003Ft-9u
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935186AbYD1Vdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761451AbYD1Vdl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:33:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:24115 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935087AbYD1Vdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:33:41 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZBJxGkw==
Received: from tigra.home (Faada.f.strato-dslnet.de [195.4.170.218])
	by post.webmailer.de (klopstock mo64) (RZmta 16.27)
	with ESMTP id t07207k3SISrK2 ; Mon, 28 Apr 2008 23:33:39 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0414B277BD;
	Mon, 28 Apr 2008 23:33:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3535156D28; Mon, 28 Apr 2008 23:33:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48161544.90500@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80623>

Paolo Bonzini, Mon, Apr 28, 2008 20:19:48 +0200:
>> my v4l2
>> repo (which is a pretty collection of all kinds of remotes)
>
> I can add a global boolean configuration to change the default value of  
> skipDefaultRemote.
>

With the default NOT so that current behaviour stays?
And "git remote add" update?
