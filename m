From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Better icon for qgit
Date: Sat, 24 Feb 2007 07:47:43 +0100
Message-ID: <e5bfff550702232247k447cf33asc47db99165eb7e4d@mail.gmail.com>
References: <1172279202.19767.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Bernhard Walle" <bwalle@suse.de>
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 07:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKqhH-00044H-PA
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 07:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933391AbXBXGrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 01:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933394AbXBXGrp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 01:47:45 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:16217 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391AbXBXGro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 01:47:44 -0500
Received: by wx-out-0506.google.com with SMTP id h31so710041wxd
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 22:47:44 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VgnCPyx5M670NWzOCMevTbZBRji8n9krsHBeIeRDLx1vjRd/nmPUJAFBMi1UkNWsPo/ZVEvPGF0I+gePbh8jKhIfUlheG2Ng4yv5t3olNqBjyYaip0KUBHqog3gzgs0xI/57A73AfnizCZnAablCqCM8SViIrXk9jWOS0Zc8IGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lU+xplDS/v2JtjeZKloRBpOYUp4VpI+fyYLxKWJfBXVjkNLwmPPmJ1bu/hsUqDiK97XHcDi+iQ0aDpO4fDO3FssJG0CVA3VHyZSJ4gkRTgRqY7YkH0pyVz1IjJDRZfABB8exOGYi+F0BEVFlnITx0vpXZkIFSu/TfKNRRwOg5rE=
Received: by 10.114.13.1 with SMTP id 1mr1409326wam.1172299663376;
        Fri, 23 Feb 2007 22:47:43 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 23 Feb 2007 22:47:43 -0800 (PST)
In-Reply-To: <1172279202.19767.12.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40504>

On 2/24/07, Pavel Roskin <proski@gnu.org> wrote:
> Hi, Marco!
>
> I see that qgit got its own icon, but I think it's confusing to reuse an
> icon used by another project.  I'm attaching what I think would be a
> better qgit icon.  I tried to use the same gamma but represent the
> unique qgit look.
>
> I understand that only one icon can be used, and it should better be a
> 16x16 icon to avoid scaling.
>
> I'm copying the git list in case somebody could improve the icon or
> suggest something better.
>

Hi Pavel,

  it's ok for me to use your icon, I don't know if a 16x16 it's
enough, there is the window title but also application tool bar and
ALT+TAB application chooser where icons are bigger.

In particular your icon does not show well in ALT+TAB app chooser,
while the Bernhard's one does.

I would like to post a new release very soon, now that git-1.5 is out,
to fix a bug due to a change of git-rev-list output format in case of
i18n encoding info in git 1.5 that makes log titles in main view list
completly disappear!! under some cases.

This bug triggers only with git-1.5 and above so I really need to push
a point release.

Thanks
Marco
