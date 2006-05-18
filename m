From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: cvsimport weird
Date: Thu, 18 May 2006 11:33:23 +0200
Message-ID: <4fb292fa0605180233n3d3448ddl557fa6c10a90c80e@mail.gmail.com>
References: <4fb292fa0605171800n4f041dd2l8af06d82bdbe6bff@mail.gmail.com>
	 <46a038f90605171954n7e75ee64t412b22e8d405d909@mail.gmail.com>
	 <1147924771.32050.40.camel@dv> <1147931094.32050.51.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 18 11:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgesp-0001q5-H6
	for gcvg-git@gmane.org; Thu, 18 May 2006 11:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWERJdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 05:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWERJdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 05:33:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36952 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750933AbWERJdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 05:33:24 -0400
Received: by nf-out-0910.google.com with SMTP id o63so84544nfa
        for <git@vger.kernel.org>; Thu, 18 May 2006 02:33:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kkyq0bVeQXsvucVKyW+F9f7sI1+BYb8j8RIX4BNO+D/K3bEHcR6qOqKVwlFHGU3wvgfk6gb3UnKT9EJS3WmT++tS0el9NpjTDFWA9/E0Ava6sZHkrwpXA2kdvBNudYKYkdfulIFiCX0oLYnCgob+hdA9gbJ+2KZrjv2DpsX81ts=
Received: by 10.48.233.19 with SMTP id f19mr363799nfh;
        Thu, 18 May 2006 02:33:23 -0700 (PDT)
Received: by 10.49.5.5 with HTTP; Thu, 18 May 2006 02:33:23 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1147931094.32050.51.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20277>

On 5/18/06, Pavel Roskin <proski@gnu.org> wrote:
> On Wed, 2006-05-17 at 23:59 -0400, Pavel Roskin wrote:
> > I'm quite sure that it's a bug in cvsps.  It displays such things on
> > x86_64, but works properly on 32-bit PowerPC.
>
> Address resolution is broken in cvsps on 64-bit machines.  This patch to
> cvsps is needed:

Ah Thanks, I'm running it on a x86_64.

-- 
Beber
#e.fr@freenode
