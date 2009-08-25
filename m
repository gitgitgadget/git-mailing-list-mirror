From: John Tapsell <johnflux@gmail.com>
Subject: git svn messages
Date: Tue, 25 Aug 2009 23:31:05 +0100
Message-ID: <43d8ce650908251531n397ba6e1xe71e80d7b8a08344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg4Xq-0006oz-Tb
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 00:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbZHYWbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbZHYWbF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 18:31:05 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:44123 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbZHYWbE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 18:31:04 -0400
Received: by ywh13 with SMTP id 13so4554874ywh.15
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=GiesxV6NHwg7XqesNZs1Wz8OS0GNPqF4nJLimfrSSm0=;
        b=fLjCcZUaFEfKVUu56XIAXc4a+gbWrKGTxAKx0SVVN8u6bE1eTBOnpb9a8lajjDk+Se
         8iY5Pgd4chwVtdXzfKLaJ58aF2Y5ccQJj3RO/80Av8ZmTUJ5/kmk9RaWddgrU+p4jSgw
         A45PIFn+ke2BkHe02jz8+/sDzM08tkAitDe9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=G/dfjZU+z3Uvh+XX061rBcvHKk9cKNtowx2P6UG6g8p9OQCutqwLuuoMeaymFlqqg8
         2/nz5pZ/xhrA3osbE7K+oozufajRk3pb5gl7tPyZbTa2if0TfUZrFEqAo2B3Y0x1wAyo
         gHZdLFPIQaH+oFPxN/qyCocEBMdJ1NjbXY2cw=
Received: by 10.150.65.5 with SMTP id n5mr11531265yba.190.1251239465302; Tue, 
	25 Aug 2009 15:31:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127052>

Hi all,

  When doing git svn dcommit, the messages that it gives are, well,
frightening :-)

It's full of things like:

> No changes between current HEAD and refs/remotes/git-svn

No changes?  What's gone wrong?  Why can't it find any changes?..

> Resetting to the latest refs/remotes/git-svn

That doesn't sound good.  Why did it have reset?  Were the errors to
great for it to continue, so it had to reset?

John
