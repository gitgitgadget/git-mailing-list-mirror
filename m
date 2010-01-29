From: Frank Li <lznuaa@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Fri, 29 Jan 2010 23:04:21 +0800
Message-ID: <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Fri Jan 29 16:04:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NasOa-0002po-BL
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab0A2PEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755985Ab0A2PEW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:04:22 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:33542 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab0A2PEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:04:21 -0500
Received: by yxe31 with SMTP id 31so1873561yxe.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AMbxbrV+kNQ7fzudt+jUk6YYftZBYl8W5ftsOESlkTU=;
        b=fkjPxAHngKm1keYX5wLIj9s9lzuM7d80SF10IrQOw17EfViemLne4GV2snwncEiXYF
         yuuqodZQMY3UgpQrvgWSGyrpl+puu/f//SCqRt1ooTOfeeo/3TTRwiXJ2Fkq6NrxKkCi
         K+2wKW/jX3oU/6T8micbAyp6sVf3nhagDkRe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LgrxzuYxp0YYSGSJp9tIk0On+2do5LS0hxmboldLvgfbj2AAWbz2clfnSn1kfMzJIt
         IqfO9oT1N+eXs+29uAQgH2ROHx1hhqVkXc2hhax1bX1Hdj+VxpawgnVh00eQ0JzHQznt
         I87lTLC3OmhC/NJw3Su3XV6INvlsIEK7hWkaY=
Received: by 10.150.48.12 with SMTP id v12mr1722934ybv.213.1264777461185; Fri, 
	29 Jan 2010 07:04:21 -0800 (PST)
In-Reply-To: <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138321>

>
> If I use --username option, Frank Li said me it's not enough in
> TortoiseGIT to provide a popup facility to type the password related
> to the set --username option.
>

I prefer git-svn can provide environment to launch a external
application to input password like open ssh.
