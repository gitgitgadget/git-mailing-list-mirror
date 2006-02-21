From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: contrib/ area
Date: Mon, 20 Feb 2006 17:41:50 -0800 (PST)
Message-ID: <Pine.OSX.4.64.0602201737260.16179@piva.hawaga.org.uk>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 02:50:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBMfG-0000Th-Uz
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 02:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWBUBs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 20:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWBUBs6
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 20:48:58 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:41478 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1161269AbWBUBs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 20:48:57 -0500
Received: from piva.hawaga.org.uk (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k1L1fojn019337;
	Tue, 21 Feb 2006 01:42:00 GMT
Received: by piva.hawaga.org.uk (Postfix, from userid 501)
	id 5C058DA7C63; Mon, 20 Feb 2006 17:41:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by piva.hawaga.org.uk (Postfix) with ESMTP id 1A257DA7C5F;
	Mon, 20 Feb 2006 17:41:51 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16515>



> As some of you may be aware, I've added contrib/ area to git.git
> repository.  Currently there are git-svn from Eric and gitview
> from Aneesh.
>
> The intention is to keep interesting tools around git, maybe
> even experimental ones, to give users an easier access to them,
> and to give tools wider exposure, so that they can be improved
> faster.

I have been keeping some (lazily-maintained) bash completion code at:

http://www.hawaga.org.uk/ben/tech/gitcompletion/

It isn't clear to me whether it should stay there or be merged into 
git/contrib/.

Cogito has the cogito bits of the above already included.

Stg doesn't.

The path of least resistence for me is to keep it at the above 
hawaga.org.uk URL, but it may be that some people would prefer it in the 
main repos.

Ben

-- 
