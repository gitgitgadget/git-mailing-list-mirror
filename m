From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 09:00:11 -0700
Message-ID: <9af502e50806280900m415eb354waee9edac91a70e8d@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	 <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
	 <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
	 <9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 18:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCcrp-0006zj-NF
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 18:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYF1QAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 12:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYF1QAO
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 12:00:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49148 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYF1QAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 12:00:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so458115fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kJXx0dXuDEtZWnKfDhX8TvNj3ob/LyrQQk4Gf/AS2Cc=;
        b=aJeaJb7XCxdmNyjveai88WsiwmrjbS7OEY9SYBvIuz3X8FQBqaBH8Fi6+htpphXcyL
         /ssSa55w854U1zsmmvWp9yBmhbMLdoolv/Ddpb9zosBRobQKIPez+yOa96NqhYwoIzJS
         yFlCuox2QfZ8Etbi63GLSa5TMFAeoaXn68wjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fTpOHAwAD142RSvcCpqMp/QSKB688lj94HDCm9OqLRCoFKCBBcDCOlXn0BCGL6gOBc
         DtniZ0gIHVy8578T6AkrHA4pySupegTGHqp6f6fe3tJzktP0wGziVtGJFLf0shsFmHaJ
         ksXm3NX9SlLQKilMuGaCXDQuRqVamtgPoC32I=
Received: by 10.86.33.10 with SMTP id g10mr1409827fgg.29.1214668811325;
        Sat, 28 Jun 2008 09:00:11 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Sat, 28 Jun 2008 09:00:11 -0700 (PDT)
In-Reply-To: <9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86725>

On Sat, Jun 28, 2008 at 7:34 AM, Stephen Sinclair <radarsat1@gmail.com> wrote:
> The answer is simple: you should not be making partial commits to a
> repo that has been cloned.  You should instead be working somewhere
> else and then pushing to it.  So this whole sentence is just a moot
> point itself.

Ah, now you've hit the crux.  Thank you for the "svn style" response
here.  I "should not" because git has a deficiency.  Absolutely no
other reason.

Thanks,
Bob
