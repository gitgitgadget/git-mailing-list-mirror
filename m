From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Dec 2006 11:11:56 +0000
Message-ID: <200612221111.58071.andyparkins@gmail.com>
References: <7vzm9g2rv5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 22 12:12:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxiJu-0004Pb-5D
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 12:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946039AbWLVLMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 06:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946040AbWLVLMF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 06:12:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:61678 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946039AbWLVLME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 06:12:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2945196uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 03:12:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=leBKzzjLx6AZ0qMYqEJXaAM58PdeIlQZuNckvZ/uGYbFw69dDn36xl7JRV9Bv63otNkSw21m9AO1MHUsUVoG/jrd3F9PVcIgCUcCZBCGE3U3hm9YR/PsCpbE6zNvDp8jm7BTvCKYLH6G4qlOex909cUwpB9X+qcqZw6IyEo/OwA=
Received: by 10.66.255.7 with SMTP id c7mr13495171ugi.1166785922158;
        Fri, 22 Dec 2006 03:12:02 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id j34sm13036342ugc.2006.12.22.03.12.00;
        Fri, 22 Dec 2006 03:12:01 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vzm9g2rv5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35161>

On Friday 2006 December 22 09:37, Junio C Hamano wrote:

> * jc/git-add--interactive (Mon Dec 11 17:09:26 2006 -0800) 2 commits
>  + git-add --interactive: hunk splitting
>  + git-add --interactive

I used this to disentangle a load of changes that I made under pressure and 
turned them into lovely isolated commits.  I didn't have any trouble with it, 
and thought it was incredibly useful.

I'd vote for putting it in 1.5 - it's in keeping with the usability theme - 
people love interactive stuff.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
