From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Fri, 21 Mar 2008 09:51:26 -0400
Message-ID: <46a038f90803210651offecf20h9ea527b610c8769f@mail.gmail.com>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
	 <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "alturin marlinon" <alturin@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:52:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JchfF-0003Ma-9p
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 14:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbYCUNv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 09:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbYCUNv3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 09:51:29 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:29136 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbYCUNv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 09:51:28 -0400
Received: by py-out-1112.google.com with SMTP id u52so2003563pyb.10
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uAGIQHQTBjId4JZhltibnQUFeQug1/i1TjvhtTTEJ0E=;
        b=l21t/u7EJE2O+lL++yti5fWP1iBmUF9kXr6VOiZ4RkucBDvoy9OFlhy0Xnvb7UX395Va8gjPaGhwSFoPSKEs8VoTs54tOKL8IYkHjsUkk+P5q+0na12ubT2Vi56kctxTvUI8OsYhdcIc8a8cGsuGsYrH4B4Huvv340hVjVVXDZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+3vXVwfBSSMLr4c5d8WKPvr+kEEEQoTJ8ItEPzNs5UoNX1/QNIFhHaWhVGBmhNEgwuLkqGXmEBSnEV5RM/g6EJgMerov0HQLA/AyDDGR9YR2VidBRc6GNuxK/VqBRy8W8BXx7GmDa3eOGJnNHl2fj2dV4tVVtoZn9ZdMKBBvaQ=
Received: by 10.35.79.3 with SMTP id g3mr2588192pyl.53.1206107487530;
        Fri, 21 Mar 2008 06:51:27 -0700 (PDT)
Received: by 10.66.252.6 with HTTP; Fri, 21 Mar 2008 06:51:26 -0700 (PDT)
In-Reply-To: <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77739>

On Fri, Mar 21, 2008 at 5:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Which part of the codebase had the most commits that had "oops, screwed
>   up, I am fixing this but this is a tricky code" fixes?

How the hell do we spot that one? ;-)


martin
-- 
 martin.langhoff@gmai.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
