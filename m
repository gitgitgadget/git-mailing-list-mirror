From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Sun, 27 Sep 2009 22:21:36 -0400
Message-ID: <2c6b72b30909271921y4b191f1fo42b1ffb5f08d3468@mail.gmail.com>
References: <892492.1652.qm@web27801.mail.ukl.yahoo.com> <200909272152.33224.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Struberg <struberg@yahoo.de>,
	MatthiasSohn <matthias.sohn@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 04:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms5sc-0000Fe-UG
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 04:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbZI1CVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 22:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZI1CVy
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 22:21:54 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:42746 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbZI1CVx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Sep 2009 22:21:53 -0400
Received: by iwn10 with SMTP id 10so2365691iwn.4
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 19:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Rvw3LrV6++EvbksRBwTNHGO479Fw7aQ3mvUeSd2qaYo=;
        b=AipSko4E4+6Ek8qZz0ho64Tm2k4dHwKKouHZWlJegcjLT/pj+X9zVc/MMiaGYQ10GV
         H/xj7RYhFn1KxpzRBYJcA4OYFKcldFsMbzSemgPwlsFlLmCbUYI7XXsnvGlSrHqi/6Dy
         Nje2BgmlRo2w1cp6MgDpUEqk6gWclwa0su3l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HrQbjaBVSTcgVaVrU7/W8KpQIZMZjPv90j7hOm+sM+o0EybWlRf67OndGj7d6Ogavi
         Wf/0NyUdSsZBcuFEKoQB5LTkOTJseWCNXPsmoQOZ8hiTst9U5sZJ8tZOonXGfVnXRbyB
         zXGnbRS23AROkZLdqePt+V2WRXQuGQP7KPqdU=
Received: by 10.231.6.87 with SMTP id 23mr5145182iby.19.1254104517332; Sun, 27 
	Sep 2009 19:21:57 -0700 (PDT)
In-Reply-To: <200909272152.33224.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129223>

On Sun, Sep 27, 2009 at 15:52, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> l=C3=B6rdag 26 september 2009 22:10:16 skrev Mark Struberg <struberg@=
yahoo.de>:
>> And there is a lot more which imho cannot be set for a project. So c=
hecking in the xml sounds like it is way more powerful isn't? And we wo=
uld have this
>
> For JGit, not really. Everything that is not project settings should =
be left as the default. The only reason is tool constraints. I'm not we=
ll versed
> enough to tell what neatbeans does here.

It is my impression that NetBeans has far better integration with
maven. In terms of code formatting NetBeans supports
exporting/importing project specific settings, but I have never
personally used that.

--=20
Jonas Fonseca
