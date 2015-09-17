From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: On a personal note
Date: Thu, 17 Sep 2015 20:29:10 +0700
Message-ID: <CACsJy8AcK8hAkMowA0t5SusJDTYZDWZCFN5JDs2f-puZcJAfhg@mail.gmail.com>
References: <alpine.DEB.1.00.1509031156510.29350@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-for-windows@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:29:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcZFw-0002td-N6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 15:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbbIQN3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 09:29:40 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:32918 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbIQN3k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 09:29:40 -0400
Received: by iofh134 with SMTP id h134so21624375iof.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=veqnrfklcrDxQ7fqJKPBZ2ZmGxsINgAnb2oJHc2BIHc=;
        b=oFnPiYOi6EuoQuQZirHyFSu4bFZr5OHPZt/asAvyitjrsxkawbqlLmkQuEC1yvHDow
         GMdHYzHClQ1pSYShfh7zqsjjMQ1RM5e89NQvqmfpNUcBotkG5c+L1V3W/ib3/rcEKXOC
         xUytXfgn56RwSHNyob0RsfulRgSoPxsRVWzPrLPc/58D1VlT5tDiPqOu3TG95iVM2XBU
         09YA/Nvh1yE4OeywmV8aupSuFs+QY0pUJRaiKwxqggEBgA+1EM2lQ+Rgz5tjYpSb9SPv
         Ltdp3Hco33SGfKl9jue2Edky0OLlPjNDcQO0qU/WfGTFBbO0RxyHR+sHK8AxznkIIuQC
         mTsg==
X-Received: by 10.107.131.134 with SMTP id n6mr6078387ioi.192.1442496579423;
 Thu, 17 Sep 2015 06:29:39 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Thu, 17 Sep 2015 06:29:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1509031156510.29350@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278115>

On Thu, Sep 3, 2015 at 5:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hey all,
>
> yes, it is true: since mid-August I am working for Microsoft. Over a
> year ago, I got into contact with the Visual Studio Online group at
> Microsoft, of which I am now a happy member. A large part of my mission
> is to improve the experience of Git for Windows. This is very exciting
> to me: I finally can focus pretty much full time on something that I
> could only address in my spare time previously.

Is upstreaming msysgit-specific patches in the roadmap? It would be
very nice to have everything in one tree (or at least keep the two
trees as close as possible).
-- 
Duy
