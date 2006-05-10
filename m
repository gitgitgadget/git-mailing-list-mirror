From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 10 May 2006 17:34:28 +1200
Message-ID: <46a038f90605092234u14d4cd2en73c9cbe698eea8b9@mail.gmail.com>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 07:34:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdhLE-0007pC-Iu
	for gcvg-git@gmane.org; Wed, 10 May 2006 07:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWEJFea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 01:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWEJFea
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 01:34:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:45879 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964821AbWEJFe3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 01:34:29 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1399678wra
        for <git@vger.kernel.org>; Tue, 09 May 2006 22:34:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJQotXruwNVFh/z1WGIjOSHihhwRibIz2HdNFLiABM6Ri834gmoTpgoaaahyxf4p/LftIQsyKwKoYwaE2lEhL/ovAa65ePNdc68Iboo0g1iVoLbsWeJKImMi4PVck0V7JUeEFN0z6GXpcFHATcTVTfQ6SiWL3ilTgbcjczVyi7U=
Received: by 10.54.116.11 with SMTP id o11mr497270wrc;
        Tue, 09 May 2006 22:34:28 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Tue, 9 May 2006 22:34:28 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19878>

On 5/10/06, Junio C Hamano <junkio@cox.net> wrote:
> * The 'next' branch, in addition, has these.
>
>   - cvsserver and cvsexportcommit updates (Martin Langhoff and Martyn Smith)
>
>     This is a new merge but not very new code.  Martin may want
>     to comment on how ready they are.

They have seen some limited use in-house -- we don't use Eclipse
in-house that much, but that has been the test target. I am currently
looking for a machine with good bandwidth to a backbone and cycles to
spare where we can run anon cvs access to Linus's kernel.git repo.

cheers,


martin
