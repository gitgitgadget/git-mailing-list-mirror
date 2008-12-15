From: "Geoffrey Lee" <geoffreyj.lee@gmail.com>
Subject: Re: TortoiseGit
Date: Sun, 14 Dec 2008 19:48:14 -0800
Message-ID: <83d7aaa40812141948m1ce1584bxe29374bf24a7946f@mail.gmail.com>
References: <8836F27A-CEE2-4D72-B2D1-7A3D19975D4F@alcidesfonseca.com>
	 <1976ea660812140147o40e014cbn46d920781db029a1@mail.gmail.com>
	 <937EE54D-1FC0-4FFA-B273-C98C7CF321D4@alcidesfonseca.com>
	 <c115fd3c0812140900k69b07101k7ce16002727c8268@mail.gmail.com>
	 <1976ea660812141712w196540caue9525ddbae8192f3@mail.gmail.com>
	 <83d7aaa40812141803x4cdc1151y8ef82b9e19eceb80@mail.gmail.com>
	 <7vhc56yume.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Li Frank" <lznuaa@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 04:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC4Sk-000498-6g
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 04:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbYLODsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 22:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYLODsQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 22:48:16 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:35864 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYLODsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 22:48:15 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1040372ywe.1
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 19:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ne4u+ei2ofBqYljJ4+IA9Mj36nAoDK0ojp41mSl8dWg=;
        b=dueufkT33ij2HL7PR9R+E4hCOFPtrqsxzAq5O6pb9rWeL/6/vXPa49N1TiE8DKaR2j
         Yk4IVmIJPmyOghpft17zChY8Zm9s20hPE4QNp6oQOoHb9vHC/UfldA1StZE4L5Yf6N7H
         0Nt0PBEqaiEvJ6kM7MpSzApWDkijyW/PLH32U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=knA4ivuZ20UrJvcmdYFkd0CoffFRBsTR949iZj6WnFFthz/XOnx1FjYHnbOYybNY4g
         FR/UMCDIDILyxR5zMDm3HRBOmEbMpxHZYCpRWMyJ/Gcic2HXH8sYUXRjWRdYkzZbbiGn
         NV70zFn0fsW3xN6klzo/5oBJccKOOE0ERA6yg=
Received: by 10.151.8.8 with SMTP id l8mr5845200ybi.14.1229312894156;
        Sun, 14 Dec 2008 19:48:14 -0800 (PST)
Received: by 10.151.122.12 with HTTP; Sun, 14 Dec 2008 19:48:14 -0800 (PST)
In-Reply-To: <7vhc56yume.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103129>

On Sun, Dec 14, 2008 at 7:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> That cuts both ways.  Most development around git happen on this list and
> taking a project's development discussion away from here will hide it from
> the mainstream development.  People involved in TortoiseGit may decide
> that asking for some change in the core is a good idea on their own Wiki,
> and after spending significant amount of effort come back to this list
> with a request for change, which may turn out to be suboptimal (or worse,
> impossible) solution, and you can avoid such wasted effort by keeping the
> discussion on list here.

We ended up creating:
http://groups.google.com/group/tortoisegit-users
http://groups.google.com/group/tortoisegit-dev
http://groups.google.com/group/tortoisegit-announce

Although I believe Frank wanted to keep discussion on here for now
until our growth warrants a separate list.

-Geoffrey Lee
