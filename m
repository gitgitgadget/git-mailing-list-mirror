From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Feature Request Google Authenticator Support
Date: Thu, 30 Jan 2014 15:28:09 +0100
Message-ID: <CABPQNSZmvPH-J=r57_WNjq3WOS7m8dGyrj0Y84etF+8aGAMSiA@mail.gmail.com>
References: <20140130040702.GA77226@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Max Rahm <ac90b671@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 15:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8sbu-0001hi-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 15:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbaA3O2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 09:28:50 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:60912 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbaA3O2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 09:28:49 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so3655192oag.23
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8WizGkX3eFkpfV19l+e1I8PDOrYgPS7Br7MN5LjE+ZI=;
        b=y2P6uoVonncbQYH4dTLQPyrK/ILeMFOK3BwHZde0Xpc2KIDxiw5bVUMyAg4ugGZbdh
         ZeAfdKey22qO8ck73fERou9mJIanEFywIyiqjIiXaPl49iscKGl3tv10O1w1r1eTqZCM
         p3Z41pIU3l+Q2CrIjmh0sWlHMFDgeMsBKXeSRbOGvjfkmxG48nstOjT27tqKixXWqKSd
         ToO9+Vq6lXLwhcqgYODZiMtUsWhVqu5cae5w8cr10dJPR6jp7+pn8eZFh54gJIrkSMoU
         Qhdcv3a0get+CUXilW+j4K7Jp0BX8klDM4shsV2BULrbyLxcfspV3xdHcWwOrSghIJ2H
         72Og==
X-Received: by 10.60.103.239 with SMTP id fz15mr11838153oeb.22.1391092129337;
 Thu, 30 Jan 2014 06:28:49 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Thu, 30 Jan 2014 06:28:09 -0800 (PST)
In-Reply-To: <20140130040702.GA77226@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241270>

On Thu, Jan 30, 2014 at 5:07 AM, Max Rahm <ac90b671@gmail.com> wrote:
> Github supports google authenticator 2-step authentication. I enabled it
> and how can't figure out how to connect to my github account through git.
> I've looked pretty hard in the man pages and on google and can't seem to
> find anything on how to set up git to work with a repository with 2-step
> verification. Here's a link to my stackoverflow question with my exact
> problem if there's something I'm missing.
>
> http://stackoverflow.com/questions/21447137/git-github-not-working-with-google-authenticator-osx
>
> As far as I can tell the feature is not supported. I'd like to be able to
> use the 2-step authentication but obviously I'd like to be able to push my
> code :D

This sounds like a question for the GitHub support rather than the Git
community.
