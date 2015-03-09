From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 09:19:28 -0700
Message-ID: <CAJo=hJt_PHMEdpfRA0EKQyoH4XhYh89tvajewM28pgxzZ9ONMg@mail.gmail.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
 <87y4n6kvdu.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:20:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV0PU-0004Va-2X
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 17:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbbCIQTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 12:19:54 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:33041 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbbCIQTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 12:19:49 -0400
Received: by yhl29 with SMTP id 29so36610684yhl.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iNLodRaemveih6Qeq86cAq/kL29qizwPff0zIJNoZFM=;
        b=J7msIXrBoNARGq/ayl66OPVsSaU2pyCRy8x+Kv9EqOL1nhG3766LLg/VjKOlIfG5Ag
         8S2c5qrZhl7caCDnfSsP7YqT0WBjv6rPA0nRHG41dOY1KG7KIqsAijrnEt9T1QLZ4hGe
         aiy6yJbnXe8ZZlFVCFZtSvgrOyD5ABlldilxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iNLodRaemveih6Qeq86cAq/kL29qizwPff0zIJNoZFM=;
        b=gWPSSFuHkZcFm4whxnDGAEwNuOpIToCBlv0S6mGB6KHdb9ZWpQBsNY+58mJDseQ33t
         fiCZ3CIqg4TNRVpkDm+O6Hlal7LZs+NvJeswYl6jw9Ry1qlaSL4KEmRBoOSWdGYx5CBF
         UT8GXgASGVSo7BypkmRNfcGs5z0RxOl0ItMLuP3/TIRxMVy87whbL/BCmYvPtWFTaYdP
         LKyzL4gcX08UIW+GSMvI27EGzDJiHr4wHWRB9ZT3HKoEII87SGII/TDe/plCJcIJD8Ie
         k0OFg5ZBBOVUsqXFpWnkWAGjzlaFam7SZ6gFO2ce0O8HbGMCEMQGiHchvYzbNLfcUbr6
         re0w==
X-Gm-Message-State: ALoCoQnPO7xr0OYuSHSn19MbFg874/CtEAf+hRwSLXkLZBFUvu4RGBh/+kbUzRw6OsHzD2QPN1GP
X-Received: by 10.170.196.205 with SMTP id n196mr30764043yke.26.1425917988913;
 Mon, 09 Mar 2015 09:19:48 -0700 (PDT)
Received: by 10.170.39.19 with HTTP; Mon, 9 Mar 2015 09:19:28 -0700 (PDT)
In-Reply-To: <87y4n6kvdu.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265174>

On Mon, Mar 9, 2015 at 9:06 AM, David Kastrup <dak@gnu.org> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Mon, Mar 9, 2015 at 6:57 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>>
>>> Since we're talking business: git-scm.com still looks a bit like a
>>> ProGit/Github promotion site. I don't have anything against either, and
>>> git-scm.com provides a lot of the information that users are looking
>>> for, and that are hard to find anywhere else; it's a landing page. It
>>> just does not look like a "project home".
>>
>> Yes, git-scm.com is a place to point people.
>
> It features "Companies & Projects Using Git" at the bottom.  Not
> "supporting" but "using".
>
> Linux is point 10 on that list.  The first 6 items are Google, facebook,
> Microsoft, Twitter, LinkedIn, and Netflix.
>
> Even for an OpenSource project that does not buy into the Free Software
> philosophy, that is a mostly embarrassing list of companies to advertise
> for.
>
> Personally, I consider the recent migration of the Emacs repository to
> Git a bigger endorsement but then that's me.
>
> It might make sense to reduce this list just to "Projects" since those
> are actually more tangible and verifiable.  Or scrap it altogether.

At the bottom of the git-scm.com page there is this blurb:

  This open sourced site is hosted on GitHub.
  Patches, suggestions and comments are welcome

And that text contains a link to the GitHub repository[1] where anyone
can propose modifications to the page. Unfortunately I don't know of
anyone paying out contribution stipends for content changes made to
git-scm.com.


[1] https://github.com/git/git-scm.com/blob/master/README.md#contributing
