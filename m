From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Remove some junk characters from COPYING
Date: Sat, 16 Jan 2010 09:30:42 +0530
Message-ID: <f3271551001152000r6facd476we7f0a1d3ed5cdf87@mail.gmail.com>
References: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com> 
	<201001160209.22589.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 05:01:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVzqY-0004hU-PQ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 05:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab0APEBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 23:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945Ab0APEBF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 23:01:05 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58215 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0APEBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 23:01:04 -0500
Received: by yxe17 with SMTP id 17so1430115yxe.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 20:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=OQi2bN84QiQTRjsqqEcVAhbh6iibv5DbcuiJdr8X3Dk=;
        b=bTjDalpljXciaVhcZ/a5OQdHXd6x7adnftkgqVX2aYe/yI1AbZ+KYqlp+Yx6P3xRiz
         e2HTtJFfab+IO7ARNJo46uGAtkAVL4yI+ZOPL17D1BDWtxzZizdrUcPSTLO/4XaAGJom
         EYl6jAxkfzKOG9L5MZCCRFdOBTdugCcmc4rcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HgGIW2YhPsCKnYp+2K7ldv+akbpYp9/j+pugy2BV66wIKKvtdmT6Ru0YLg8CEfJvJv
         5MAOc08l1bHAHdgGh0M/kwGLU9l3fOA3OkvpGHZa/qxaVxjuVJG3YfAqZBVKnvybuFPH
         Gt/a9ULQz24FA/eeFyND1zYhQdWSYRcrTplkc=
Received: by 10.90.15.14 with SMTP id 14mr57842ago.2.1263614463341; Fri, 15 
	Jan 2010 20:01:03 -0800 (PST)
In-Reply-To: <201001160209.22589.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137196>

Hi,

> It is a form-feed (force new page when printing) so it should probably be
> called by that name, if it were to be removed.

Oh, thanks for that- I just looked it up. I don't know if they should
be removed at all.
