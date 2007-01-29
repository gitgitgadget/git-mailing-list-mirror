From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 22:02:13 +0100
Message-ID: <200701292202.14293.jnareb@gmail.com>
References: <20070127080126.GC9966@spearce.org> <epll4j$iil$1@sea.gmane.org> <20070129204740.GA30963@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 22:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBdci-0000yZ-B7
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 22:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbXA2VBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 29 Jan 2007 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbXA2VBE
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 16:01:04 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:62510 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbXA2VBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 16:01:03 -0500
Received: by an-out-0708.google.com with SMTP id b33so774166ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 13:01:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eE0+mR5nCEmFKQUjGbNbNQeNrtPtP+K8rXuYfThYdubOlO7/5uF4/LGT1+RPo6Ik0O90TLepYEB/aDxqZNmb+rWQztVi+kHRVwFTUg8QDbpaStaJIXGkneerDuRw3yYoTCz3xK9+EOKhqf04E7e+a2xQ/LlIjpGyo2Zh8MndNl4=
Received: by 10.49.34.17 with SMTP id m17mr9691120nfj.1170104459949;
        Mon, 29 Jan 2007 13:00:59 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id x26sm7664340ugc.2007.01.29.13.00.58;
        Mon, 29 Jan 2007 13:00:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070129204740.GA30963@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38098>

Shawn O. Pearce wrote:

> I'll like steal them (er, uhm, implement them) in git-gui in the next
> day or so. =A0The current blame UI was sort of a prototype. =A0Once I
> tossed the original filename and original line number into that
> thing it started to become pretty obvious its just too cluttered.
> But at that point I wanted pretty colors, and uh, it was late... :-)

You can borrow some of the ideas from gitweb new blame output=20
(git_blame2) by Luben and Junio, too...

--=20
Jakub Narebski
Poland
